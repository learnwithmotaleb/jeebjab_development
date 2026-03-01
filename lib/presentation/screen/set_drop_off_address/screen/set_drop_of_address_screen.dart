import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';
import 'package:jeebjab/presentation/screen/set_drop_off_address/controller/set_drop_of_address_controller.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import 'package:jeebjab/widget/app_button.dart';
import 'package:jeebjab/widget/custom_appbar.dart';

// ── Reuse RecentAddressCard from pickup_address widget ────────────────────────
import '../../pickup_address/widget/recent_address_card_widget.dart';

class SetDropOfAddressScreen extends StatefulWidget {
  const SetDropOfAddressScreen({super.key});

  @override
  State<SetDropOfAddressScreen> createState() => _SetDropOfAddressScreenState();
}

class _SetDropOfAddressScreenState extends State<SetDropOfAddressScreen> {
  final SetDropOfAddressController controller = Get.put(
    SetDropOfAddressController(),
  );

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobile: _buildMobile());
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: CommonAppBar(title: AppStrings.setDropOffAddress.tr),
      body: Column(
        children: [
          // ── Scrollable Content ──────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(Dimensions.w(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Dimensions.h(8)),

                  // ── Address Text Field ────────────────────────────────
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(Dimensions.r(10)),
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
                      style: TextStyle(
                        fontSize: Dimensions.f(14),
                        color: AppColors.labelColor,
                      ),
                      decoration: InputDecoration(
                        hintText: AppStrings.enterDropOffAddress.tr,
                        hintStyle: TextStyle(
                          fontSize: Dimensions.f(14),
                          color: AppColors.hintColor,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: Dimensions.w(16),
                          vertical: Dimensions.h(14),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  SizedBox(height: Dimensions.h(10)),

                  // ── Choose On Map ─────────────────────────────────────
                  GestureDetector(
                    onTap: controller.onChooseOnMap,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.w(16),
                        vertical: Dimensions.h(14),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(Dimensions.r(10)),
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
                          Icon(
                            Icons.location_on_outlined,
                            size: Dimensions.w(20),
                            color: AppColors.labelColor,
                          ),
                          SizedBox(width: Dimensions.w(10)),
                          Text(
                            AppStrings.chooseOnMap.tr,
                            style: TextStyle(
                              fontSize: Dimensions.f(14),
                              fontWeight: FontWeight.w600,
                              color: AppColors.labelColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: Dimensions.h(24)),

                  // ── Recent Used Address label ──────────────────────────
                  Text(
                    AppStrings.recentUsedAddress.tr,
                    style: TextStyle(
                      fontSize: Dimensions.f(14),
                      fontWeight: FontWeight.w700,
                      color: AppColors.labelColor,
                    ),
                  ),

                  SizedBox(height: Dimensions.h(12)),

                  // ── Address List ──────────────────────────────────────
                  Obx(
                    () => Column(
                      children: controller.recentAddresses
                          .map(
                            (address) => Padding(
                              padding: EdgeInsets.only(
                                bottom: Dimensions.h(10),
                              ),
                              child: RecentAddressCard(
                                address: address,
                                isSelected:
                                    controller.selectedAddress.value == address,
                                onTap: () =>
                                    controller.selectRecentAddress(address),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Continue Button pinned bottom ───────────────────────────
          Padding(
            padding: EdgeInsets.fromLTRB(
              Dimensions.w(16),
              Dimensions.h(8),
              Dimensions.w(16),
              Dimensions.h(24),
            ),
            child: AppButton(
              label: AppStrings.continueButton.tr,
              height: 65,
              onPressed: controller.onContinue,
            ),
          ),
          SizedBox(height: Dimensions.h(24)),

        ],
      ),
    );
  }
}
