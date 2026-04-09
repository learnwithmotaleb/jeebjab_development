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
      tablet: _buildTablet(),
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

  Widget _buildTablet() {
    return Scaffold(
      appBar: CommonAppBar(title: ""),
      backgroundColor: AppColors.whiteColor,
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
                      Icons.directions_car_outlined,
                      size: 50,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),

                SizedBox(height: Dimensions.h(40)),

                // Title
                Center(
                  child: Text(
                    AppStrings.enterYourInformation.tr,
                    style: AppTextStyles.body.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackColor,
                    ),
                  ),
                ),

                SizedBox(height: Dimensions.h(40)),

                // Name Field
                AppTextField(
                  controller: controller.nameController,
                  focusNode: controller.nameFocus,
                  hint: AppStrings.enterYourName.tr,
                  keyboardType: TextInputType.name,
                  validator: AppValidators.required(),
                  onSubmitted: () => controller.submit(),
                  onTap: () {},
                ),
                SizedBox(height: Dimensions.h(18)),

                // Email Field
                AppTextField(
                  controller: controller.emailController,
                  focusNode: controller.emailFocus,
                  hint: AppStrings.enterEmailAddress.tr,
                  keyboardType: TextInputType.emailAddress,
                  validator: AppValidators.email(),
                  onSubmitted: () => controller.submit(),
                  onTap: () {},
                ),
                SizedBox(height: Dimensions.h(18)),

                // Password Field
                AppTextField(
                  controller: controller.passwordController,
                  focusNode: controller.passwordFocus,
                  hint: AppStrings.enterPassword.tr,
                  obscure: true,
                  validator: AppValidators.required(),
                  onTap: () {},
                ),
                SizedBox(height: Dimensions.h(18)),

                // Confirm Password Field
                AppTextField(
                  controller: controller.confirmPasswordController,
                  focusNode: controller.confirmPasswordFocus,
                  hint: AppStrings.confirmPassword.tr,
                  obscure: true,
                  validator: AppValidators.required(),
                  onTap: () {},
                ),
                SizedBox(height: Dimensions.h(48)),

                // Create Account Button
                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    label: AppStrings.createAccount.tr,
                    height: Dimensions.h(100),
                    borderRadius: Dimensions.r(16),
                    onPressed: () {
                      Get.toNamed(RoutePath.driverVerification);
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