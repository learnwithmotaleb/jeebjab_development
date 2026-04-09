import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/responsive_layout/dimensions.dart';
import '../../../../core/responsive_layout/responsive_layout.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/static_strings/static_strings.dart';
import '../../../../widget/app_button.dart';
import '../../../../widget/custom_appbar.dart';
import '../../pickup_floor/widget/inline_label_field_widget.dart';
import '../../pickup_floor/widget/toggle_option_row_widget.dart';
import '../controller/drop_off_floor_controller.dart';

class DropOffFloorScreen extends StatefulWidget {
  const DropOffFloorScreen({super.key});

  @override
  State<DropOffFloorScreen> createState() => _DropOffFloorScreenState();
}

class _DropOffFloorScreenState extends State<DropOffFloorScreen> {
  DropOffFloorController controller = Get.put(DropOffFloorController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobile(),
      tablet: _buildTablet(),
    );
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: CommonAppBar(title: AppStrings.droopOffFloorAndDoorCode.tr),
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
                        label: AppStrings.floor.tr,
                        controller: controller.floorController,
                        hint: AppStrings.e36.tr,
                        keyboardType: TextInputType.number,
                      ),

                      SizedBox(height: Dimensions.h(10)),

                      // ── Door Code Field ─────────────────────────────
                      InlineLabelField(
                        label: AppStrings.doorCode.tr,
                        controller: controller.doorCodeController,
                        hint: AppStrings.e36,
                        keyboardType: TextInputType.text,
                      ),

                      SizedBox(height: Dimensions.h(10)),

                      // ── Fits In Elevator toggle ─────────────────────
                      ToggleOptionRow(
                        label: AppStrings.fitsInTheElevator.tr,
                        isSelected: controller.fitsInElevator.value,
                        onTap: controller.toggleElevator,
                      ),

                      SizedBox(height: Dimensions.h(10)),

                      // ── Other Info TextArea ─────────────────────────
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F0F0),
                          borderRadius:
                              BorderRadius.circular(Dimensions.r(10)),
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
                            hintText: AppStrings.writeOtherInfo.tr,
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
              label: AppStrings.continueButton.tr,
              onPressed: controller.onContinue,
            ),
          ),
          SizedBox(height: Dimensions.h(30)),
        ],
      ),
    );
  }

  Widget _buildTablet() {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: CommonAppBar(title: AppStrings.droopOffFloorAndDoorCode.tr),
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

                          const Text(
                            "Drop-off Access Details",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1A1A2E),
                            ),
                          ),
                          const SizedBox(height: 32),

                          // ── Floor Field ─────────────────────────────────
                          InlineLabelField(
                            label: AppStrings.floor.tr,
                            controller: controller.floorController,
                            hint: AppStrings.e36.tr,
                            keyboardType: TextInputType.number,
                          ),

                          SizedBox(height: Dimensions.h(16)),

                          // ── Door Code Field ─────────────────────────────
                          InlineLabelField(
                            label: AppStrings.doorCode.tr,
                            controller: controller.doorCodeController,
                            hint: AppStrings.e36,
                            keyboardType: TextInputType.text,
                          ),

                          SizedBox(height: Dimensions.h(16)),

                          // ── Fits In Elevator toggle ─────────────────────
                          ToggleOptionRow(
                            label: AppStrings.fitsInTheElevator.tr,
                            isSelected: controller.fitsInElevator.value,
                            onTap: controller.toggleElevator,
                          ),

                          SizedBox(height: Dimensions.h(20)),

                          // ── Other Info Header ───────────────────────────
                          Text(
                            AppStrings.additional.tr,
                            style: const TextStyle(
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
                              border:
                                  Border.all(color: const Color(0xFFE8E8E8)),
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
                                hintText: AppStrings.writeOtherInfo.tr,
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
                  label: AppStrings.continueButton.tr,
                  height: Dimensions.h(100),
                  onPressed: controller.onContinue,
                ),
              ),
              SizedBox(height: Dimensions.h(30)),
            ],
          ),
        ),
      ),
    );
  }
}
