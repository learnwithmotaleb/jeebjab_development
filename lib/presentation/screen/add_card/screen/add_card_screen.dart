import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';
import 'package:jeebjab/presentation/screen/add_card/controller/add_card_controller.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import 'package:jeebjab/widget/app_button.dart';
import 'package:jeebjab/widget/custom_appbar.dart';

import '../widget/card_number_field.dart';
import '../widget/expiry_cvv_row.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final AddCardController controller = Get.put(AddCardController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobile: _buildMobile());
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(
        title: AppStrings.addCard.tr,
        backgroundColor: AppColors.whiteColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.w(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Dimensions.h(16)),

            Text(
              AppStrings.paymentViaCard.tr,
              style: TextStyle(
                fontSize: Dimensions.f(18),
                fontWeight: FontWeight.w800,
                color: AppColors.labelColor,
              ),
            ),

            SizedBox(height: Dimensions.h(4)),

            Row(
              children: [
                Icon(
                  Icons.lock_outline_rounded,
                  size: Dimensions.w(14),
                  color: AppColors.greyColor,
                ),
                SizedBox(width: Dimensions.w(4)),
                Text(
                  AppStrings.yourDetailsAreSafe.tr,
                  style: TextStyle(
                    fontSize: Dimensions.f(12),
                    color: AppColors.blackColor,
                  ),
                ),
              ],
            ),

            SizedBox(height: Dimensions.h(28)),

            CardNumberField(controller: controller.cardNumberController),

            SizedBox(height: Dimensions.h(16)),

            ExpiryCvvRow(
              expireController: controller.expireController,
              cvvController: controller.cvvController,
            ),

            SizedBox(height: Dimensions.h(28)),

            Obx(
                  () => AppButton(
                label: AppStrings.addCard.tr,
                height: 65,
                onPressed: controller.isValid.value
                    ? controller.onAddCard
                    : controller.onAddCard,
              ),
            ),
          ],
        ),
      ),
    );
  }
}