import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../../../core/responsive_layout/dimensions.dart';
import '../../../../../core/responsive_layout/responsive_layout.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_text_style/app_text_style.dart';
import '../../../../../utils/assets_image/app_images.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../../../../../widget/app_button.dart';

class CompleteVarificationScreen extends StatefulWidget {
  const CompleteVarificationScreen({super.key});

  @override
  State<CompleteVarificationScreen> createState() =>
      _CompleteVarificationScreenState();
}

class _CompleteVarificationScreenState
    extends State<CompleteVarificationScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobile: _buildMobile());
  }

  /// Mobile Layout
  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w(24)),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Image
                Image.asset(
                  AppImages.completeVerificationImage,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),

                SizedBox(height: Dimensions.h(32)),

                /// Title
                Text(
                  "Thank you for trusting us!",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.title.copyWith(
                    color: AppColors.blackColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: Dimensions.h(12)),

                /// Subtitle
                Text(
                  "Reliable moving, delivery, buying, recycling, and giveaways — all in one trusted app.",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.greyColor,
                    fontSize:14,
                    height: 1.5,
                  ),
                ),

                SizedBox(height: Dimensions.h(40)),

                /// Button
                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    label: AppStrings.continueButton.tr,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
