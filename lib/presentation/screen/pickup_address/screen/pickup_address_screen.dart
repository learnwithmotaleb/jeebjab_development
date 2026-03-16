import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import 'package:jeebjab/widget/app_button.dart';
import 'package:jeebjab/widget/custom_appbar.dart';

import '../controller/pickup_address_controller.dart';
import '../widget/recent_address_card_widget.dart';

class PickupAddressScreen extends StatefulWidget {
  const PickupAddressScreen({super.key});

  @override
  State<PickupAddressScreen> createState() => _PickupAddressScreenState();
}

class _PickupAddressScreenState extends State<PickupAddressScreen> {
  final PickupAddressController controller = Get.put(PickupAddressController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobile: _buildMobile());
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: CommonAppBar(title: AppStrings.setPickUpAddress.tr),
      body: Column(
        children: [
          // ── Scrollable Content ──────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),

                  // ── Address Text Field ────────────────────────────────
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFE8E8E8)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: controller.addressController,
                      style: const TextStyle(
                          fontSize: 14, color: Color(0xFF1A1A2E)),
                      decoration:  InputDecoration(
                        hintText: AppStrings.enterPickUpAddress.tr,
                        hintStyle: TextStyle(
                            fontSize: 14, color: Color(0xFFAAAAAA)),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // ── Choose On Map Button ──────────────────────────────
                  GestureDetector(
                    onTap: controller.onChooseOnMap,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFE8E8E8)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child:  Row(
                        children: [
                          Icon(Icons.location_on_outlined,
                              size: 20, color: Color(0xFF1A1A2E)),
                          SizedBox(width: 10),
                          Text(
                            AppStrings.chooseOnMap.tr,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1A1A2E),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ── Recent Used Address ───────────────────────────────
                   Text(
                    AppStrings.recentUsedAddress.tr,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ── Address List ──────────────────────────────────────
                  Obx(() => Column(
                    children: controller.recentAddresses
                        .map((address) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: RecentAddressCard(
                        address: address,
                        isSelected:
                        controller.selectedAddress.value ==
                            address,
                        onTap: () => controller
                            .selectRecentAddress(address),
                      ),
                    ))
                        .toList(),
                  )),
                ],
              ),
            ),
          ),

          // ── Continue Button pinned bottom ──────────────────────────

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