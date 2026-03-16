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
    return ResponsiveLayout(mobile: _buildMobile());
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: CommonAppBar(title: AppStrings.pickupFloorTitle.tr),
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
              height: 65,
              label: AppStrings.continueButton.tr,
              onPressed: controller.onContinue,
            ),
          ),
          SizedBox(height: Dimensions.h(24)),
        ],
      ),
    );
  }
}