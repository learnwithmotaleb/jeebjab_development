import 'dart:io';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jeebjab/helper/tost_message/show_snackbar.dart';
import 'package:jeebjab/service/api_service.dart';
import 'package:jeebjab/service/api_url.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import 'package:jeebjab/widget/confirmataion_alert.dart';

import '../../../../../core/routes/route_path.dart';
import '../../../driver_section/driver_bottom_nav/controller/driver_bottom_nav_controller.dart';
import '../../../driver_section/driver_bottom_nav/page/task/controller/task_controller.dart';

/// Snapshot of the task being delivered, for display only — populated by
/// [DeliveryController.bindTask] from real `/driver/tasks` data right
/// before the proof/upload flow starts.
class DeliveryProof {
  final String imageUrl;
  final String category;
  final String title;
  final num price;
  final String description;
  final String size;
  final String deliveryLocation;
  final String publishedTime;

  DeliveryProof({
    required this.imageUrl,
    required this.category,
    required this.title,
    required this.price,
    required this.description,
    required this.size,
    required this.deliveryLocation,
    required this.publishedTime,
  });

  // ── Create a copy with updated image ────────────────────────────────────
  DeliveryProof copyWith({String? imageUrl}) {
    return DeliveryProof(
      imageUrl: imageUrl ?? this.imageUrl,
      category: category,
      title: title,
      price: price,
      description: description,
      size: size,
      deliveryLocation: deliveryLocation,
      publishedTime: publishedTime,
    );
  }
}

class DeliveryController extends GetxController {
  final ApiClient _apiClient = ApiClient();
  final ImagePicker _imagePicker = ImagePicker();

  // ── The task this delivery flow is completing ──────────────────────────
  // Set by bindTask() right when the driver taps "Deliver" — this
  // controller is a permanent, app-wide singleton (see main.dart), so it
  // carries this id through the Proof dialog → camera → DeliveryScreen
  // navigation chain.
  String _taskId = '';

  final RxBool isDeliveryMarked = false.obs;
  final RxBool isSubmitting = false.obs;
  final Rx<File?> capturedImage = Rx<File?>(null);

  late DeliveryProof deliveryProof;

  @override
  void onInit() {
    super.onInit();
    deliveryProof = _blankProof();
  }

  DeliveryProof _blankProof() => DeliveryProof(
    imageUrl: '',
    category: '',
    title: '',
    price: 0,
    description: '',
    size: '',
    deliveryLocation: '',
    publishedTime: '',
  );

  /// Binds this flow to a real task before the proof/upload flow starts.
  void bindTask({
    required String taskId,
    required String title,
    required String category,
    required num price,
    required String description,
    required String size,
    required String deliveryLocation,
    required String publishedTime,
    String? imageUrl,
  }) {
    _taskId = taskId;
    capturedImage.value = null;
    isDeliveryMarked.value = false;
    deliveryProof = DeliveryProof(
      imageUrl: imageUrl ?? '',
      category: category,
      title: title,
      price: price,
      description: description,
      size: size,
      deliveryLocation: deliveryLocation,
      publishedTime: publishedTime,
    );
  }

  // ── Open Camera & Capture Image ────────────────────────────────────────
  Future<void> captureImageFromCamera() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );

      if (image != null) {
        capturedImage.value = File(image.path);
        // Navigate to Delivery Screen to show captured image
        Get.toNamed(
          RoutePath.deliveryScreen,
          arguments: {'capturedImage': File(image.path)},
        );
      }
    } catch (e) {
      AppAlerts.error(message: 'Failed to capture image: $e');
    }
  }

  // ── Open Gallery & Pick Image ──────────────────────────────────────────
  Future<void> pickImageFromGallery() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (image != null) {
        capturedImage.value = File(image.path);
        // Navigate to Delivery Screen to show captured image
        Get.toNamed(
          RoutePath.deliveryScreen,
          arguments: {'capturedImage': File(image.path)},
        );
      }
    } catch (e) {
      AppAlerts.error(message: 'Failed to pick image: $e');
    }
  }

  // ── Update Delivery Proof with Captured Image ──────────────────────────
  void updateDeliveryProofImage(String imagePath) {
    deliveryProof = deliveryProof.copyWith(imageUrl: imagePath);
  }

  // ── Mark as Delivered — PATCH /driver/tasks/:id/status (multipart) ─────
  // Required by the API: status=completed, lat, lng, completion_photo.
  // address is optional but sent when available (a client-side reverse
  // geocode) so the backend skips a paid lookup of its own.
  Future<void> markAsDelivered() async {
    if (_taskId.isEmpty) {
      AppSnackBar.fail(AppStrings.failedToUpdateTaskStatus.tr);
      return;
    }
    if (capturedImage.value == null) {
      AppSnackBar.fail(AppStrings.completionPhotoRequired.tr);
      return;
    }

    isSubmitting.value = true;
    try {
      final position = await _currentPosition();
      if (position == null) {
        AppSnackBar.fail(AppStrings.locationRequiredForDelivery.tr);
        return;
      }

      final address =
          await _reverseGeocode(position) ?? deliveryProof.deliveryLocation;

      final response = await _apiClient.patchMultipart(
        url: ApiUrl.updateTaskStatus(_taskId),
        fields: {
          'status': 'completed',
          'lat': position.latitude.toString(),
          'lng': position.longitude.toString(),
          if (address.isNotEmpty) 'address': address,
        },
        files: [
          MultipartFileData(
            key: 'completion_photo',
            path: capturedImage.value!.path,
          ),
        ],
        isToken: true,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        isDeliveryMarked.value = true;
        AppAlerts.success(message: AppStrings.deliverySuccessfullyCompleted.tr);

        // The task list isn't visible right now, but refresh it in the
        // background so it's up to date (task moved to Completed) by the
        // time the driver lands back on it below.
        if (Get.isRegistered<TaskController>()) {
          final taskController = Get.find<TaskController>();
          taskController.fetchActiveTasks();
          taskController.fetchCompletedTasks();
        }

        try {
          Get.find<DriverBottomNavController>().changeIndex(1);
        } catch (_) {
          // Bottom nav controller not mounted yet — Get.offAllNamed below
          // will rebuild it fresh with the Jobs tab already selected.
        }

        Future.delayed(const Duration(milliseconds: 1500), () {
          Get.offAllNamed(RoutePath.driverBottomNav, arguments: 1);
        });
      } else {
        AppSnackBar.fail(
          response.body['message'] ?? AppStrings.failedToUpdateTaskStatus.tr,
        );
      }
    } catch (e) {
      AppSnackBar.fail(AppStrings.failedToUpdateTaskStatus.tr);
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<Position?> _currentPosition() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return null;
      }
      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
    } catch (_) {
      return null;
    }
  }

  Future<String?> _reverseGeocode(Position position) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isEmpty) return null;

      final place = placemarks.first;
      final parts = [
        place.street,
        place.subLocality,
        place.locality,
        place.country,
      ].where((p) => p != null && p.isNotEmpty).toList();

      return parts.isEmpty ? null : parts.join(', ');
    } catch (_) {
      return null;
    }
  }

  // ── Reset for next delivery ────────────────────────────────────────────
  void reset() {
    _taskId = '';
    isDeliveryMarked.value = false;
    capturedImage.value = null;
    deliveryProof = _blankProof();
  }
}
