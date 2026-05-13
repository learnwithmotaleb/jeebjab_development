import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import 'package:jeebjab/widget/app_button.dart';
import 'package:jeebjab/widget/custom_appbar.dart';

import '../controller/pickup_floor_controller.dart';
import '../widget/inline_label_field_widget.dart';
import '../widget/toggle_option_row_widget.dart';

class PickupFloorScreen extends StatefulWidget {
  const PickupFloorScreen({super.key});

  @override
  State<PickupFloorScreen> createState() => _PickupFloorScreenState();
}

class _PickupFloorScreenState extends State<PickupFloorScreen> {
  final PickupFloorController controller = Get.put(PickupFloorController());

  @override
  Widget build(BuildContext context) {
    final bool isEditMode = Get.arguments?['isEdit'] ?? false;
    return ResponsiveLayout(
      mobile: _buildMobile(isEditMode),
      tablet: _buildTablet(isEditMode),
    );
  }

  Widget _buildMobile(bool isEditMode) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: CommonAppBar(
        title: AppStrings.pickupFloorTitle.tr,
        actions: isEditMode
            ? [
                IconButton(
                  icon: const Icon(Icons.check_rounded, color: AppColors.primaryColor, size: 26),
                  tooltip: 'Save & Publish',
                  onPressed: controller.onSaveAndPublish,
                ),
              ]
            : null,
      ),
      body: Column(
        children: [
          // ── Scrollable Content ────────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(Dimensions.w(16)),
              child: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Dimensions.h(8)),

                  // ── Floor Field ─────────────────────────────────
                  InlineLabelField(
                    label: AppStrings.floorLabel.tr,
                    controller: controller.floorController,
                    hint: AppStrings.floorHint.tr,
                    keyboardType: TextInputType.number,
                  ),

                  SizedBox(height: Dimensions.h(10)),

                  // ── Door Code Field ─────────────────────────────
                  InlineLabelField(
                    label: AppStrings.doorCodeLabel.tr,
                    controller: controller.doorCodeController,
                    hint: AppStrings.doorCodeHint.tr,
                    keyboardType: TextInputType.text,
                  ),

                  SizedBox(height: Dimensions.h(10)),

                  // ── Fits In Elevator toggle ─────────────────────
                  ToggleOptionRow(
                    label: AppStrings.fitsInElevator.tr,
                    isSelected: controller.fitsInElevator.value,
                    onTap: controller.toggleElevator,
                  ),

                  SizedBox(height: Dimensions.h(10)),

                  // ── Other Info TextArea ─────────────────────────
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F0F0),
                      borderRadius: BorderRadius.circular(Dimensions.r(10)),
                      border: Border.all(color: const Color(0xFFE8E8E8)),
                    ),
                    child: TextField(
                      controller: controller.otherInfoController,
                      maxLines: 4,
                      style: TextStyle(
                        fontSize: Dimensions.f(14),
                        color: AppColors.labelColor,
                      ),
                      decoration: InputDecoration(
                        hintText: AppStrings.otherInfoHint.tr,
                        hintStyle: TextStyle(
                          fontSize: Dimensions.f(14),
                          color: AppColors.hintColor,
                        ),
                        contentPadding: EdgeInsets.all(Dimensions.w(14)),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  SizedBox(height: Dimensions.h(24)),
                ],
              )),
            ),
          ),

          // ── Continue Button pinned bottom ─────────────────────────────
          Padding(
            padding: EdgeInsets.fromLTRB(
              Dimensions.w(16),
              Dimensions.h(8),
              Dimensions.w(16),
              Dimensions.h(24),
            ),
            child: AppButton(
              height: 60,
              label: isEditMode ? AppStrings.update.tr : AppStrings.continueButton.tr,
              onPressed: controller.onContinue,
            ),
          ),
          SizedBox(height: Dimensions.h(30)),
        ],
      ),
    );
  }

  Widget _buildTablet(bool isEditMode) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: CommonAppBar(
        title: AppStrings.pickupFloorTitle.tr,
        actions: isEditMode
            ? [
                IconButton(
                  icon: const Icon(Icons.check_rounded, color: AppColors.primaryColor, size: 26),
                  tooltip: 'Save & Publish',
                  onPressed: controller.onSaveAndPublish,
                ),
              ]
            : null,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              // ── Scrollable Content ──────────────────────────────────────
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.w(48),
                    vertical: Dimensions.h(40),
                  ),
                  child: Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),

                      Text(
                        "Floor & Access Details",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackColor,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // ── Floor Field ─────────────────────────────────
                      InlineLabelField(
                        label: AppStrings.floorLabel.tr,
                        controller: controller.floorController,
                        hint: AppStrings.floorHint.tr,
                        keyboardType: TextInputType.number,
                      ),

                      SizedBox(height: Dimensions.h(16)),

                      // ── Door Code Field ─────────────────────────────
                      InlineLabelField(
                        label: AppStrings.doorCodeLabel.tr,
                        controller: controller.doorCodeController,
                        hint: AppStrings.doorCodeHint.tr,
                        keyboardType: TextInputType.text,
                      ),

                      SizedBox(height: Dimensions.h(16)),

                      // ── Fits In Elevator toggle ─────────────────────
                      ToggleOptionRow(
                        label: AppStrings.fitsInElevator.tr,
                        isSelected: controller.fitsInElevator.value,
                        onTap: controller.toggleElevator,
                      ),

                      SizedBox(height: Dimensions.h(20)),

                      // ── Other Info Header ───────────────────────────
                      Text(
                        AppStrings.additional.tr,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1A1A2E),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // ── Other Info TextArea ─────────────────────────
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFE8E8E8)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: controller.otherInfoController,
                          maxLines: 6,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF1A1A2E),
                          ),
                          decoration: InputDecoration(
                            hintText: AppStrings.otherInfoHint.tr,
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFFAAAAAA),
                            ),
                            contentPadding: const EdgeInsets.all(20),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  )),
                ),
              ),

              // ── Continue Button pinned bottom ───────────────────────────
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.w(48),
                  vertical: Dimensions.h(40),
                ),
                child: AppButton(
                  label: isEditMode ? AppStrings.update.tr : AppStrings.continueButton.tr,
                  height: Dimensions.h(100),
                  onPressed: isEditMode ? controller.onSaveAndPublish : controller.onContinue,
                ),
              ),
              SizedBox(height: Dimensions.h(20)),
            ],
          ),
        ),
      ),
    );
  }
}