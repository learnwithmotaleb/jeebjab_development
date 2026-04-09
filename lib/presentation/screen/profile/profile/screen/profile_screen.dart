import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/utils/assets_image/app_images.dart';
import 'package:jeebjab/widget/custom_appbar.dart';

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
    return ResponsiveLayout(
      mobile: _buildMobile(),
      tablet: _buildTablet(),
    );
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

  Widget _buildTablet() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        child: Obx(() => Column(
          children: [

            // ── 1. Teal Header (Full Width) ────────────────────
            ProfileHeaderWidget(
              name: controller.name.value,
              email: controller.email.value,
            ),

            SizedBox(height: Dimensions.h(32)),

            // ── 2. Menu Card Container ────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.w(48),
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 600),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Title ────────────────────────────────
                      Text(
                        "Profile Options",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackColor,
                        ),
                      ),

                      SizedBox(height: Dimensions.h(12)),

                      // ── Subtitle ─────────────────────────────
                      Text(
                        "Manage your profile settings and preferences",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),

                      SizedBox(height: Dimensions.h(32)),

                      // ── Menu Card ────────────────────────────
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(
                            Dimensions.r(16),
                          ),
                          border: Border.all(
                            color: Colors.grey.shade200,
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            Dimensions.r(16),
                          ),
                          child: Column(
                            children: List.generate(
                              controller.menuItems.length,
                                  (index) => Column(
                                children: [
                                  ProfileMenuItemWidget(
                                    item: controller.menuItems[index],
                                    showDivider: false,
                                  ),
                                  if (index <
                                      controller.menuItems.length - 1)
                                    Divider(
                                      height: 1,
                                      color: Colors.grey.shade200,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: Dimensions.h(40)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}