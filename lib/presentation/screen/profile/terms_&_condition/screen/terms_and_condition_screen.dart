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

  /// Reusable Section Widget
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
            height: 1.6, // 🔥 Perfect readable line height
          ),
        ),
      ],
    );
  }
}