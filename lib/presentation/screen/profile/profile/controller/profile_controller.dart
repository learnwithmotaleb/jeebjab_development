import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart' as g_auth;
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/widget/app_confirmation_alert.dart';
import 'package:jeebjab/widget/confirmataion_alert.dart';

import '../../../../../helper/local_db/local_db.dart';
import '../../../../../helper/tost_message/show_snackbar.dart';
import '../../../../../service/api_service.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../../../../../widget/custom_alert.dart';
import '../model/user_model.dart';

class ProfileMenuItem {
  final String title;
  final IconData icon;
  final Color? iconColor;
  final VoidCallback onTap;

  ProfileMenuItem({
    required this.title,
    required this.icon,
    this.iconColor,
    required this.onTap,
  });
}

class ProfileController extends GetxController {
  final ApiClient _apiClient = ApiClient();
  
  var isLoading = false.obs;
  var userData = Rxn<UserModel>();

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  Future<void> getProfile() async {
    isLoading.value = true;
    try {
      final response = await _apiClient.get(
        url: ApiUrl.getUserProfile,
        isToken: true,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final userModel = UserModel.fromJson(response.body);
        userData.value = userModel;
      } else {
        // Handle error but don't show snackbar every time if it's a silent fetch
        // AppSnackBar.fail(response.body['message'] ?? "Failed to fetch profile");
      }
    } catch (e) {
      debugPrint("Error fetching profile: $e");
    } finally {
      isLoading.value = false;
    }
  }

  List<ProfileMenuItem> get menuItems => [
    ProfileMenuItem(
      title: AppStrings.accountSetting.tr,
      icon: Icons.settings_outlined,
      onTap: () => Get.toNamed(RoutePath.account),
    ),
    ProfileMenuItem(
      title: AppStrings.language.tr,
      icon: Icons.language_outlined,
      onTap: () => Get.toNamed(RoutePath.profileLanguage),
    ),
    ProfileMenuItem(
      title: AppStrings.contactAndSupport.tr,
      icon: Icons.help_outline_rounded,
      onTap: () => Get.toNamed(RoutePath.contactAndSupport),
    ),
    ProfileMenuItem(
      title: AppStrings.termsAndCondition.tr,
      icon: Icons.description_outlined,
      onTap: () => Get.toNamed(RoutePath.termAndCondition),
    ),
    ProfileMenuItem(
      title: AppStrings.privacyPolicy.tr,
      icon: Icons.privacy_tip_outlined,
      onTap: () => Get.toNamed(RoutePath.policyAndPrivacy),
    ),
    ProfileMenuItem(
      title: AppStrings.logOut.tr,
      icon: Icons.logout_rounded,
      iconColor: Colors.red,
      onTap: () {
        AppAlerts.confirm(
          title: AppStrings.areYourSureLogout.tr,
          message: AppStrings.areYourSureLogoutFrom.tr,
          onConfirm: () async {
            try {
              await FirebaseAuth.instance.signOut();
              await g_auth.GoogleSignIn.instance.signOut();
            } catch (e) {
              debugPrint("Error signing out from Firebase/Google: $e");
            }
            await SharePrefsHelper.clearAll();
            Get.offAllNamed(RoutePath.login);
          },
        );
      },
    ),
  ];
}