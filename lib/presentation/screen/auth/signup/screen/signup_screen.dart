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
import '../../../../../utils/assets_image/app_images.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../../../../../widget/app_button.dart';
import '../../../../../widget/app_text_field.dart';
import '../../../../../widget/app_validation.dart';
import '../controller/signup_controller.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final SignupController controller = Get.put(SignupController());

  Widget _buildForm() {
    return Form(
      key: controller.formKey,
      child: Column(
        children: [

          /// NAME
          AppTextField(
            controller: controller.nameController,
            focusNode: controller.nameFocus,
            hint: AppStrings.enterYourName.tr,
            keyboardType: TextInputType.name,
            validator: AppValidators.required(),
          ),

          SizedBox(height: Dimensions.h(16)),

          /// EMAIL (REAL FIXED - no duplicate)
          AppTextField(
            controller: controller.emailController,
            focusNode: controller.emailFocus,
            hint: AppStrings.enterEmailAddress.tr,
            keyboardType: TextInputType.emailAddress,
            validator: AppValidators.email(),
            onChanged: controller.validateEmail,
          ),

          // /// EMAIL ERROR (ONLY REACTIVE PART)
          // Obx(() {
          //   final error = controller.emailError.value;
          //   if (error == null) return const SizedBox();
          //
          //   return Padding(
          //     padding: const EdgeInsets.only(top: 6),
          //     child: Align(
          //       alignment: Alignment.centerLeft,
          //       child: Text(
          //         error,
          //         style: const TextStyle(
          //           color: Colors.red,
          //           fontSize: 12,
          //         ),
          //       ),
          //     ),
          //   );
          // }),


          SizedBox(height: Dimensions.h(16)),

          /// PASSWORD
          AppTextField(
            controller: controller.passwordController,
            focusNode: controller.passwordFocus,
            hint: AppStrings.enterPassword.tr,
            obscure: true,
            validator: AppValidators.password(),
          ),

          SizedBox(height: Dimensions.h(16)),

          /// CONFIRM PASSWORD
          AppTextField(
            controller: controller.confirmPasswordController,
            focusNode: controller.confirmPasswordFocus,
            hint: AppStrings.confirmPassword.tr,
            obscure: true,
            validator: AppValidators.confirmPassword(
              passwordSupplier: () => controller.passwordController.text,
            ),
          ),

          SizedBox(height: Dimensions.h(24)),

          /// CREATE ACCOUNT
          AppButton(
            label: AppStrings.createAccount.tr,
            height: Dimensions.h(55),
            borderRadius: Dimensions.r(16),
            onPressed: () {
              if (controller.validateForm()) {
                controller.selectCustomer();
                controller.submit();
              }
            },
          ),

          SizedBox(height: Dimensions.h(24)),

          Text(AppStrings.or.tr),

          SizedBox(height: Dimensions.h(20)),

          Text(
            AppStrings.becomeACompanyDriver.tr,
            style: AppTextStyles.body.copyWith(color: AppColors.blackColor),
          ),

          SizedBox(height: Dimensions.h(10)),

          AppButton(
            label: AppStrings.companyDriver.tr,
            backgroundColor: AppColors.whiteColor,
            textColor: AppColors.primaryColor,
            borderSideColor: AppColors.primaryColor,
            height: Dimensions.h(55),
            borderRadius: Dimensions.r(16),
            onPressed: () {
              controller.selectDriver();
              Get.toNamed(RoutePath.driverSignup);
            },
          ),
        ],
      ),
    );
  }

  // ================= MOBILE =================
  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: _buildHeader(fontSize: 20, logoSize: 100),
          ),
          Expanded(
            flex: 2,
            child: _buildBody(padding: 24, maxWidth: double.infinity),
          ),
        ],
      ),
    );
  }

  // ================= TABLET =================
  Widget _buildTable() {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: _buildHeader(fontSize: 28, logoSize: 120),
          ),
          Expanded(
            flex: 2,
            child: _buildBody(padding: 48, maxWidth: 520),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader({required double fontSize, required double logoSize}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              Expanded(
                child: Center(
                  child: Image.asset(
                    AppImages.appLogo,
                    width: logoSize,
                    height: logoSize,
                  ),
                ),
              ),
              const SizedBox(width: 48),
            ],
          ),
          SizedBox(height: Dimensions.h(30)),
          Text(
            AppStrings.signup.tr,
            style: AppTextStyles.title.copyWith(
              color: Colors.white,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            AppStrings.toGetStarted.tr,
            style: AppTextStyles.body.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildBody({required double padding, required double maxWidth}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 24),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.r(30)),
          topRight: Radius.circular(Dimensions.r(30)),
        ),
      ),
      child: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobile(),
      tablet: _buildTable(),
    );
  }
}