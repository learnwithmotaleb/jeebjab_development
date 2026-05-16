import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/utils/app_text_style/app_text_style.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import 'package:jeebjab/widget/custom_appbar.dart';

import '../controller/post_details_controller.dart';
import '../widget/adviser_widget.dart';
import '../widget/image_carousel_widget.dart';
import '../widget/location_card_widget.dart';

class PostDetailsScreen extends StatefulWidget {
  const PostDetailsScreen({super.key});

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  final PostDetailsController controller = Get.put(PostDetailsController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobile(),
      tablet: _buildTablet(),
    );
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // ── Scrollable Content ──────────────────────────────────────
          Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.errorMessage.value.isNotEmpty) {
              return Center(child: Text(controller.errorMessage.value));
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── 1. Image Carousel ─────────────────────────────
                  ImageCarouselWidget(images: controller.images),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
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
                            label: AppStrings.size.tr,
                            value: controller.size.value.tr),
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
                        if (controller.deliveryAddress.value.isNotEmpty)
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
                          onTap: () {
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
              ),
            );
          }),

          // ── Back Button Overlay ─────────────────────────────────────
          Positioned(
            top: 40,
            left: 12,
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.whiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTablet() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Stack(
            children: [
              // ── Scrollable Content ──────────────────────────────────────
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.errorMessage.value.isNotEmpty) {
                  return Center(child: Text(controller.errorMessage.value));
                }

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── 1. Image Carousel ─────────────────────────────
                      ImageCarouselWidget(images: controller.images),

                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.w(48),
                          vertical: Dimensions.h(24),
                        ),
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

                            const SizedBox(height: 16),
                            const Divider(color: Color(0xFFEEEEEE)),
                            const SizedBox(height: 16),

                            // ── 3. Size + Pickup Time ─────────────────
                            _MetaRowWidget(
                                label: AppStrings.size.tr,
                                value: controller.size.value.tr),
                            const SizedBox(height: 12),
                            _MetaRowWidget(
                              label: AppStrings.preferredPickupTime.tr,
                              value: controller.preferredPickupTime.value.tr,
                            ),

                            const SizedBox(height: 32),

                            // ── 4. Pick-Up Card ───────────────────────
                            LocationCardWidget(
                              title: AppStrings.pickUp.tr,
                              address: controller.pickupAddress.value,
                              features: controller.pickupFeatures,
                              onOpenMap: controller.onOpenPickupMap,
                            ),

                            const SizedBox(height: 24),

                            // ── 5. Delivery Card ──────────────────────
                            if (controller.deliveryAddress.value.isNotEmpty)
                              LocationCardWidget(
                                title: AppStrings.delivery.tr,
                                address: controller.deliveryAddress.value,
                                features: controller.deliveryFeatures,
                                onOpenMap: controller.onOpenDeliveryMap,
                              ),

                            const SizedBox(height: 32),

                            // ── 6. Advertiser ─────────────────────────
                            AdvertiserWidget(
                              name: controller.advertiserName.value,
                              rating: controller.advertiserRating.value,
                              imageUrl: controller.advertiserImage.value,
                              onTap: () {
                                Get.toNamed(RoutePath.reviewProfile);
                              },
                            ),

                            const SizedBox(height: 16),
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

                            const SizedBox(height: 60),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),

              // ── Back Button Overlay ─────────────────────────────────────
              Positioned(
                top: 40,
                left: 12,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
    final bool isTablet = Dimensions.isTablet;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                    fontSize: isTablet ? 28 : 20,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1A1A2E),
                  )),
              const SizedBox(height: 4),
              Text(subtitle,
                  style: TextStyle(fontSize: isTablet ? 18 : 14, color: Colors.grey)),
              const SizedBox(height: 4),
              Text(publishedTime,
                  style: TextStyle(fontSize: isTablet ? 14 : 12, color: Colors.grey)),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '${AppStrings.currency.tr} ',
                style: TextStyle(
                  fontSize: isTablet ? 18 : 13,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1A1A2E),
                ),
              ),
              TextSpan(
                text: price.toInt().toString(),
                style: TextStyle(
                  fontSize: isTablet ? 36 : 26,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF1A1A2E),
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
    final bool isTablet = Dimensions.isTablet;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: isTablet ? AppTextStyles.body.copyWith(fontSize: 18) : AppTextStyles.body),
        Text(value, style: isTablet ? AppTextStyles.body.copyWith(fontSize: 18, fontWeight: FontWeight.w600) : AppTextStyles.body),
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
    final bool isTablet = Dimensions.isTablet;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: isTablet ? 18 : 10, 
            horizontal: isTablet ? 16 : 10
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(label,
                  style: TextStyle(
                    fontSize: isTablet ? 18 : 14,
                    fontWeight: FontWeight.w600,
                    color: color,
                  )),
            ),
            Icon(Icons.arrow_forward_ios_rounded,
                size: isTablet ? 18 : 14, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}