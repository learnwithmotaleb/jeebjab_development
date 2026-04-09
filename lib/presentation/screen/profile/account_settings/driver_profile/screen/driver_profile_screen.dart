import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import 'package:jeebjab/widget/app_button.dart';
import 'package:jeebjab/widget/custom_appbar.dart';

import '../controller/driver_profile_controller.dart';
import '../widget/info_section_card_widget.dart';

class DriverProfileScreen extends StatefulWidget {
  const DriverProfileScreen({super.key});

  @override
  State<DriverProfileScreen> createState() => _DriverProfileScreenState();
}

class _DriverProfileScreenState extends State<DriverProfileScreen> {
  final DriverProfileController controller =
  Get.put(DriverProfileController());

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
      appBar: CommonAppBar(title: AppStrings.driverProfile.tr),
      body: Column(
        children: [
          // ── Scrollable Content ──────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.w(10),
                ),
                child: Column(
                  children: [
                    // ── Driver Information Card ───────────────────────
                    InfoSectionCard(
                      sectionTitle: AppStrings.driverInformation.tr,
                      data: controller.driverInfo,
                    ),

                    // ── Bank Information Card ─────────────────────────
                    InfoSectionCard(
                      sectionTitle:AppStrings.bankInformation.tr,
                      data: controller.bankInfo,
                    ),

                    SizedBox(height: Dimensions.h(24)),
                  ],
                )),
          ),

          // ── Edit Profile Button pinned bottom ───────────────────────
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(
              Dimensions.w(16),
              Dimensions.h(12),
              Dimensions.w(16),
              Dimensions.h(24),
            ),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
            ),
            child: AppButton(
              label: AppStrings.editProfile.tr,
              onPressed: controller.onEditProfile,
              backgroundColor: AppColors.whiteColor,
              textColor: AppColors.primaryColor,
              height: 60,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTablet() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.driverProfile.tr),
      body: Column(
        children: [
          // ── Scrollable Content ──────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.w(48),
                vertical: Dimensions.h(32),
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 700),
                  child: Column(
                    children: [
                      SizedBox(height: Dimensions.h(20)),

                      // ── Icon/Visual ──────────────────────────────────
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(Dimensions.r(20)),
                        ),
                        child: Icon(
                          Icons.person_4_outlined,
                          size: 50,
                          color: AppColors.primaryColor,
                        ),
                      ),

                      SizedBox(height: Dimensions.h(40)),

                      // ── Title ────────────────────────────────────────
                      Center(
                        child: Text(
                          AppStrings.driverProfile.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blackColor,
                          ),
                        ),
                      ),

                      SizedBox(height: Dimensions.h(12)),

                      // ── Subtitle ────────────────────────────────────
                      Center(
                        child: Text(
                          "View your driver profile information",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),

                      SizedBox(height: Dimensions.h(48)),

                      // ── Two Column Layout for Cards ─────────────────
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Left Column - Driver Information
                          Expanded(
                            child: InfoSectionCard(
                              sectionTitle: AppStrings.driverInformation.tr,
                              data: controller.driverInfo,
                            ),
                          ),
                          SizedBox(width: Dimensions.w(24)),
                          // Right Column - Bank Information
                          Expanded(
                            child: InfoSectionCard(
                              sectionTitle: AppStrings.bankInformation.tr,
                              data: controller.bankInfo,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: Dimensions.h(40)),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ── Edit Profile Button pinned bottom ───────────────────────
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(
              Dimensions.w(48),
              Dimensions.h(16),
              Dimensions.w(48),
              Dimensions.h(32),
            ),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 700),
                child: AppButton(
                  label: AppStrings.editProfile.tr,
                  onPressed: controller.onEditProfile,
                  backgroundColor: AppColors.primaryColor,
                  textColor: AppColors.whiteColor,
                  height: Dimensions.h(100),
                ),
              ),
            ),
          ),
          SizedBox(height: Dimensions.h(20)),

        ],
      ),
    );
  }
}