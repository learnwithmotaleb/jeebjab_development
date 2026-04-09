import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/widget/custom_appbar.dart';

import '../../../../utils/static_strings/static_strings.dart';
import '../../../../widget/app_button.dart';
import '../controller/placement_pickup_controller.dart';
import '../widget/placement_option_row_widget.dart';

class PlacementPickupScreen extends StatefulWidget {
  const PlacementPickupScreen({super.key});

  @override
  State<PlacementPickupScreen> createState() => _PlacementPickupScreenState();
}

class _PlacementPickupScreenState extends State<PlacementPickupScreen> {
  final PlacementPickupController controller =
  Get.put(PlacementPickupController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobile: _buildMobile(),
        tablet: _buildTablet()
    );

  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: CommonAppBar(title: AppStrings.placementForPickUp.tr),
      body: Column(
        children: [
          // ── Scrollable Content ──────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),

                  // ── Placement Section (single select) ────────────
                  PlacementOptionRow(
                    label:'${AppStrings.insideHouse.tr}/Apartment',
                    icon: Icons.home_outlined,
                    isSelected: controller.isPlacementSelected(
                        '${AppStrings.insideHouse}/Apartment'),
                    isRadio: true,
                    onTap: () => controller
                        .selectPlacement('${AppStrings.insideHouse}/Apartment'),
                  ),

                  const SizedBox(height: 10),

                  PlacementOptionRow(
                    label: '${AppStrings.outsideHouse.tr}/Apartment',
                    icon: Icons.house_siding_outlined,
                    isSelected: controller.isPlacementSelected(
                        '${AppStrings.outsideHouse.tr}/Apartment'),
                    isRadio: true,
                    onTap: () => controller
                        .selectPlacement('${AppStrings.outsideHouse.tr}/Apartment'),
                  ),

                  const SizedBox(height: 8),

                  // ── Hint text ────────────────────────────────────
                   Text(
                   AppStrings.selectBothHint.tr,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ── Additional Section (multi select) ────────────
                   Text(
                    AppStrings.additional.tr,
                    style: TextStyle(
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
                    controller.isAdditionalSelected( AppStrings.needToMeet.tr,),
                    isRadio: false,
                    onTap: () =>
                        controller.toggleAdditional( AppStrings.needToMeet.tr,),
                  ),

                  const SizedBox(height: 10),

                  PlacementOptionRow(
                    label:  AppStrings.canHelpCarry.tr,
                    icon: Icons.sports_handball_outlined,
                    isSelected: controller
                        .isAdditionalSelected('${AppStrings.canHelpCarry} At Pick-Up'),
                    isRadio: false,
                    onTap: () => controller
                        .toggleAdditional('${AppStrings.canHelpCarry} At Pick-Up'),
                  ),

                  const SizedBox(height: 8),

                  // ── Hint text ────────────────────────────────────
                   Text(
                   AppStrings.selectBothHint.tr,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),
                ],
              )),
            ),
          ),

          // ── Continue Button pinned bottom ───────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: AppButton(label: AppStrings.continueButton.tr,
              height: 65,
              onPressed: controller.onContinue,
            ),
          ),

          SizedBox(height: 50,),

        ],
      ),
    );
  }

  Widget _buildTablet() {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: CommonAppBar(title: AppStrings.placementForPickUp.tr),
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
                        "Where should we pick up?",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackColor,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // ── Placement Section (single select) ────────────
                      PlacementOptionRow(
                        label: '${AppStrings.insideHouse.tr}/Apartment',
                        icon: Icons.home_outlined,
                        isSelected: controller.isPlacementSelected(
                            '${AppStrings.insideHouse}/Apartment'),
                        isRadio: true,
                        onTap: () => controller
                            .selectPlacement('${AppStrings.insideHouse}/Apartment'),
                      ),

                      const SizedBox(height: 16),

                      PlacementOptionRow(
                        label: '${AppStrings.outsideHouse.tr}/Apartment',
                        icon: Icons.house_siding_outlined,
                        isSelected: controller.isPlacementSelected(
                            '${AppStrings.outsideHouse.tr}/Apartment'),
                        isRadio: true,
                        onTap: () => controller
                            .selectPlacement('${AppStrings.outsideHouse.tr}/Apartment'),
                      ),

                      const SizedBox(height: 10),

                      // ── Hint text ────────────────────────────────────
                      Text(
                        AppStrings.selectBothHint.tr,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 48),

                      // ── Additional Section (multi select) ────────────
                      Text(
                        AppStrings.additional.tr,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1A1A2E),
                        ),
                      ),

                      const SizedBox(height: 16),

                      PlacementOptionRow(
                        label: AppStrings.needToMeet.tr,
                        icon: Icons.people_outline_rounded,
                        isSelected:
                        controller.isAdditionalSelected(AppStrings.needToMeet.tr),
                        isRadio: false,
                        onTap: () =>
                            controller.toggleAdditional(AppStrings.needToMeet.tr),
                      ),

                      const SizedBox(height: 16),

                      PlacementOptionRow(
                        label: AppStrings.canHelpCarry.tr,
                        icon: Icons.sports_handball_outlined,
                        isSelected: controller
                            .isAdditionalSelected('${AppStrings.canHelpCarry} At Pick-Up'),
                        isRadio: false,
                        onTap: () => controller
                            .toggleAdditional('${AppStrings.canHelpCarry} At Pick-Up'),
                      ),

                      const SizedBox(height: 10),

                      // ── Hint text ────────────────────────────────────
                      Text(
                        AppStrings.selectBothHint.tr,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
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