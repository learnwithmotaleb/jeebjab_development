import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/utils/app_text_style/app_text_style.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import 'package:jeebjab/widget/app_button.dart';
import 'package:jeebjab/widget/app_text_field.dart';
import 'package:jeebjab/widget/custom_appbar.dart';

import '../controller/capture_info_controller.dart';
import '../widget/restricted_items_widget.dart';
import '../widget/size_card_widget.dart';

class CaptureInfoScreen extends StatefulWidget {
  const CaptureInfoScreen({super.key});

  @override
  State<CaptureInfoScreen> createState() => _CaptureInfoScreenState();
}

class _CaptureInfoScreenState extends State<CaptureInfoScreen> {
  final CaptureInfoController controller = Get.put(CaptureInfoController());

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
      appBar: CommonAppBar(title: AppStrings.information.tr),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),

                  // ── Form Fields ──────────────────────────────────────────
                  AppTextField(
                    controller: controller.nameController,
                    hint: AppStrings.nameOfItemProducts.tr,
                    hintTextStyle: AppTextStyles.hint,
                    maxLines: 1,
                  ),

                  const SizedBox(height: 12),

                  AppTextField(
                    controller: controller.descriptionController,
                    hintTextStyle: AppTextStyles.hint,
                    hint: AppStrings.descriptionWriteHere.tr,
                    maxLines: 3,
                  ),

                  SizedBox(height: Dimensions.h(32)),

                  // ── Size Section ───────────────────────────────────────
                  Center(
                    child: Text(
                      AppStrings.sizeOfProduct.tr,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  // ── Size Cards Grid ────────────────────────────────────
                  Obx(
                    () => Row(
                      children: controller.sizes.map((size) {
                        final isSelected =
                            controller.selectedSize.value == size.label;
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: SizeCardWidget(
                              size: size,
                              isSelected: isSelected,
                              productImage: controller.capturedImages.isNotEmpty
                                  ? controller.capturedImages.first
                                  : null,
                              onTap: () => controller.selectSize(size.label),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // ── Restricted Items ─────────────────────────────────
                  Center(
                    child: RestrictedItemsWidget(
                      items: controller.restrictedItems,
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          // ── Continue Button (pinned bottom) ──────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: AppButton(
              height: 60,
              label: AppStrings.continueButton.tr,
              onPressed: controller.onContinue,
            ),
          ),
          SizedBox(height: Dimensions.h(40)),
        ],
      ),
    );
  }

  Widget _buildTablet() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.information.tr),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.w(24),
                vertical: Dimensions.h(40),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Title ──────────────────────────────────────────────
                  Text(
                    "Product Information",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackColor,
                    ),
                  ),
                  SizedBox(height: Dimensions.h(32)),

                  // ── Form Fields ────────────────────────────────────────
                  AppTextField(
                    controller: controller.nameController,
                    hint: AppStrings.nameOfItemProducts.tr,
                    hintTextStyle: AppTextStyles.hint,
                    maxLines: 1,
                  ),

                  SizedBox(height: Dimensions.h(16)),

                  AppTextField(
                    controller: controller.descriptionController,
                    hintTextStyle: AppTextStyles.hint,
                    hint: AppStrings.descriptionWriteHere.tr,
                    maxLines: 4,
                  ),

                  SizedBox(height: Dimensions.h(40)),

                  // ── Size Section ───────────────────────────────────────
                  Text(
                    AppStrings.sizeOfProduct.tr,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1A1A2E),
                    ),
                  ),

                  SizedBox(height: Dimensions.h(20)),

                  // ── Size Cards Grid ────────────────────────────────────
                  Obx(
                    () => Row(
                      children: controller.sizes.map((size) {
                        final isSelected =
                            controller.selectedSize.value == size.label;
                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.w(8)),
                            child: SizeCardWidget(
                              size: size,
                              isSelected: isSelected,
                              productImage: controller.capturedImages.isNotEmpty
                                  ? controller.capturedImages.first
                                  : null,
                              onTap: () => controller.selectSize(size.label),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  SizedBox(height: Dimensions.h(48)),

                  // ── Restricted Items ───────────────────────────────────
                  RestrictedItemsWidget(
                    items: controller.restrictedItems,
                  ),

                  SizedBox(height: Dimensions.h(48)),

                  // ── Continue Button ────────────────────────────────────
                  SizedBox(
                    width: double.infinity,
                    child: AppButton(
                      height: Dimensions.h(100),
                      label: AppStrings.continueButton.tr,
                      onPressed: controller.onContinue,
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