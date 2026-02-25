import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/routes/route_path.dart';

import '../../../profile/controller/profile_controller.dart';

class AccountController extends GetxController {
  late final List<ProfileMenuItem> menuItems;

  @override
  void onInit() {
    super.onInit();
    menuItems = [
      ProfileMenuItem(
        title: 'Edit Profile',
        icon: Icons.edit_outlined,
        onTap: () {
         Get.toNamed(RoutePath.editProfile);
        },
      ),
      ProfileMenuItem(
        title: 'Driver Profile',
        icon: Icons.person_outline_rounded,
        onTap: () {
          Get.toNamed(RoutePath.driverProfile);
        },
      ),
      ProfileMenuItem(
        title: 'Change Password',
        icon: Icons.diamond_outlined,
        onTap: () {
          Get.toNamed(RoutePath.changePassword);

        },
      ),
      ProfileMenuItem(
        title: 'Bank Card',
        icon: Icons.credit_card_outlined,
        onTap: () {
          Get.toNamed(RoutePath.bankCard);

        },
      ),
    ];
  }
}