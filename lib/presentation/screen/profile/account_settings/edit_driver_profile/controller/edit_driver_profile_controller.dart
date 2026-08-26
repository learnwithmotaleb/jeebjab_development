import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../helper/tost_message/show_snackbar.dart';
import '../../../../../../service/api_service.dart';
import '../../../../../../service/api_url.dart';
import '../../../profile/model/user_model.dart';
import '../../driver_profile/controller/driver_profile_controller.dart';

class EditDriverProfileController extends GetxController {
  final ApiClient _apiClient = ApiClient();
  final ImagePicker _picker = ImagePicker();

  // ── Driver Info Fields (submitted to PATCH /driver/profile) ───────────────
  final TextEditingController licenseNumberController = TextEditingController();
  final TextEditingController vehicleTypeController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController vehicleYearController = TextEditingController();

  // ── Read-only display fields (not part of this endpoint's contract) ──────
  final TextEditingController driverNameController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController contactEmailController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController accountHolderController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();

  // ── Documents (driving_license / vehicle_registration / insurance) ───────
  final RxMap<String, File?> documentFiles = <String, File?>{
    'driving_license': null,
    'vehicle_registration': null,
    'insurance': null,
  }.obs;
  final RxMap<String, bool> alreadyUploaded = <String, bool>{
    'driving_license': false,
    'vehicle_registration': false,
    'insurance': false,
  }.obs;

  final RxBool isLoading = false.obs;
  final RxBool isUpdating = false.obs;

  @override
  void onInit() {
    super.onInit();
    _prefillFromCurrentProfile();
  }

  Future<void> _prefillFromCurrentProfile() async {
    isLoading.value = true;
    try {
      final response = await _apiClient.get(
        url: ApiUrl.getDriverProfile,
        isToken: true,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final user = UserModel.fromJson(response.body);
        final driver = user.driverProfile;

        driverNameController.text = user.name;
        contactNumberController.text = user.phoneNumber ?? '';
        contactEmailController.text = user.email;

        if (driver != null) {
          licenseNumberController.text = driver.licenseNumber;
          vehicleTypeController.text = driver.vehicleType;
          brandController.text = driver.vehicleBrand;
          modelController.text = driver.vehicleModel;
          vehicleYearController.text =
          driver.vehicleYear > 0 ? driver.vehicleYear.toString() : '';

          bankNameController.text = driver.bankInfo?.bankName ?? '';
          accountHolderController.text = driver.bankInfo?.accountHolderName ?? '';
          accountNumberController.text = driver.bankInfo?.accountNumber ?? '';

          for (final doc in driver.documents) {
            if (alreadyUploaded.containsKey(doc.docType)) {
              alreadyUploaded[doc.docType] = true;
            }
          }
        }
      }
    } catch (e) {
      debugPrint("Error fetching driver profile for edit: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickDocument(String docType) async {
    final XFile? picked = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (picked != null) {
      documentFiles[docType] = File(picked.path);
    }
  }

  void removeDocument(String docType) {
    documentFiles[docType] = null;
  }

  bool get isValid =>
      vehicleTypeController.text.trim().isNotEmpty ||
          brandController.text.trim().isNotEmpty ||
          modelController.text.trim().isNotEmpty ||
          vehicleYearController.text.trim().isNotEmpty ||
          licenseNumberController.text.trim().isNotEmpty ||
          documentFiles.values.any((f) => f != null);

  Future<void> onUpdateProfile() async {
    if (!isValid) {
      AppSnackBar.fail("Nothing to update");
      return;
    }
    if (isUpdating.value) return;

    isUpdating.value = true;
    try {
      // "Only send fields you want to change" — skip anything left blank.
      final fields = <String, String>{
        if (vehicleTypeController.text.trim().isNotEmpty)
          'vehicleType': vehicleTypeController.text.trim(),
        if (brandController.text.trim().isNotEmpty)
          'vehicleBrand': brandController.text.trim(),
        if (modelController.text.trim().isNotEmpty)
          'vehicleModel': modelController.text.trim(),
        if (vehicleYearController.text.trim().isNotEmpty)
          'vehicleYear': vehicleYearController.text.trim(),
        if (licenseNumberController.text.trim().isNotEmpty)
          'licenseNumber': licenseNumberController.text.trim(),
      };

      final files = <MultipartFileData>[];
      documentFiles.forEach((docType, file) {
        if (file != null) {
          files.add(MultipartFileData(key: docType, path: file.path));
        }
      });

      final response = await _apiClient.patchMultipart(
        url: ApiUrl.updateDriverProfile,
        fields: fields,
        files: files,
        isToken: true,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (Get.isRegistered<DriverProfileController>()) {
          Get.find<DriverProfileController>().getProfile();
        }
        // Pop first, then show the snackbar — showing it right before
        // Get.back() risks the overlay tearing down mid-pop and the
        // snackbar never actually rendering.
        Get.back();
        AppSnackBar.success("Driver profile updated successfully");
      } else {
        final message = response.body is Map
            ? (response.body['message']?.toString() ?? "Failed to update profile")
            : "Failed to update profile";
        AppSnackBar.fail(message);
      }
    } catch (e) {
      debugPrint("Error updating driver profile: $e");
      AppSnackBar.fail("Something went wrong. Please try again.");
    } finally {
      isUpdating.value = false;
    }
  }

  @override
  void onClose() {
    driverNameController.dispose();
    licenseNumberController.dispose();
    vehicleTypeController.dispose();
    brandController.dispose();
    modelController.dispose();
    vehicleYearController.dispose();
    contactNumberController.dispose();
    contactEmailController.dispose();
    bankNameController.dispose();
    accountHolderController.dispose();
    accountNumberController.dispose();
    super.onClose();
  }
}
