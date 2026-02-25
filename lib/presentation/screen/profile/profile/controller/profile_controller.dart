import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/routes/route_path.dart';

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
  RxString profileImage = ''.obs; // set asset or network path

  late final List<ProfileMenuItem> menuItems;

  @override
  void onInit() {
    super.onInit();
    menuItems = [
      ProfileMenuItem(
        title: 'Account Settings',
        icon: Icons.settings_outlined,
        onTap: () {
          Get.toNamed(RoutePath.account);// TODO: Get.toNamed(RoutePath.accountSettings);
        },
      ),
      ProfileMenuItem(
        title: 'Language',
        icon: Icons.language_outlined,
        onTap: () {
          Get.toNamed(RoutePath.profileLanguage);
        },
      ),
      ProfileMenuItem(
        title: 'Contact & Support',
        icon: Icons.help_outline_rounded,
        onTap: () {
          Get.toNamed(RoutePath.contactAndSupport);
        },
      ),
      ProfileMenuItem(
        title: 'Terms & Condition',
        icon: Icons.description_outlined,
        onTap: () {
          Get.toNamed(RoutePath.termAndCondition);
        },
      ),
      ProfileMenuItem(
        title: 'Privacy & Policy',
        icon: Icons.privacy_tip_outlined,
        onTap: () {
          Get.toNamed(RoutePath.policyAndPrivacy);

        },
      ),
      ProfileMenuItem(
        title: 'Logout',
        icon: Icons.logout_rounded,
        iconColor: Colors.red,
        onTap: () {
          // TODO: show logout confirmation
        },
      ),
    ];
  }
}