import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../../../core/responsive_layout/dimensions.dart';
import '../../../../../core/responsive_layout/responsive_layout.dart';
import '../../../../../core/routes/route_path.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_text_style/app_text_style.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../../../../../widget/app_button.dart';
import '../../../../../widget/app_text_field.dart';
import '../../../../../widget/app_validation.dart';
import '../../../../../widget/custom_appbar.dart';
import '../controller/forget_controller.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  final controller = Get.put(ForgetController());

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
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.forgotPassword.tr,
                  style: AppTextStyles.body.copyWith(
                    fontSize: 24,
                    color: AppColors.blackColor,
                  ),
                ),
                SizedBox(height: Dimensions.h(8)),

                Text(
                  AppStrings.forgotPasswordSubTitle.tr,
                  style: AppTextStyles.body.copyWith(
                    fontSize: 16,
                    color: AppColors.blackColor,
                  ),
                ),

                SizedBox(height: Dimensions.h(30)),

                AppTextField(
                  controller: controller.emailController,
                  hint: AppStrings.enterYourEmail.tr,
                  keyboardType: TextInputType.emailAddress,
                  validator: AppValidators.email(),
                  onTap: () {},
                ),

                SizedBox(height: Dimensions.h(50)),

                Obx(() => AppButton(
                  label: AppStrings.continueButton.tr,
                  height: Dimensions.h(55),
                  borderRadius: Dimensions.r(16),
                  isLoading: controller.isLoading.value,
                  onPressed: () {
                    controller.submit();
                  },
                )),
              ],
            ),
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
            child: Form(
              key: controller.formKey,
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
                        Icons.mail_outline,
                        size: 50,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),

                  SizedBox(height: Dimensions.h(40)),

                  // Title
                  Text(
                    AppStrings.forgotPassword.tr,
                    style: AppTextStyles.body.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackColor,
                    ),
                  ),
                  SizedBox(height: Dimensions.h(12)),

                  // Subtitle
                  Text(
                    AppStrings.forgotPasswordSubTitle.tr,
                    style: AppTextStyles.body.copyWith(
                      fontSize: 15,
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                  ),

                  SizedBox(height: Dimensions.h(40)),

                  // Email Field
                  AppTextField(
                    controller: controller.emailController,
                    hint: AppStrings.enterYourEmail.tr,
                    keyboardType: TextInputType.emailAddress,
                    validator: AppValidators.email(),
                    onTap: () {},
                  ),

                  SizedBox(height: Dimensions.h(60)),

                  // Continue Button
                  SizedBox(
                    width: double.infinity,
                    child: Obx(() => AppButton(
                      label: AppStrings.continueButton.tr,
                      height: Dimensions.h(100),
                      borderRadius: Dimensions.r(16),
                      isLoading: controller.isLoading.value,
                      onPressed: () {
                        controller.submit();
                      },
                    )),
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