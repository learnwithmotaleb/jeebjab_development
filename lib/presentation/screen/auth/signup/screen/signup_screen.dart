import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:jeebjab/presentation/screen/auth/signup/controller/signup_controller.dart';

import '../../../../../core/responsive_layout/dimensions.dart';
import '../../../../../core/responsive_layout/responsive_layout.dart';
import '../../../../../core/routes/route_path.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_text_style/app_text_style.dart';
import '../../../../../utils/assets_image/app_images.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../../../../../widget/app_button.dart';
import '../../../../../widget/app_text_field.dart';
import '../../../../../widget/app_validation.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  SignupController controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobile(),
    );
  }

  Widget _buildMobile() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppImages.appLogo,width: Dimensions.w(100), height: Dimensions.h(100),),
                    SizedBox(height: Dimensions.h(30)),
                    Align(
                      alignment: AlignmentGeometry.centerLeft,
                      child: Text(
                        AppStrings.signup.tr,
                        style: AppTextStyles.title.copyWith(
                          color: AppColors.whiteColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentGeometry.centerLeft,
                      child: Text(
                        AppStrings.toGetStarted.tr,
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.whiteColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.w(24),
                vertical: Dimensions.h(24),
              ),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.r(30)),
                  topRight: Radius.circular(Dimensions.r(30)),
                ),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                          controller.selectCustomer();
                          Get.toNamed(RoutePath.customerVerification);
                        },
                      ),

                      SizedBox(height: Dimensions.h(24)),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppStrings.becomeACompanyDriver.tr,
                          style: AppTextStyles.body.copyWith(
                            color: AppColors.blackColor,
                          ),
                        ),
                      ),
                      SizedBox(height: Dimensions.h(10)),

                      AppButton(
                        label: AppStrings.companyDriver.tr,
                        backgroundColor: AppColors.whiteColor,
                        textColor: AppColors.primaryColor,
                        height: Dimensions.h(55),
                        borderSideColor: AppColors.primaryColor,
                        borderRadius: Dimensions.r(16),
                        onPressed: () {
                          controller.selectDriver();
                          Get.toNamed(RoutePath.driverSignup);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}