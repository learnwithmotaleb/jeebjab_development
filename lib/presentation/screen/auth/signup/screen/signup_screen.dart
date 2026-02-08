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


  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobile(),

    );
  }

  Widget _buildMobile() {
    final controller = Get.put(SignupController());

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only( left: 20.0,right: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImages.appLogo,
                    ),
                    SizedBox(height: Dimensions.h(30)),
                    Align(
                      alignment: AlignmentGeometry.centerLeft,
                      child: Text(
                        "Sign Up",
                        style: AppTextStyles.title.copyWith(

                          color: AppColors.whiteColor, fontSize: 20,

                        ),
                      ),
                    ),
                    SizedBox(height: Dimensions.h(8)),
                    Align(
                      alignment: AlignmentGeometry.centerLeft,
                      child: Text(
                        "To Get started",
                        style: AppTextStyles.body.copyWith(
                            color: AppColors.whiteColor, fontSize: 20),
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
                  horizontal: Dimensions.w(24), vertical: Dimensions.h(24)),
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
                        hint: "Enter Your Name",
                        keyboardType: TextInputType.name,
                        validator: AppValidators.required(),
                        onSubmitted: () {
                          controller.submit(); // ✅ submit form on Don

                        },
                        onTap: () {},
                      ),
                      SizedBox(height: Dimensions.h(16)),
                      // Email Field
                      AppTextField(
                        controller: controller.emailController,
                        focusNode: controller.emailFocus,
                        hint: "Enter Email Address",
                        keyboardType: TextInputType.emailAddress,
                        validator: AppValidators.email(),
                        onSubmitted: () {
                          controller.submit(); // ✅ submit form on Don

                        },
                        onTap: () {},
                      ),
                      SizedBox(height: Dimensions.h(16)),

                      // Password Field
                      AppTextField(
                        controller: controller.passwordController,
                        focusNode: controller.passwordFocus,
                        hint: "Enter Password",
                        obscure: true,
                        validator: AppValidators.required(),
                        onTap: () {},
                      ),
                      SizedBox(height: Dimensions.h(24)),


                      // Password Field
                      AppTextField(
                        controller: controller.confirmPasswordController,
                        focusNode: controller.confirmPasswordFocus,
                        hint: "Confirm Password",
                        obscure: true,
                        validator: AppValidators.required(),
                        onTap: () {},
                      ),
                      SizedBox(height: Dimensions.h(24)),

                      // Sign In Button
                      AppButton(
                        label: "Create Account",
                        height: Dimensions.h(55),
                        borderRadius: Dimensions.r(16),
                        onPressed: () {
                          //controller.submit();
                          Get.toNamed(RoutePath.customerVerification);
                        },
                      ),




                      SizedBox(height: Dimensions.h(24)),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "become a company driver ?".tr,
                          style: AppTextStyles.body.copyWith(
                            color: AppColors.blackColor,
                          ),
                        ),
                      ),
                      SizedBox(height: Dimensions.h(10)),

                      // Create Account Button
                      AppButton(
                        label: "Company Driver",
                        backgroundColor: AppColors.whiteColor,
                        textColor: AppColors.primaryColor,
                        height: Dimensions.h(55),
                        borderSideColor: AppColors.primaryColor,
                        borderRadius: Dimensions.r(16),
                        onPressed: () {
                         Get.toNamed(RoutePath.login);
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
