import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';
import 'package:jeebjab/presentation/screen/i_will_pay/controller/i_will_pay_controller.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/utils/app_text_style/app_text_style.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import 'package:jeebjab/widget/app_button.dart';
import 'package:jeebjab/widget/app_text_field.dart';
import 'package:jeebjab/widget/custom_appbar.dart';

import '../widget/price_filed_widget.dart';

class IWillPayScreen extends StatefulWidget {
  const IWillPayScreen({super.key});

  @override
  State<IWillPayScreen> createState() => _IWillPayScreenState();
}

class _IWillPayScreenState extends State<IWillPayScreen> {
  final IWillPayController controller = Get.put(IWillPayController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobile: _buildMobile());
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.iWillPay.tr),
      body: Column(
        children: [
          // ── Main Content ────────────────────────────────────────────
          SizedBox(height: Dimensions.h(32)),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w(24)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // ── Suggested range label ───────────────────────────
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: Dimensions.f(13),
                        fontWeight: FontWeight.bold,
                        color: AppColors.blackColor,
                      ),
                      children: [
                         TextSpan(text: AppStrings.otherUserHavePaidAround.tr),
                        TextSpan(
                          text:
                              '  ${controller.minSuggested} - ${controller.maxSuggested}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: Dimensions.h(32)),

                  // ── Price Input ─────────────────────────────────────
                  TextField(
                    controller: controller.priceController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                    style: TextStyle(
                      fontSize: 24,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold
                    ),

                    decoration: InputDecoration(
                      isDense: true,
                      // ✅ No focus border
                      contentPadding: EdgeInsets.all(15),
                      fillColor: AppColors.greyColor.withOpacity(0.1),
                      filled: true,
                      // ✅ No visible border but radius 10
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),

                  ),

                  SizedBox(height: Dimensions.h(32)),

                  // ── Voucher link ────────────────────────────────────
                  GestureDetector(
                    onTap: controller.onVoucherTap,
                    child: Text(
                     AppStrings.doYouHaveCampaignCode.tr,
                      style: TextStyle(
                        fontSize: Dimensions.f(13),
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.none,
                        decorationColor: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Continue Button pinned bottom ───────────────────────────
          Padding(
            padding: EdgeInsets.fromLTRB(
              Dimensions.w(16),
              Dimensions.h(8),
              Dimensions.w(16),
              Dimensions.h(24),
            ),
            child: AppButton(
              height: 65,
              label: AppStrings.continueButton.tr,
              onPressed: controller.onContinue,
            ),
          ),
          SizedBox(height: Dimensions.h(32)),

        ],
      ),
    );
  }
}
