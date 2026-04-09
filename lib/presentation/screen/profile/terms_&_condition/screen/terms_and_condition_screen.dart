import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/utils/app_text_style/app_text_style.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import 'package:jeebjab/widget/custom_appbar.dart';

import '../../../../../core/responsive_layout/responsive_layout.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../controller/terms_and_condition_controller.dart';

class TermsAndConditionScreen extends StatefulWidget {
  const TermsAndConditionScreen({super.key});

  @override
  State<TermsAndConditionScreen> createState() =>
      _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState
    extends State<TermsAndConditionScreen> {

  final controller = Get.put(TermsAndConditionController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobile(),
      tablet: _buildTablet(),
    );
  }

  /// Mobile Layout
  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar:  CommonAppBar(title: AppStrings.termsAndConditions.tr),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Overview Section
              _buildSection(
                title: AppStrings.overviewOfService.tr,
                description: controller.overview.value,
              ),

              SizedBox(height: Dimensions.h(32)),

              /// User Eligibility Section
              _buildSection(
                title:AppStrings.userEligibility.tr,
                description: controller.userEligibility.value,
              ),

              SizedBox(height: Dimensions.h(24)),
            ],
          ),
        ),
      ),
    );
  }

  /// Tablet Layout
  Widget _buildTablet() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.termsAndConditions.tr),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.w(48),
            vertical: Dimensions.h(32),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 700),
              child: Column(
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
                        Icons.description_outlined,
                        size: 50,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),

                  SizedBox(height: Dimensions.h(40)),

                  // ── Section Title ────────────────────────────────────
                  Center(
                    child: Text(
                      AppStrings.termsAndConditions.tr,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.title.copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(height: Dimensions.h(12)),

                  // ── Section Subtitle ────────────────────────────────
                  Center(
                    child: Text(
                      "Please read our terms and conditions carefully",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body.copyWith(
                        fontSize: 15,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),

                  SizedBox(height: Dimensions.h(48)),

                  /// Overview Section
                  _buildTabletSection(
                    title: AppStrings.overviewOfService.tr,
                    description: controller.overview.value,
                  ),

                  SizedBox(height: Dimensions.h(48)),

                  /// User Eligibility Section
                  _buildTabletSection(
                    title: AppStrings.userEligibility.tr,
                    description: controller.userEligibility.value,
                  ),

                  SizedBox(height: Dimensions.h(40)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Reusable Section Widget for Mobile
  Widget _buildSection({
    required String title,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.title.copyWith(
            color: AppColors.blackColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: Dimensions.h(12)),
        Text(
          description,
          style: AppTextStyles.body.copyWith(
            color: AppColors.blackColor.withOpacity(0.7),
            height: 1.6, // Perfect readable line height
          ),
        ),
      ],
    );
  }

  /// Reusable Section Widget for Tablet
  Widget _buildTabletSection({
    required String title,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.title.copyWith(
            fontSize: 22,
            color: AppColors.blackColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: Dimensions.h(16)),
        Text(
          description,
          style: AppTextStyles.body.copyWith(
            fontSize: 15,
            color: AppColors.blackColor.withOpacity(0.75),
            height: 1.8, // Better line height for tablet
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}