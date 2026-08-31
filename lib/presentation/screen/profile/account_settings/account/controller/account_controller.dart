import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/helper/local_db/local_db.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';

import '../../../profile/controller/profile_controller.dart';

class AccountController extends GetxController {
  late final List<ProfileMenuItem> menuItems;

  @override
  void onInit() {
    super.onInit();

    final profileCtrl = Get.isRegistered<ProfileController>()
        ? Get.find<ProfileController>()
        : null;
    final isDriverMode = profileCtrl != null
        ? profileCtrl.isDriverMode
        : SharePrefsHelper.isDriverMode;
    final canSwitchToDriver = profileCtrl?.canSwitchToDriverMode ?? false;

    menuItems = [
      // A user in driver mode manages their info via Driver Profile;
      // Edit Profile (the plain user-info screen) only applies in
      // user mode.
      if (!isDriverMode)
        ProfileMenuItem(
          title: AppStrings.editProfile.tr,
          icon: Icons.edit_outlined,
          onTap: () {
            Get.toNamed(RoutePath.editProfile);
          },
        ),
      if (isDriverMode)
        ProfileMenuItem(
          title: AppStrings.driverProfile.tr,
          icon: Icons.person_outline_rounded,
          onTap: () {
            Get.toNamed(RoutePath.driverProfile);
          },
        ),
      ProfileMenuItem(
        title: AppStrings.changePassword.tr,
        icon: Icons.diamond_outlined,
        onTap: () {
          Get.toNamed(RoutePath.changePassword);
        },
      ),
      ProfileMenuItem(
        title: AppStrings.bankCard.tr,
        icon: Icons.credit_card_outlined,
        onTap: () {
          Get.toNamed(RoutePath.bankCard);
        },
      ),
      // Only offer switching once there's actually an approved driver
      // profile to switch into/out of.
      if (isDriverMode || canSwitchToDriver)
        ProfileMenuItem(
          title: isDriverMode
              ? AppStrings.switchToUserMode.tr
              : AppStrings.switchToDriverMode.tr,
          icon: Icons.swap_horiz_rounded,
          onTap: () {
            final ProfileController ctrl =
                profileCtrl ?? Get.put(ProfileController());
            ctrl.switchMode();
          },
        ),
    ];
  }
}
