import 'package:flutter/cupertino.dart';
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
import 'package:jeebjab/widget/confirmataion_alert.dart';
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
    );
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Dimensions.h(20)),
                Center(
                  child: Image.asset(
                    AppImages.appLogo,
                    width: Dimensions.w(100),
                    height: Dimensions.h(100),
                  ),
                ),
                SizedBox(height: Dimensions.h(40)),
                Text(AppStrings.signIn.tr, style: AppTextStyles.title),
                Text(AppStrings.getStarted.tr, style: AppTextStyles.body),
                SizedBox(height: Dimensions.h(40)),
                AppTextField(
                  controller: controller.emailController,
                  focusNode: controller.emailFocus,
                  hint: AppStrings.enterYourEmailAddress.tr,
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
                  hint: AppStrings.enterYourPassword.tr,
                  obscure: true,
                  prefixIcon: const Icon(Icons.lock, color: AppColors.primaryColor),
                  validator: AppValidators.password(min: 6),
                  onSubmitted: () {
                    controller.submit();
                  },
                ),
                SizedBox(height: Dimensions.h(40)),
                Obx(() => AppButton(
                  height: Dimensions.h(55),
                  label: AppStrings.signIn.tr,
                  isLoading: controller.isLoading.value,
                  onPressed: () {
                    controller.submit();
                  },
                )),
                SizedBox(height: Dimensions.h(20)),
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
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.h(24)),

                // OR Text
                Center(child: Text(AppStrings.or.tr, style: AppTextStyles.body)),
                SizedBox(height: Dimensions.h(16)),

                // Social login buttons
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => controller.signInWithGoogle(),
                        child: _socialLoginButton(AppImages.google),
                      ),
                    ),
                    SizedBox(width: Dimensions.w(12)),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => controller.signInWithApple(),
                        child: _socialLoginButton(AppImages.ios),
                      ),
                    ),
                  ],
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
    );
  }

  Widget _socialLoginButton(String asset) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.textFieldBackgroundColor,
        borderRadius: BorderRadius.circular(Dimensions.r(16)),
        border: Border.all(color: AppColors.greyColor.withOpacity(0.2)),
      ),
      child: Center(
        child: Image.asset(
          asset,
          width: 24,
          height: 24,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildTablet() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Center(
                      child: Image.asset(
                        AppImages.appLogo,
                        width: 100,
                        height: 100,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Center(
                      child: Text(
                        AppStrings.signIn.tr,
                        style: AppTextStyles.title.copyWith(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: Text(
                        AppStrings.getStarted.tr,
                        style: AppTextStyles.body.copyWith(
                          fontSize: 15,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    AppTextField(
                      controller: controller.emailController,
                      focusNode: controller.emailFocus,
                      hint: AppStrings.enterYourEmailAddress.tr,
                      keyboardType: TextInputType.emailAddress,
                      validator: AppValidators.email(),
                      onSubmitted: () {
                        controller.submit();
                      },
                    ),
                    const SizedBox(height: 20),
                    AppTextField(
                      controller: controller.passwordController,
                      focusNode: controller.passwordFocus,
                      hint: AppStrings.enterYourPassword.tr,
                      obscure: true,
                      prefixIcon: const Icon(Icons.lock, color: AppColors.primaryColor),
                      validator: AppValidators.password(min: 6),
                      onSubmitted: () {
                        controller.submit();
                      },
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(RoutePath.forget);
                        },
                        child: Text(
                          AppStrings.forgotPassword.tr,
                          style: AppTextStyles.label.copyWith(
                            fontSize: 18,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Obx(() => AppButton(
                      height: Dimensions.h(100),
                      label: AppStrings.signIn.tr,
                      isLoading: controller.isLoading.value,
                      onPressed: () {
                        controller.submit();
                      },
                    )),
                    const SizedBox(height: 28),
                    Center(child: Text(AppStrings.or.tr, style: AppTextStyles.body.copyWith(fontSize: 18))),
                    const SizedBox(height: 20),

                    // Social Login Buttons
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => controller.signInWithGoogle(),
                            child: _socialLoginButton(AppImages.google),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => controller.signInWithApple(),
                            child: _socialLoginButton(AppImages.ios),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),
                    Center(
                      child: Text(
                        AppStrings.dontHaveAnAccount.tr,
                        style: AppTextStyles.body.copyWith(
                          fontSize: 18,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    AppButton(
                      label: AppStrings.createNewAccount.tr,
                      backgroundColor: AppColors.whiteColor,
                      textColor: AppColors.primaryColor,
                      height: Dimensions.h(100),
                      borderSideColor: AppColors.primaryColor,
                      borderRadius: Dimensions.r(16),
                      onPressed: () {
                        Get.toNamed(RoutePath.signup);
                      },
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
