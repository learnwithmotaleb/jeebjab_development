import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    return ResponsiveLayout(mobile: _buildMobile());
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: CommonAppBar(title: "Placement For Pick-Up"),
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
                    label: 'Inside The House/Apartment',
                    icon: Icons.home_outlined,
                    isSelected: controller.isPlacementSelected(
                        'Inside The House/Apartment'),
                    isRadio: true,
                    onTap: () => controller
                        .selectPlacement('Inside The House/Apartment'),
                  ),

                  const SizedBox(height: 10),

                  PlacementOptionRow(
                    label: 'Outside The House/Apartment',
                    icon: Icons.house_siding_outlined,
                    isSelected: controller.isPlacementSelected(
                        'Outside The House/Apartment'),
                    isRadio: true,
                    onTap: () => controller
                        .selectPlacement('Outside The House/Apartment'),
                  ),

                  const SizedBox(height: 8),

                  // ── Hint text ────────────────────────────────────
                  const Text(
                    'You are able to choose only one option',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ── Additional Section (multi select) ────────────
                  const Text(
                    'Additional',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),

                  const SizedBox(height: 12),

                  PlacementOptionRow(
                    label: 'Need To Meet',
                    icon: Icons.people_outline_rounded,
                    isSelected:
                    controller.isAdditionalSelected('Need To Meet'),
                    isRadio: false,
                    onTap: () =>
                        controller.toggleAdditional('Need To Meet'),
                  ),

                  const SizedBox(height: 10),

                  PlacementOptionRow(
                    label: 'Can Help Carry At Pick-Up',
                    icon: Icons.sports_handball_outlined,
                    isSelected: controller
                        .isAdditionalSelected('Can Help Carry At Pick-Up'),
                    isRadio: false,
                    onTap: () => controller
                        .toggleAdditional('Can Help Carry At Pick-Up'),
                  ),

                  const SizedBox(height: 8),

                  // ── Hint text ────────────────────────────────────
                  const Text(
                    'You are able to choose both option',
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
}