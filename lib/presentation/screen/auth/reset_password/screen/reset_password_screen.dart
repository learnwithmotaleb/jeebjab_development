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
    );
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: ""),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child:Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create New Password",
                style: AppTextStyles.body.copyWith(
                  fontSize: 24,
                  color: AppColors.blackColor,
                ),
              ),
              SizedBox(height: Dimensions.h(10)),

              Text(
                "Create your new password",
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
                hint: "Enter New Password",
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
                hint: "Enter Confirm Password",
              ),

              SizedBox(height: Dimensions.h(50)),

              AppButton(
                label: AppStrings.continueButton.tr,
                onPressed: controller.resetPassword,
                height: 70,
              ),
            ],
          ),
        )

      ),
    );
  }


}
