import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jeebjab/widget/confirmataion_alert.dart';

import '../../../../../core/routes/route_path.dart';
import '../../../driver_section/driver_bottom_nav/controller/driver_bottom_nav_controller.dart';

class DeliveryProof {
  final String imageUrl;
  final String category;
  final String title;
  final String price;
  final String currency;
  final String description;
  final String size;
  final String deliveryLocation;
  final String deliveryTime;
  final String publishedTime;

  DeliveryProof({
    required this.imageUrl,
    required this.category,
    required this.title,
    required this.price,
    required this.currency,
    required this.description,
    required this.size,
    required this.deliveryLocation,
    required this.deliveryTime,
    required this.publishedTime,
  });

  // ── Create a copy with updated image ────────────────────────────────────
  DeliveryProof copyWith({String? imageUrl}) {
    return DeliveryProof(
      imageUrl: imageUrl ?? this.imageUrl,
      category: category,
      title: title,
      price: price,
      currency: currency,
      description: description,
      size: size,
      deliveryLocation: deliveryLocation,
      deliveryTime: deliveryTime,
      publishedTime: publishedTime,
    );
  }
}

class DeliveryController extends GetxController {
  // ── Delivery Proof Data ────────────────────────────────────────────────
  final RxBool isDeliveryMarked = false.obs;
  final Rx<File?> capturedImage = Rx<File?>(null);

  late DeliveryProof deliveryProof;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    _initializeDeliveryData();
  }

  void _initializeDeliveryData() {
    deliveryProof = DeliveryProof(
      imageUrl:
      'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=500',
      category: 'Move',
      title: 'Ducati Bike',
      price: '85',
      currency: 'SAR',
      description:
      'To Manage Your Google Play Payment Screen, Open The Play Store App. Tap Your Profile Icon, And Select Payments & Subscriptions. From Here, You Can Manage Payment Methods (Credit Cards, PayPal, Balance), Update Billing And Subscription Info, And View Order History. You Can Also Add Backup Payment Methods For Smoother Transactions.',
      size: 'Medium',
      deliveryLocation: 'Level Shoes District, Dubai Mall',
      deliveryTime: '04:30 Pm',
      publishedTime: 'Published 3 Hours Ago',
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

  // ── Mark as Delivered ──────────────────────────────────────────────────
  void markAsDelivered() {
    isDeliveryMarked.value = true;
    AppAlerts.success(message: "Success Delivery");

    // Switch to JobPostScreen in DriverBottomNav
    try {
      final DriverBottomNavController navSectionController = Get.find<DriverBottomNavController>();
      navSectionController.changeIndex(1); // Set to JobPostScreen index
    } catch (e) {
      // If controller doesn't exist yet, we can't switch index this way, 
      // but Get.offAllNamed will initialize it.
    }

    // Navigate back to Driver Bottom Nav with Jobs tab active
    Future.delayed(const Duration(seconds: 1), () {
      Get.offAllNamed(RoutePath.driverBottomNav, arguments: 1);
    });
  }

  // ── Reset for next delivery ────────────────────────────────────────────
  void reset() {
    isDeliveryMarked.value = false;
    capturedImage.value = null;
    _initializeDeliveryData();
  }
}