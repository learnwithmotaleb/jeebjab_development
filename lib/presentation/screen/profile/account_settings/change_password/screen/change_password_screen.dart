import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/presentation/screen/profile/account_settings/change_password/controller/change_password_controller.dart';
import 'package:jeebjab/utils/app_text_style/app_text_style.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import 'package:jeebjab/widget/app_button.dart';
import 'package:jeebjab/widget/app_text_field.dart';
import 'package:jeebjab/widget/custom_appbar.dart';

import '../../../../../../core/responsive_layout/responsive_layout.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../widget/show_snackbar.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  ChangePasswordController controller = Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobile(),
      tablet: _buildTablet(),
    );
  }

  /// Mobile Layout
  Widget _buildMobile() {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: CommonAppBar(title: AppStrings.changePassword.tr),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
                children: [

                  SizedBox(height: Dimensions.h(20),),

                  AppTextField(
                    controller: controller.previousPassword,
                    hint: AppStrings.previousPassword.tr,
                    hintTextStyle: AppTextStyles.hint,
                  ),
                  SizedBox(height: Dimensions.h(12),),

                  AppTextField(
                    controller: controller.newPassword,
                    hint: AppStrings.newPassword.tr,
                    hintTextStyle: AppTextStyles.hint,
                  ),
                  SizedBox(height: Dimensions.h(12),),

                  AppTextField(
                    controller: controller.confirmPassword,
                    hint: AppStrings.oldPassword.tr,
                    hintTextStyle: AppTextStyles.hint,
                  ),

                  SizedBox(height: Dimensions.h(50),),

                  AppButton(
                    label: AppStrings.changePassword.tr,
                    onPressed: () {
                      ShowAppSnackBar.info(
                        AppStrings.passwordChangeSuccessful.tr,
                        title: AppStrings.appName.tr,
                      );
                    },
                    height: 65,
                  )
                ]
            ),
          ),
        )
    );
  }

  /// Tablet Layout
  Widget _buildTablet() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.changePassword.tr),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.w(48),
          vertical: Dimensions.h(32),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 520),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Dimensions.h(20)),

                // ── Icon/Visual ──────────────────────────────────────
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(Dimensions.r(20)),
                    ),
                    child: Icon(
                      Icons.lock_reset_outlined,
                      size: 50,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),

                SizedBox(height: Dimensions.h(40)),

                // ── Title ────────────────────────────────────────────
                Center(
                  child: Text(
                    AppStrings.changePassword.tr,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.title.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: Dimensions.h(12)),

                // ── Subtitle ────────────────────────────────────────
                Center(
                  child: Text(
                    "Secure your account with a strong password",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body.copyWith(
                      fontSize: 15,
                      color: Colors.grey[600],
                    ),
                  ),
                ),

                SizedBox(height: Dimensions.h(40)),

                // ── Previous Password Field ────────────────────────
                AppTextField(
                  controller: controller.previousPassword,
                  hint: AppStrings.previousPassword.tr,
                  hintTextStyle: AppTextStyles.hint,
                ),
                SizedBox(height: Dimensions.h(18)),

                // ── New Password Field ─────────────────────────────
                AppTextField(
                  controller: controller.newPassword,
                  hint: AppStrings.newPassword.tr,
                  hintTextStyle: AppTextStyles.hint,
                ),
                SizedBox(height: Dimensions.h(18)),

                // ── Confirm Password Field ─────────────────────────
                AppTextField(
                  controller: controller.confirmPassword,
                  hint: AppStrings.oldPassword.tr,
                  hintTextStyle: AppTextStyles.hint,
                ),

                SizedBox(height: Dimensions.h(60)),

                // ── Change Password Button ─────────────────────────
                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    label: AppStrings.changePassword.tr,
                    height: Dimensions.h(100),
                    onPressed: () {
                      ShowAppSnackBar.info(
                        AppStrings.passwordChangeSuccessful.tr,
                        title: AppStrings.appName.tr,
                      );
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