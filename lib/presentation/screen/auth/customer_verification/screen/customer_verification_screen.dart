import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';
import 'package:jeebjab/widget/app_button.dart';
import 'package:jeebjab/widget/custom_appbar.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../core/responsive_layout/dimensions.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_text_style/app_text_style.dart';
import '../../../../../utils/assets_image/app_images.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../controller/customer_verification_controller.dart';
import '../widget/timer_widget.dart';

class CustomerVerificationScreen extends StatefulWidget {
  const CustomerVerificationScreen({super.key});

  @override
  State<CustomerVerificationScreen> createState() =>
      _CustomerVerificationScreenState();
}

class _CustomerVerificationScreenState
    extends State<CustomerVerificationScreen> {
  late CustomerVerificationController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(CustomerVerificationController());
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobile(),
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
}