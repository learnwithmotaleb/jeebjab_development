import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';

import '../../../profile/controller/profile_controller.dart';

class AccountController extends GetxController {
  late final List<ProfileMenuItem> menuItems;

  @override
  void onInit() {
    super.onInit();
    menuItems = [
      ProfileMenuItem(
        title: AppStrings.editProfile.tr,
        icon: Icons.edit_outlined,
        onTap: () {
         Get.toNamed(RoutePath.editProfile);
        },
      ),
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
    ];
  }
}