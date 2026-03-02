import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/widget/app_confirmation_alert.dart';
import 'package:jeebjab/widget/confirmataion_alert.dart';

import '../../../../../helper/local_db/local_db.dart';
import '../../../../../helper/tost_message/show_snackbar.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../../../../../widget/custom_alert.dart';

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
  RxString name = 'Rayyan Hassan'.obs;
  RxString email = 'rayyan6352@mail.com'.obs;
  RxString profileImage = ''.obs;



  // ✅ getter বানাও — প্রতিবার call হলে fresh .tr নেবে
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
          onConfirm: () => Get.back(),
        );
      },
    ),
  ];
}