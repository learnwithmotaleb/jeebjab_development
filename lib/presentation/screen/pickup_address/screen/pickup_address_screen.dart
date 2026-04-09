import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
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
    return ResponsiveLayout(
      mobile: _buildMobile(),
      tablet: _buildTablet(),
    );
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
                      decoration: InputDecoration(
                        hintText: AppStrings.enterPickUpAddress.tr,
                        hintStyle: const TextStyle(
                            fontSize: 14, color: Color(0xFFAAAAAA)),
                        contentPadding: const EdgeInsets.symmetric(
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
                      child: Row(
                        children: [
                          const Icon(Icons.location_on_outlined,
                              size: 20, color: Color(0xFF1A1A2E)),
                          const SizedBox(width: 10),
                          Text(
                            AppStrings.chooseOnMap.tr,
                            style: const TextStyle(
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
                    style: const TextStyle(
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
            child: AppButton(
              label: AppStrings.continueButton.tr,
              height: 60,
              onPressed: controller.onContinue,
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildTablet() {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: CommonAppBar(title: AppStrings.setPickUpAddress.tr),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),

                      Text(
                        "Set your pickup location",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackColor,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // ── Address Text Field ────────────────────────────────
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
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
                          controller: controller.addressController,
                          style: const TextStyle(
                              fontSize: 16, color: Color(0xFF1A1A2E)),
                          decoration: InputDecoration(
                            hintText: AppStrings.enterPickUpAddress.tr,
                            hintStyle: const TextStyle(
                                fontSize: 16, color: Color(0xFFAAAAAA)),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 18),
                            border: InputBorder.none,
                            prefixIcon:
                                const Icon(Icons.search, color: Colors.grey),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // ── Choose On Map Button ──────────────────────────────
                      GestureDetector(
                        onTap: controller.onChooseOnMap,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 18),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFE8E8E8)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.location_on_outlined,
                                  size: 24, color: AppColors.primaryColor),
                              const SizedBox(width: 12),
                              Text(
                                AppStrings.chooseOnMap.tr,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1A1A2E),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 48),

                      // ── Recent Used Address Header ──────────────────────────
                      Text(
                        AppStrings.recentUsedAddress.tr,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1A1A2E),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // ── Address List ──────────────────────────────────────
                      Obx(() => Column(
                            children: controller.recentAddresses
                                .map((address) => Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12),
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