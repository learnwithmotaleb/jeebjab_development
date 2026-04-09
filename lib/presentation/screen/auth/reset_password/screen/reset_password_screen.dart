import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import 'package:jeebjab/widget/app_button.dart';
import 'package:jeebjab/widget/app_text_field.dart';
import 'package:jeebjab/widget/app_validation.dart';
import 'package:jeebjab/widget/custom_appbar.dart';

import '../../../../../core/responsive_layout/dimensions.dart';
import '../../../../../core/responsive_layout/responsive_layout.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_text_style/app_text_style.dart';
import '../controller/reset_password_controller.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final controller = Get.put(ResetPasswordController());

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
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.resetPassword.tr,
                style: AppTextStyles.body.copyWith(
                  fontSize: 24,
                  color: AppColors.blackColor,
                ),
              ),
              SizedBox(height: Dimensions.h(10)),

              Text(
                AppStrings.createYourNewPassword.tr,
                style: AppTextStyles.body.copyWith(
                  fontSize: 16,
                  color: AppColors.blackColor,
                ),
              ),

              SizedBox(height: Dimensions.h(30)),

              AppTextField(
                controller: controller.newPasswordController,
                focusNode: controller.newPasswordFocus,
                obscure: true,
                validator: AppValidators.required(),
                hint: AppStrings.enterYourNewPassword.tr,
              ),

              SizedBox(height: Dimensions.h(16)),

              AppTextField(
                controller: controller.confirmPasswordController,
                focusNode: controller.confirmPasswordFocus,
                obscure: true,
                validator: AppValidators.confirmPassword(
                  passwordSupplier: () =>
                  controller.newPasswordController.text,
                ),
                hint: AppStrings.confirmYourNewPassword.tr,
              ),

              SizedBox(height: Dimensions.h(50)),

              AppButton(
                label: AppStrings.continueButton.tr,
                onPressed: controller.resetPassword,
                height: Dimensions.h(50),
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
          vertical: Dimensions.h(24),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 520),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Dimensions.h(20)),

                  // Icon/Visual
                  Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(Dimensions.r(20)),
                      ),
                      child: Icon(
                        Icons.lock_reset_outlined,
                        size: 50,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),

                  SizedBox(height: Dimensions.h(40)),

                  // Title
                  Center(
                    child: Text(
                      AppStrings.resetPassword.tr,
                      style: AppTextStyles.body.copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.h(12)),

                  // Subtitle
                  Center(
                    child: Text(
                      AppStrings.createYourNewPassword.tr,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body.copyWith(
                        fontSize: 15,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),

                  SizedBox(height: Dimensions.h(40)),

                  // New Password Field
                  AppTextField(
                    controller: controller.newPasswordController,
                    focusNode: controller.newPasswordFocus,
                    obscure: true,
                    validator: AppValidators.required(),
                    hint: AppStrings.enterYourNewPassword.tr,
                  ),

                  SizedBox(height: Dimensions.h(20)),

                  // Confirm Password Field
                  AppTextField(
                    controller: controller.confirmPasswordController,
                    focusNode: controller.confirmPasswordFocus,
                    obscure: true,
                    validator: AppValidators.confirmPassword(
                      passwordSupplier: () =>
                      controller.newPasswordController.text,
                    ),
                    hint: AppStrings.confirmYourNewPassword.tr,
                  ),

                  SizedBox(height: Dimensions.h(60)),

                  // Continue Button
                  AppButton(
                    label: AppStrings.continueButton.tr,
                    onPressed: controller.resetPassword,
                    height: Dimensions.h(100),
                  ),

                  SizedBox(height: Dimensions.h(32)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}