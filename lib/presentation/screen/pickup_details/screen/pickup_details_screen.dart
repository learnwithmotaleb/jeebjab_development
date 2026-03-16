import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/utils/app_text_style/app_text_style.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';

import '../controller/pickup_details_controller.dart';
import '../widget/adviser_widget.dart';
import '../widget/image_carousel_widget.dart';
import '../widget/location_card_widget.dart';

class PickupDetailsScreen extends StatefulWidget {
  const PickupDetailsScreen({super.key});

  @override
  State<PickupDetailsScreen> createState() => _PickupDetailsScreenState();
}

class _PickupDetailsScreenState extends State<PickupDetailsScreen> {
  final PickupDetailsController controller = Get.put(PickupDetailsController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobile: _mobile());
  }

  Widget _mobile() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // ── Scrollable Content ──────────────────────────────────────
          SingleChildScrollView(
            child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── 1. Image Carousel ─────────────────────────────
                ImageCarouselWidget(images: controller.images),

                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── 2. Item Info ──────────────────────────
                      _ItemInfoWidget(
                        title: controller.itemType.value.tr,
                        subtitle: controller.itemSubtype.value.tr,
                        publishedTime: controller.publishedTime.value.tr,
                        price: controller.itemPrice.value,
                      ),

                      const SizedBox(height: 8),
                      const Divider(color: Color(0xFFEEEEEE)),
                      const SizedBox(height: 8),

                      // ── 3. Size + Pickup Time ─────────────────
                      _MetaRowWidget(
                          label: AppStrings.size.tr, value: controller.size.value.tr),
                      const SizedBox(height: 8),
                      _MetaRowWidget(
                        label: AppStrings.preferredPickupTime.tr,
                        value: controller.preferredPickupTime.value.tr,
                      ),

                      const SizedBox(height: 20),

                      // ── 4. Pick-Up Card ───────────────────────
                      LocationCardWidget(
                        title: AppStrings.pickUp.tr,
                        address: controller.pickupAddress.value,
                        features: controller.pickupFeatures,
                        onOpenMap: controller.onOpenPickupMap,
                      ),

                      const SizedBox(height: 16),

                      // ── 5. Delivery Card ──────────────────────
                      LocationCardWidget(
                        title: AppStrings.delivery.tr,
                        address: controller.deliveryAddress.value,
                        features: controller.deliveryFeatures,
                        onOpenMap: controller.onOpenDeliveryMap,
                      ),

                      const SizedBox(height: 20),

                      // ── 6. Advertiser ─────────────────────────
                      AdvertiserWidget(
                        name: controller.advertiserName.value,
                        rating: controller.advertiserRating.value,
                        imageUrl: controller.advertiserImage.value,
                        onTap: (){
                          Get.toNamed(RoutePath.reviewProfile);
                        },
                      ),

                      const SizedBox(height: 8),
                      const Divider(color: Color(0xFFEEEEEE)),

                      // ── 7. Share ──────────────────────────────
                      _ActionRowWidget(
                        label: AppStrings.share.tr,
                        onTap: controller.onShare,
                        color: AppColors.blackColor,
                      ),

                      const Divider(color: Color(0xFFEEEEEE), height: 0),

                      // ── 8. Report Ad ──────────────────────────
                      _ActionRowWidget(
                        label: AppStrings.reportAd.tr,
                        onTap: controller.onReportAd,
                        color: AppColors.blackColor,
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            )),
          ),

          // ── Back Button Overlay ─────────────────────────────────────
          Positioned(
            top: 40,
            left: 12,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 18,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Item Info Widget ──────────────────────────────────────────────────────────
class _ItemInfoWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String publishedTime;
  final double price;

  const _ItemInfoWidget({
    required this.title,
    required this.subtitle,
    required this.publishedTime,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A1A2E),
                  )),
              const SizedBox(height: 2),
              Text(subtitle,
                  style: const TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 4),
              Text(publishedTime,
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '${AppStrings.currency.tr} ',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              TextSpan(
                text: price.toInt().toString(),
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1A1A2E),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Meta Row Widget ───────────────────────────────────────────────────────────
class _MetaRowWidget extends StatelessWidget {
  final String label;
  final String value;

  const _MetaRowWidget({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.body),
        Text(value, style: AppTextStyles.body),
      ],
    );
  }
}

// ── Action Row Widget (Share / Report) ───────────────────────────────────────
class _ActionRowWidget extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Color color;

  const _ActionRowWidget({
    required this.label,
    required this.onTap,
    this.color = const Color(0xFF1A1A2E),
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          children: [
            Expanded(
              child: Text(label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: color,
                  )),
            ),
            Icon(Icons.arrow_forward_ios_rounded,
                size: 14, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}