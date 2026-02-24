import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

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

  PlacementDropOffController controller = Get.put(PlacementDropOffController());
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobile: _buildMobile());
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: CommonAppBar(title: "Placement For Drop-Off"),
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
