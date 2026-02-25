import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../../../../../core/responsive_layout/dimensions.dart';
import '../../../../../core/responsive_layout/responsive_layout.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_text_style/app_text_style.dart';
import '../../../../../widget/custom_appbar.dart';
import '../controller/privacy_and_policy_controller.dart';

class PrivacyAndPolicyScreen extends StatefulWidget {
  const PrivacyAndPolicyScreen({super.key});

  @override
  State<PrivacyAndPolicyScreen> createState() => _PrivacyAndPolicyScreenState();
}

class _PrivacyAndPolicyScreenState extends State<PrivacyAndPolicyScreen> {
  final controller = Get.put(PrivacyAndPolicyController());

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
      appBar: const CommonAppBar(title: "Privacy And Policy"),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Overview Section
              _buildSection(
                title: "Payments",
                description: controller.payments.value,
              ),

              SizedBox(height: Dimensions.h(32)),

              /// User Eligibility Section
              _buildSection(
                title: "Cancellations & Refunds",
                description: controller.cancellations.value,
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
