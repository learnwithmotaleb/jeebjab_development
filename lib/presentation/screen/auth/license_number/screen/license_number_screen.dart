import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/routes/route_path.dart';

import '../../../../../core/responsive_layout/dimensions.dart';
import '../../../../../core/responsive_layout/responsive_layout.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_text_style/app_text_style.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../../../../../widget/app_button.dart';
import '../../../../../widget/app_text_field.dart';
import '../../../../../widget/custom_appbar.dart';
import '../controller/license_number_controller.dart';

class LicenseNumberScreen extends StatefulWidget {
  const LicenseNumberScreen({super.key});

  @override
  State<LicenseNumberScreen> createState() => _LicenseNumberScreenState();
}

class _LicenseNumberScreenState extends State<LicenseNumberScreen> {
  LicenseNumberController controller = Get.put(LicenseNumberController());

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
      appBar: CommonAppBar(title: ""),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  AppStrings.yourLicenseNumber.tr,
                  style: AppTextStyles.title
              ),

              Text(
                  AppStrings.licenseNumberSubTitle.tr,
                  style: AppTextStyles.body
              ),

              SizedBox(height: Dimensions.h(40)),

              AppTextField(
                controller: controller.licenseNumber,
                hint: AppStrings.enterLicenseNumber.tr,
              ),

              SizedBox(height: Dimensions.h(100)),

              AppButton(
                height: Dimensions.h(50),
                label: AppStrings.continueButton.tr,
                onPressed: () {
                  Get.toNamed(RoutePath.uploadDocument);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTablet() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: ""),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.w(48),
          vertical: Dimensions.h(32),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 520),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Dimensions.h(20)),

                // ── Icon/Visual ──────────────────────────────────────
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(Dimensions.r(20)),
                    ),
                    child: Icon(
                      Icons.card_membership_outlined,
                      size: 50,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),

                SizedBox(height: Dimensions.h(40)),

                // ── Title ────────────────────────────────────────────
                Center(
                  child: Text(
                    AppStrings.yourLicenseNumber.tr,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.title.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: Dimensions.h(12)),

                // ── Subtitle ────────────────────────────────────────
                Center(
                  child: Text(
                    AppStrings.licenseNumberSubTitle.tr,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body.copyWith(
                      fontSize: 15,
                      color: Colors.grey[600],
                    ),
                  ),
                ),

                SizedBox(height: Dimensions.h(40)),

                // ── License Number Field ────────────────────────────
                AppTextField(
                  controller: controller.licenseNumber,
                  hint: AppStrings.enterLicenseNumber.tr,
                ),

                SizedBox(height: Dimensions.h(60)),

                // ── Continue Button ──────────────────────────────────
                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    height: Dimensions.h(100),
                    label: AppStrings.continueButton.tr,
                    onPressed: () {
                      Get.toNamed(RoutePath.uploadDocument);
                    },
                  ),
                ),

                SizedBox(height: Dimensions.h(32)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}