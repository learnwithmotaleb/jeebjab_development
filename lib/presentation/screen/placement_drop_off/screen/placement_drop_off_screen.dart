import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/responsive_layout/responsive_layout.dart';
import '../../../../utils/static_strings/static_strings.dart';
import '../../../../widget/app_button.dart';
import '../../../../widget/custom_appbar.dart';
import '../../placement_pickup/widget/placement_option_row_widget.dart';
import '../controller/placement_drop_off_controller.dart';

class PlacementDropOffScreen extends StatefulWidget {
  const PlacementDropOffScreen({super.key});

  @override
  State<PlacementDropOffScreen> createState() => _PlacementDropOffScreenState();
}

class _PlacementDropOffScreenState extends State<PlacementDropOffScreen> {
  final PlacementDropOffController controller =
  Get.put(PlacementDropOffController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobile: _buildMobile());
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: CommonAppBar(title: AppStrings.placementDropOffTitle.tr),
      body: Column(
        children: [
          // ── Scrollable Content ─────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),

                  // ── Placement Section (single select) ───────────
                  PlacementOptionRow(
                    label: AppStrings.insideHouse.tr,
                    icon: Icons.home_outlined,
                    isSelected: controller
                        .isPlacementSelected(AppStrings.insideHouse),
                    isRadio: true,
                    onTap: () =>
                        controller.selectPlacement(AppStrings.insideHouse),
                  ),
                  const SizedBox(height: 10),
                  PlacementOptionRow(
                    label: AppStrings.outsideHouse.tr,
                    icon: Icons.house_siding_outlined,
                    isSelected: controller
                        .isPlacementSelected(AppStrings.outsideHouse),
                    isRadio: true,
                    onTap: () =>
                        controller.selectPlacement(AppStrings.outsideHouse),
                  ),
                  const SizedBox(height: 8),

                  // ── Hint text ───────────────────────────────────
                  Text(
                    AppStrings.selectBothHint.tr,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ── Additional Section (multi select) ─────────
                  Text(
                    AppStrings.additional.tr,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  const SizedBox(height: 12),

                  PlacementOptionRow(
                    label: AppStrings.needToMeet.tr,
                    icon: Icons.people_outline_rounded,
                    isSelected:
                    controller.isAdditionalSelected(AppStrings.needToMeet),
                    isRadio: false,
                    onTap: () =>
                        controller.toggleAdditional(AppStrings.needToMeet),
                  ),
                  const SizedBox(height: 10),

                  PlacementOptionRow(
                    label: AppStrings.canHelpCarry.tr,
                    icon: Icons.sports_handball_outlined,
                    isSelected: controller
                        .isAdditionalSelected(AppStrings.canHelpCarry),
                    isRadio: false,
                    onTap: () =>
                        controller.toggleAdditional(AppStrings.canHelpCarry),
                  ),
                  const SizedBox(height: 8),

                  // ── Hint text ───────────────────────────────────
                  Text(
                    AppStrings.selectBothHint.tr,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),
                ],
              )),
            ),
          ),

          // ── Continue Button pinned bottom ───────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: AppButton(
              label: AppStrings.continueButton.tr,
              height: 65,
              onPressed: controller.onContinue,
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}