import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:jeebjab/core/routes/route_path.dart';

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
                Image.asset(
                  AppImages.completeVerificationImage,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),

                SizedBox(height: Dimensions.h(32)),

                Text(
                  AppStrings.thankYouForTrustingUs.tr,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.title.copyWith(
                    color: AppColors.blackColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: Dimensions.h(12)),

                Text(
                  AppStrings.completeVerificationSubTitle.tr,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.blackColor

                  ),
                ),

                SizedBox(height: Dimensions.h(40)),

                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    label: AppStrings.continueButton.tr,
                    onPressed: () {
                      Get.toNamed(RoutePath.bottomNav);
                    },
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