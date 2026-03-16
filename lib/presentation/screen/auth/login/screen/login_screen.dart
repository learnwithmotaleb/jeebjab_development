import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/presentation/screen/auth/login/controller/login_controller.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/utils/app_text_style/app_text_style.dart';
import 'package:jeebjab/utils/assets_image/app_images.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import 'package:jeebjab/widget/app_button.dart';
import 'package:jeebjab/widget/app_text_field.dart';
import 'package:jeebjab/widget/app_validation.dart';
import 'package:jeebjab/widget/confirmataion_alert.dart';

import '../../../../../core/responsive_layout/responsive_layout.dart';
import '../../../../../widget/app_platform_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final controller = Get.put(LoginController());




  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobile(),
      tablet: _buildTablet(),
      desktop: _buildDesktop(),
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
                        AppStrings.signIn.tr,
                        style: AppTextStyles.title.copyWith(

                            color: AppColors.whiteColor, fontSize: 20,

                        ),
                      ),
                    ),
                    SizedBox(height: Dimensions.h(8)),
                    Align(
                      alignment: AlignmentGeometry.centerLeft,
                      child: Text(
                       AppStrings.getStarted.tr,
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
                      // Email Field
                      AppTextField(
                        controller: controller.emailController,
                        focusNode: controller.emailFocus,
                        hint: AppStrings.enterYourEmailAddress.tr,
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
                        hint: AppStrings.enterYourPassword.tr,
                        obscure: true,
                        prefixIcon: Icon(Icons.lock, color: AppColors.primaryColor),
                        validator: AppValidators.password(min: 6),
                        onTap: () {
                        },
                      ),
                      SizedBox(height: Dimensions.h(24)),

                      // Sign In Button
                      AppButton(
                        label: AppStrings.signIn.tr,
                        height: Dimensions.h(55),
                        borderRadius: Dimensions.r(16),
                        onPressed: () {
                          controller.submit();
                        },
                      ),
                      SizedBox(height: Dimensions.h(10)),

                      // Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(RoutePath.forget);

                          },
                          child: Text(
                            AppStrings.forgotPassword.tr,
                            style: AppTextStyles.label.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Dimensions.h(24)),

                      // OR Text
                      Text(AppStrings.or.tr, style: AppTextStyles.body),
                      SizedBox(height: Dimensions.h(16)),


                      // Social login buttons

                      GestureDetector(
                          onTap: () {
                            if (PlatformHelper.isIOS) {
                              // iOS action
                              AppAlerts.confirm(
                                title: "Jeebjab",
                                message: "Apple login clicked",
                                onConfirm: () {
                                  print("Apple Login");
                                  // call your Apple login logic here
                                },
                              );
                            } else if (PlatformHelper.isAndroid) {
                              // Android action
                              AppAlerts.confirm(
                                title: "Jeebjab",
                                message: "Google login clicked",
                                onConfirm: () {
                                  print("Google Login");
                                  // call your Google login logic here
                                },
                              );
                            }
                          },
                          child: _socialLoginButton(
                            PlatformHelper.isIOS ? AppImages.ios : AppImages.google,
                          ),
                        ),

                      SizedBox(height: Dimensions.h(24)),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppStrings.dontHaveAnAccount.tr,
                          style: AppTextStyles.body.copyWith(
                            color: AppColors.blackColor,
                          ),
                        ),
                      ),
                      SizedBox(height: Dimensions.h(10)),

                      // Create Account Button
                      AppButton(
                        label: AppStrings.createNewAccount.tr,
                        backgroundColor: AppColors.whiteColor,
                        textColor: AppColors.primaryColor,
                        height: Dimensions.h(55),
                        borderSideColor: AppColors.primaryColor,
                        borderRadius: Dimensions.r(16),
                        onPressed: () {
                          Get.toNamed(RoutePath.signup);
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

  Widget _socialLoginButton(String asset) {
    return SizedBox(

      child: Container(
        width: double.infinity,
        height: 70,
        decoration: BoxDecoration(
          color: AppColors.greyColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(Dimensions.r(16)),
        ),
        child: Center(
          child: Image.asset(
            asset,
            width: Dimensions.w(24),
            height: Dimensions.h(24),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _buildTablet() {
    return Scaffold(body: Center(child: Text("Hello, Tablet, Login")));
  }

  Widget _buildDesktop() {
    return Scaffold(body: Center(child: Text("Hello, Desktop Login")));
  }
}
