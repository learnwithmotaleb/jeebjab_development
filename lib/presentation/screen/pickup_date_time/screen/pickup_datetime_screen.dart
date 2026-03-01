import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import 'package:jeebjab/widget/app_button.dart';
import 'package:jeebjab/widget/custom_appbar.dart';

import '../../../../core/responsive_layout/responsive_layout.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../controller/pickup_datetime_controller.dart';
import '../widget/pickup_option_card_widget.dart';
import '../widget/time_slot_widget.dart';

class PickupDatetimeScreen extends StatefulWidget {
  const PickupDatetimeScreen({super.key});

  @override
  State<PickupDatetimeScreen> createState() => _PickupDatetimeScreenState();
}

class _PickupDatetimeScreenState extends State<PickupDatetimeScreen> {
  final PickupDatetimeController controller =
  Get.put(PickupDatetimeController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobile: _buildMobile());
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: CommonAppBar(title: AppStrings.pickupDateTime.tr),
      body: Column(
        children: [
          // ── Scrollable Content ──────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Obx(() {
                final selected = controller.selectedType.value;
                final expanded = controller.isCustomExpanded.value;

                return Column(
                  children: [
                    const SizedBox(height: 8),

                    // ── Option 1: Regular ─────────────────────────────
                    PickupOptionCard(
                      type: AppStrings.regular.tr,
                      title: AppStrings.anytime.tr,
                      isSelected: selected == PickupType.regular,
                      onTap: () => controller.selectType(PickupType.regular),
                    ),

                    const SizedBox(height: 10),

                    // ── Option 2: Priority ────────────────────────────
                    PickupOptionCard(
                      type: AppStrings.priority.tr,
                      title: AppStrings.asap.tr,
                      isSelected: selected == PickupType.priority,
                      onTap: () => controller.selectType(PickupType.priority),
                    ),

                    const SizedBox(height: 10),

                    // ── Option 3: Custom (expandable) ─────────────────
                    PickupOptionCard(
                      type: AppStrings.custom.tr,
                      title: AppStrings.selectConvenientTime.tr,
                      isSelected: selected == PickupType.custom,
                      showArrow: true,
                      arrowDown: !expanded,
                      onTap: () => controller.selectType(PickupType.custom),
                    ),

                    // ── Time Slots (expanded panel) ───────────────────
                    AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: expanded
                          ? Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFE8E8E8)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Today slots
                            TimeSlotsWidget(
                              dayLabel: AppStrings.today.tr,
                              dayKey: 'today',
                              slots: controller.timeSlots,
                              selectedSlotKey: controller.selectedSlot.value,
                              onSlotTap: controller.selectSlot,
                            ),

                            const SizedBox(height: 20),

                            // Tomorrow slots
                            TimeSlotsWidget(
                              dayLabel: AppStrings.tomorrow.tr,
                              dayKey: 'tomorrow',
                              slots: controller.timeSlots,
                              selectedSlotKey: controller.selectedSlot.value,
                              onSlotTap: controller.selectSlot,
                            ),
                          ],
                        ),
                      )
                          : const SizedBox.shrink(),
                    ),
                  ],
                );
              }),
            ),
          ),

          // ── Continue Button pinned bottom ───────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            child: AppButton(
              label: AppStrings.continueButton.tr,
              onPressed: controller.onContinue,
              height: 60,
            ),
          ),
          SizedBox(height: Dimensions.h(20)),
        ],
      ),
    );
  }
}