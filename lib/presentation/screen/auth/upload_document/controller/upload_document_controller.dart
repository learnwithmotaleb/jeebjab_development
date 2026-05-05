import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/routes/route_path.dart';
import '../../../../../service/api_service.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../../../../../helper/tost_message/show_snackbar.dart';
import '../../../../../widget/confirmataion_alert.dart';
import '../../../job/be_come_a_driver/controller/be_come_driver_controller.dart';
import '../../choose_vehicle_type/controller/choose_vehicle_type_controller.dart';
import '../../vehicle_information/controller/vehicle_information_controller.dart';
import '../../license_number/controller/license_number_controller.dart';

class UploadDocumentController extends GetxController {
  final ApiClient _apiClient = ApiClient();
  final ImagePicker _picker = ImagePicker();

  var isLoading = false.obs;

  // Track files for specific types
  final RxMap<String, File?> documentFiles = <String, File?>{
    'driving_license': null,
    'vehicle_registration': null,
  }.obs;

  Future<void> pickImage(String docType) async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      documentFiles[docType] = File(picked.path);
    }
  }

  void removeImage(String docType) {
    documentFiles[docType] = null;
  }

  bool get isAllUploaded => documentFiles.values.every((file) => file != null);

  Future<void> submitBecomeDriver() async {
    // 1. Validate images
    if (!isAllUploaded) {
      AppSnackBar.fail(AppStrings.pleaseUploadAllDocuments.tr);
      return;
    }

    isLoading.value = true;
    try {
      // 2. Collect data from all controllers
      final becomeDriverCtrl = Get.find<BecomeDriverController>();
      final vehicleTypeCtrl = Get.find<ChooseVehicleTypeController>();
      final vehicleInfoCtrl = Get.find<VehicleInformationController>();
      final licenseCtrl = Get.find<LicenseNumberController>();

      // 3. Prepare fields
      Map<String, String> fields = {
        'driverType': becomeDriverCtrl.selectedTypeString,
        'vehicleType': vehicleTypeCtrl.selectedVehicleType.toLowerCase(),
        'vehicleBrand': vehicleInfoCtrl.vehicleBrand.text.trim(),
        'vehicleModel': vehicleInfoCtrl.vehicleModel.text.trim(),
        'vehicleYear': vehicleInfoCtrl.vehicleYear.text.trim(),
        'licenseNumber': licenseCtrl.licenseNumber.text.trim(),
        'docTypes': jsonEncode(documentFiles.keys.toList()),
      };

      // 4. Prepare files
      List<MultipartFileData> files = [];
      documentFiles.forEach((key, file) {
        if (file != null) {
          files.add(MultipartFileData(key: 'driver_document', path: file.path));
        }
      });

      // 5. Call API
      final response = await _apiClient.postMultipart(
        url: ApiUrl.becomeDriver,
        fields: fields,
        files: files,
        isToken: true,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        AppAlerts.confirm(
          title: AppStrings.success.tr,
          message: response.body['message'] ?? AppStrings.accountCreateSuccess.tr,
          onConfirm: () {
            Get.offAllNamed(RoutePath.bottomNav);
          },
        );
      } else {
        AppSnackBar.fail(response.body['message'] ?? "Submission failed");
      }
    } catch (e) {
      debugPrint("Error submitting become driver: $e");
      AppSnackBar.fail("An unexpected error occurred");
    } finally {
      isLoading.value = false;
    }
  }
}
