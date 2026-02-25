import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
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
    return ResponsiveLayout(mobile: _buildMobile());
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: "Driver Profile"),
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
                    sectionTitle: 'Driver Information',
                    data: controller.driverInfo,
                  ),



                  // ── Bank Information Card ─────────────────────────
                  InfoSectionCard(
                    sectionTitle: 'Bank Information',
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
            child: AppButton(label: 'Edit Profile',
              onPressed: controller.onEditProfile,
              backgroundColor: AppColors.whiteColor,
              textColor: AppColors.primaryColor,
              height: 60,
            )
          ),

        ],
      ),
    );
  }
}