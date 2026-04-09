import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';
import 'package:jeebjab/widget/app_button.dart';
import 'package:jeebjab/widget/custom_appbar.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../../core/responsive_layout/dimensions.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_text_style/app_text_style.dart';
import '../../../../../../utils/static_strings/static_strings.dart';
import '../../../Customer_Verification/widget/timer_widget.dart';
import '../controller/driver_verification_controller.dart';

class DriverVerificationScreen extends StatefulWidget {
  const DriverVerificationScreen({super.key});

  @override
  State<DriverVerificationScreen> createState() =>
      _DriverVerificationScreenState();
}

class _DriverVerificationScreenState extends State<DriverVerificationScreen> {
  late DriverVerificationController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(DriverVerificationController());
  }

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
      appBar: CommonAppBar(title: AppStrings.verifyYourAccount.tr),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: AlignmentGeometry.centerLeft,
              child: Text(
                AppStrings.verifyYourAccount.tr,
                style: AppTextStyles.title.copyWith(
                  fontWeight: FontWeight.normal,
                  color: AppColors.blackColor,
                  fontSize: 24,
                ),
              ),
            ),

            SizedBox(height: Dimensions.h(10)),

            Align(
              alignment: AlignmentGeometry.centerLeft,
              child: Text(
                AppStrings.enterTheCodeSentToMail.tr,
                textAlign: TextAlign.center,
                style: AppTextStyles.body,
              ),
            ),

            SizedBox(height: Dimensions.h(24)),

            PinCodeTextField(
              appContext: context,
              length: 6,
              controller: controller.otpController,
              keyboardType: TextInputType.number,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(Dimensions.r(8)),
                fieldHeight: Dimensions.h(48),
                fieldWidth: Dimensions.w(48),
                borderWidth: 1,
                activeColor: AppColors.primaryColor,
                selectedColor: AppColors.primaryColor,
                inactiveColor: AppColors.greyColor,
                activeFillColor: AppColors.greyColor,
              ),
              onCompleted: (v) => print("OTP Completed $v"),
              beforeTextPaste: (_) => true,
            ),

            SizedBox(height: Dimensions.h(16)),

            AppButton(
              label: AppStrings.continueButton.tr,
              onPressed: () {
                controller.emailVerifyProcess();
              },
              height: Dimensions.h(60),
            ),

            SizedBox(height: Dimensions.h(5)),

            Center(
              child: TimerWidget(
                onResendCode: controller.resendOtpProcess,
              ),
            ),

            SizedBox(height: Dimensions.h(20)),
          ],
        ),
      ),
    );
  }

  Widget _buildTablet() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.verifyYourAccount.tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.w(48),
            vertical: Dimensions.h(32),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: Dimensions.h(20)),

                  // Icon Display
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(Dimensions.r(20)),
                    ),
                    child: Icon(
                      Icons.verified_user_outlined,
                      size: 60,
                      color: AppColors.primaryColor,
                    ),
                  ),

                  SizedBox(height: Dimensions.h(40)),

                  // Title
                  Text(
                    AppStrings.verifyYourAccount.tr,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.title.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackColor,
                      fontSize: 28,
                    ),
                  ),

                  SizedBox(height: Dimensions.h(16)),

                  // Subtitle
                  Text(
                    AppStrings.enterTheCodeSentToMail.tr,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body.copyWith(
                      fontSize: 15,
                      color: Colors.grey[600],
                    ),
                  ),

                  SizedBox(height: Dimensions.h(40)),

                  // PIN Code TextField
                  PinCodeTextField(
                    appContext: context,
                    length: 6,
                    controller: controller.otpController,
                    keyboardType: TextInputType.number,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(Dimensions.r(12)),
                      fieldHeight: Dimensions.h(60),
                      fieldWidth: Dimensions.w(60),
                      borderWidth: 2,
                      activeColor: AppColors.primaryColor,
                      selectedColor: AppColors.primaryColor,
                      inactiveColor: AppColors.greyColor,
                      activeFillColor: AppColors.primaryColor.withOpacity(0.05),
                    ),
                    onCompleted: (v) => print("OTP Completed $v"),
                    beforeTextPaste: (_) => true,
                    textStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: Dimensions.h(48)),

                  // Continue Button
                  SizedBox(
                    width: double.infinity,
                    child: AppButton(
                      label: AppStrings.continueButton.tr,
                      onPressed: () {
                        controller.emailVerifyProcess();
                      },
                      height: Dimensions.h(100),
                    ),
                  ),

                  SizedBox(height: Dimensions.h(24)),

                  // Timer Widget with Resend
                  Center(
                    child: TimerWidget(
                      onResendCode: controller.resendOtpProcess,
                    ),
                  ),

                  SizedBox(height: Dimensions.h(40)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}