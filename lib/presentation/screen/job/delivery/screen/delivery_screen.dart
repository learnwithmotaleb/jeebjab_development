import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';

import '../controller/delivery_controller.dart';
import '../widget/delivery_header_widget.dart';
import '../widget/delivery_image_card.dart';
import '../widget/delivery_info_section.dart';

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({super.key});

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  final DeliveryController controller = Get.put(DeliveryController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobile(),
      tablet: _buildTablet(),
    );
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ────────────────────────────────────────────────
            DeliveryHeader(title: 'Proof Of Delivery'),

            SizedBox(height: Dimensions.h(20)),

            // ── Content ────────────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Image Card ────────────────────────────────────
                    DeliveryImageCard(
                      delivery: controller.deliveryProof,
                    ),

                    SizedBox(height: Dimensions.h(20)),

                    // ── Info Section ──────────────────────────────────
                    DeliveryInfoSection(
                      delivery: controller.deliveryProof,
                    ),

                    SizedBox(height: Dimensions.h(20)),
                  ],
                ),
              ),
            ),

            // ── Delivered Button ──────────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.w(16),
                vertical: Dimensions.h(16),
              ),
              child: SizedBox(
                width: double.infinity,
                child: Obx(() => ElevatedButton(
                  onPressed: controller.isDeliveryMarked.value
                      ? null
                      : () => controller.markAsDelivered(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    disabledBackgroundColor: AppColors.primaryColor,
                    padding: EdgeInsets.symmetric(
                      vertical: Dimensions.h(16),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimensions.r(12)),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Delivered',
                    style: TextStyle(
                      fontSize: Dimensions.f(16),
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTablet() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ────────────────────────────────────────────────
            DeliveryHeader(title: 'Proof Of Delivery'),

            SizedBox(height: Dimensions.h(24)),

            // ── Content ────────────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w(48)),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 800),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Image Card ──────────────────────────────
                        DeliveryImageCard(
                          delivery: controller.deliveryProof,
                        ),

                        SizedBox(height: Dimensions.h(32)),

                        // ── Info Section ────────────────────────────
                        DeliveryInfoSection(
                          delivery: controller.deliveryProof,
                        ),

                        SizedBox(height: Dimensions.h(32)),

                        // ── Delivered Button ────────────────────────
                        Obx(() => ElevatedButton(
                          onPressed:
                          controller.isDeliveryMarked.value
                              ? null
                              : () => controller.markAsDelivered(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            disabledBackgroundColor: AppColors.primaryColor,
                            padding: EdgeInsets.symmetric(
                              vertical: Dimensions.h(16),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(Dimensions.r(12)),
                            ),
                            elevation: 0,
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                'Delivered',
                                style: TextStyle(
                                  fontSize: Dimensions.f(16),
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )),

                        SizedBox(height: Dimensions.h(32)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}