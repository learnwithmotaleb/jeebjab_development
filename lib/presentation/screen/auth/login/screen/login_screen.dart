import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/utils/app_text_style/app_text_style.dart';
import 'package:jeebjab/utils/assets_image/app_images.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import 'package:jeebjab/widget/app_button.dart';
import 'package:jeebjab/widget/app_text_field.dart';
import 'package:jeebjab/widget/app_validation.dart';
import 'package:jeebjab/core/platform/platform_helper.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';
import 'package:jeebjab/presentation/screen/auth/login/controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobile(),
      tablet: _buildTablet(),
      desktop: _buildTablet(), // Use same design for desktop
    );
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: _buildBody(isTablet: false),
    );
  }

  Widget _buildTablet() {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: _buildBody(isTablet: true),
        ),
      ),
    );
  }

  Widget _buildBody({required bool isTablet}) {
    return Column(
      children: [
        // ── 1. Teal Header ─────────
        Expanded(
          flex: 1,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.appLogo,
                  width: Dimensions.w(100),
                  height: Dimensions.h(100),
                ),
                SizedBox(height: Dimensions.h(30)),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppStrings.signIn.tr,
                    style: AppTextStyles.title.copyWith(
                      color: AppColors.whiteColor,
                      fontSize: 24,
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.h(4)),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppStrings.getStarted.tr,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.whiteColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // ── 2. White Form Container ─────────
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.w(24),
              vertical: Dimensions.h(30),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextField(
                      controller: controller.emailController,
                      focusNode: controller.emailFocus,
                      hint: AppStrings.enterEmailAddress.tr,
                      keyboardType: TextInputType.emailAddress,
                      validator: AppValidators.email(),
                      onSubmitted: () {
                        controller.submit();
                      },
                    ),
                    SizedBox(height: Dimensions.h(20)),
                    AppTextField(
                      controller: controller.passwordController,
                      focusNode: controller.passwordFocus,
                      hint: AppStrings.enterPassword.tr,
                      obscure: true,
                      validator: AppValidators.password(min: 6),
                      onSubmitted: () {
                        controller.submit();
                      },
                    ),
                    SizedBox(height: Dimensions.h(30)),
                    Obx(() => AppButton(
                      height: Dimensions.h(55),
                      label: AppStrings.signIn.tr,
                      isLoading: controller.isLoading.value,
                      onPressed: () {
                        controller.submit();
                      },
                    )),
                    SizedBox(height: Dimensions.h(12)),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(RoutePath.forget);
                        },
                        child: Text(
                          AppStrings.forgotPassword.tr,
                          style: AppTextStyles.label.copyWith(
                            color: AppColors.primaryColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    
                    SizedBox(height: Dimensions.h(30)),
                    // OR Text
                    Center(
                      child: Text(
                        AppStrings.signInWith.tr, 
                        style: AppTextStyles.body.copyWith(
                          fontSize: 14,
                          color: AppColors.blackColor,
                        )
                      )
                    ),
                    SizedBox(height: Dimensions.h(12)),

                    // Social login buttons (Full Width)
                    GestureDetector(
                      onTap: () => controller.signInWithGoogle(),
                      child: _socialLoginButton(AppImages.google),
                    ),
                    
                    if (PlatformHelper.isIOS) ...[
                      SizedBox(height: Dimensions.h(12)),
                      GestureDetector(
                        onTap: () => controller.signInWithApple(),
                        child: _socialLoginButton(AppImages.ios),
                      ),
                    ],

                    SizedBox(height: Dimensions.h(40)),
                    Text(
                      AppStrings.dontHaveAnAccount.tr,
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.blackColor,
                        fontSize: 14,
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
                    SizedBox(height: Dimensions.h(20)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _socialLoginButton(String asset) {
    return Container(
      width: double.infinity,
      height: Dimensions.h(60),
      decoration: BoxDecoration(
        color: AppColors.textFieldBackgroundColor,
        borderRadius: BorderRadius.circular(Dimensions.r(16)),
        border: Border.all(color: AppColors.greyColor.withOpacity(0.1)),
      ),
      child: Center(
        child: Image.asset(
          asset,
          width: 32,
          height: 32,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
