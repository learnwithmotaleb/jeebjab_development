import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';

import '../controller/profile_controller.dart';
import '../widget/profile_header_widget.dart';
import '../widget/profile_menu_item_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobile: _buildMobile());
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        child: Obx(() => Column(
          children: [
            // ── 1. Teal Header ────────────────────────────────────
            ProfileHeaderWidget(
              name: controller.name.value,
              email: controller.email.value,
            ),

            SizedBox(height: Dimensions.h(16)),

            // ── 2. Menu Card ──────────────────────────────────────
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: Dimensions.w(10)),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius:
                BorderRadius.circular(Dimensions.r(5)),


                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 0,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius:
                BorderRadius.circular(Dimensions.r(16)),
                child: Column(
                  children: List.generate(
                    controller.menuItems.length,
                        (index) => ProfileMenuItemWidget(
                      item: controller.menuItems[index],

                      showDivider: index <
                          controller.menuItems.length - 1,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: Dimensions.h(30)),
          ],
        )),
      ),
    );
  }
}