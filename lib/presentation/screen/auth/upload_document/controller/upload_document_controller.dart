import 'dart:io';
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
import '../../company_driver_auth/select_company/controller/select_company_controller.dart';
import '../../vehicle_information/controller/vehicle_information_controller.dart';
import '../../license_number/controller/license_number_controller.dart';

class UploadDocumentController extends GetxController {
  final ApiClient _apiClient = ApiClient();
  final ImagePicker _picker = ImagePicker();

  var isLoading = false.obs;

  // Track files for specific types. Each is optional per the API —
  // the field name sent to the backend matches the map key exactly
  // (driving_license, vehicle_registration, insurance, id_proof).
  final RxMap<String, File?> documentFiles = <String, File?>{
    'driving_license': null,
    'vehicle_registration': null,
    'insurance': null,
    'id_proof': null,
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

  Future<void> submitBecomeDriver() async {
    isLoading.value = true;
    try {
      // 1. Collect data from all controllers. SelectCompanyController is only
      // registered when the driver went through the company-onboarding
      // wizard (DriverSignup → SelectCompany → VehicleType → ...); the
      // separate "become a driver from Settings" flow registers
      // BecomeDriverController instead, so support both entry points.
      final vehicleTypeCtrl = Get.find<ChooseVehicleTypeController>();
      final vehicleInfoCtrl = Get.find<VehicleInformationController>();
      final licenseCtrl = Get.find<LicenseNumberController>();

      final selectCompanyCtrl = Get.isRegistered<SelectCompanyController>()
          ? Get.find<SelectCompanyController>()
          : null;
      final selectedCompany = selectCompanyCtrl?.selectedCompany.value;

      final String driverType;
      if (Get.isRegistered<BecomeDriverController>()) {
        driverType = Get.find<BecomeDriverController>().selectedTypeString;
      } else {
        driverType = selectedCompany != null ? "company" : "independent";
      }

      // 2. Required fields
      Map<String, String> fields = {
        'driverType': driverType,
        'vehicleType': vehicleTypeCtrl.selectedVehicleType.toLowerCase(),
        'licenseNumber': licenseCtrl.licenseNumber.text.trim(),
      };

      // 3. Optional vehicle fields — only send when filled in
      void addIfNotEmpty(String key, String value) {
        if (value.isNotEmpty) fields[key] = value;
      }

      addIfNotEmpty('vehicleBrand', vehicleInfoCtrl.vehicleBrand.text.trim());
      addIfNotEmpty('vehicleModel', vehicleInfoCtrl.vehicleModel.text.trim());
      addIfNotEmpty('vehicleYear', vehicleInfoCtrl.vehicleYear.text.trim());

      // 4. Company details — required only when driverType is "company"
      if (driverType == "company" && selectedCompany != null) {
        fields['companyId'] = selectedCompany.id;
        fields['companyName'] = selectedCompany.name;
        // Note: the "ID" box on the select-company screen is an
        // auto-filled, read-only display of the company's own _id
        // (== companyId above) — there's no separate badge/employee ID
        // input in this flow, so companyDriverId is left unsent.
      }

      // 5. Optional documents — each uploaded under its own field name
      // (driving_license, vehicle_registration, insurance, id_proof).
      List<MultipartFileData> files = [];
      documentFiles.forEach((key, file) {
        if (file != null) {
          files.add(MultipartFileData(key: key, path: file.path));
        }
      });

      // 6. Call API
      final response = await _apiClient.postMultipart(
        url: ApiUrl.becomeDriver,
        fields: fields,
        files: files,
        isToken: true,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        AppAlerts.confirm(
          title: AppStrings.success.tr,
          message:
              response.body['message'] ?? AppStrings.accountCreateSuccess.tr,
          onConfirm: () {
            Get.offAllNamed(RoutePath.bottomNav);
          },
        );
      } else {
        // Handle specific failure cases or general errors
        String errorMsg = response.body['message'] ?? "Submission failed";
        AppSnackBar.fail(errorMsg);
      }
    } catch (e) {
      debugPrint("Error submitting become driver: $e");
      AppSnackBar.fail("An unexpected error occurred");
    } finally {
      isLoading.value = false;
    }
  }
}
