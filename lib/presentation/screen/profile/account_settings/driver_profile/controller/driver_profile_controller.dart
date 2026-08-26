import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';

import '../../../../../../service/api_service.dart';
import '../../../../../../service/api_url.dart';
import '../../../profile/model/user_model.dart';

class DriverProfileController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  final RxBool isLoading = false.obs;

  // ── Driver Information ────────────────────────────────────────────────────
  final RxMap<String, String> driverInfo = <String, String>{}.obs;

  // ── Bank Information ──────────────────────────────────────────────────────
  final RxMap<String, String> bankInfo = <String, String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  Future<void> getProfile() async {
    isLoading.value = true;
    try {
      final response = await _apiClient.get(
        url: ApiUrl.getDriverProfile,
        isToken: true,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final user = UserModel.fromJson(response.body);
        final driver = user.driverProfile;

        driverInfo.value = {
          AppStrings.driverName.tr: user.name,
          AppStrings.licenseNumber.tr: driver?.licenseNumber ?? '-',
          AppStrings.vehicleType.tr: driver?.vehicleType ?? '-',
          AppStrings.brand.tr: driver?.vehicleBrand ?? '-',
          AppStrings.model.tr: driver?.vehicleModel ?? '-',
          AppStrings.contactNumber.tr: user.phoneNumber ?? '-',
          AppStrings.contactEmail.tr: user.email,
        };

        bankInfo.value = {
          AppStrings.bankName.tr: driver?.bankInfo?.bankName ?? '-',
          AppStrings.accountHolderName.tr: driver?.bankInfo?.accountHolderName ?? '-',
          AppStrings.accountNumber.tr: driver?.bankInfo?.accountNumber ?? '-',
        };
      }
    } catch (e) {
      debugPrint("Error fetching driver profile: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void onEditProfile() {
    Get.toNamed(RoutePath.editDriverProfile);
  }
}
