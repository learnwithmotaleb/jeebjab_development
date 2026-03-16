import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import 'package:jeebjab/widget/custom_appbar.dart';

import '../../../../../../core/responsive_layout/dimensions.dart';
import '../../../../../../core/responsive_layout/responsive_layout.dart';
import '../../../../../../core/routes/route_path.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_text_style/app_text_style.dart';
import '../../../../../../widget/app_button.dart';
import '../../../../../../widget/app_text_field.dart';
import '../../../../../../widget/app_validation.dart';
import '../controller/driver_signup_controller.dart';

class DriverSignupScreen extends StatefulWidget {
  const DriverSignupScreen({super.key});

  @override
  State<DriverSignupScreen> createState() => _DriverSignupScreenState();
}

class _DriverSignupScreenState extends State<DriverSignupScreen> {
  final controller = Get.put(DriverSignupController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobile(),
    );
  }

  Widget _buildMobile() {
    return Scaffold(
      appBar: CommonAppBar(title: ""),
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.enterYourInformation.tr,
                style: AppTextStyles.body.copyWith(
                  fontSize: 24,
                  color: AppColors.blackColor,
                ),
              ),

              SizedBox(height: Dimensions.h(30)),

              AppTextField(
                controller: controller.nameController,
                focusNode: controller.nameFocus,
                hint: AppStrings.enterYourName.tr,
                keyboardType: TextInputType.name,
                validator: AppValidators.required(),
                onSubmitted: () => controller.submit(),
                onTap: () {},
              ),
              SizedBox(height: Dimensions.h(16)),

              AppTextField(
                controller: controller.emailController,
                focusNode: controller.emailFocus,
                hint: AppStrings.enterEmailAddress.tr,
                keyboardType: TextInputType.emailAddress,
                validator: AppValidators.email(),
                onSubmitted: () => controller.submit(),
                onTap: () {},
              ),
              SizedBox(height: Dimensions.h(16)),

              AppTextField(
                controller: controller.passwordController,
                focusNode: controller.passwordFocus,
                hint: AppStrings.enterPassword.tr,
                obscure: true,
                validator: AppValidators.required(),
                onTap: () {},
              ),
              SizedBox(height: Dimensions.h(24)),

              AppTextField(
                controller: controller.confirmPasswordController,
                focusNode: controller.confirmPasswordFocus,
                hint: AppStrings.confirmPassword.tr,
                obscure: true,
                validator: AppValidators.required(),
                onTap: () {},
              ),
              SizedBox(height: Dimensions.h(24)),

              AppButton(
                label: AppStrings.createAccount.tr,
                height: Dimensions.h(55),
                borderRadius: Dimensions.r(16),
                onPressed: () {
                  Get.toNamed(RoutePath.driverVerification);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}