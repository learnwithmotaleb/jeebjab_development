import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/presentation/screen/post_details/widget/adviser_widget.dart';
import 'package:jeebjab/presentation/screen/post_details/widget/image_carousel_widget.dart';
import 'package:jeebjab/presentation/screen/post_details/widget/location_card_widget.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/utils/app_text_style/app_text_style.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';

import '../../../../../../../core/responsive_layout/responsive_layout.dart';
import '../controller/task_details_controller.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({super.key});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  final TaskDetailsController controller = Get.put(TaskDetailsController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobile: _buildMobile(), tablet: _buildTablet());
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
                      horizontal: 16,
                      vertical: 16,
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

                        const SizedBox(height: 8),
                        const Divider(color: Color(0xFFEEEEEE)),
                        const SizedBox(height: 8),

                        // ── 3. Size + Pickup Time ─────────────────
                        _MetaRowWidget(
                          label: AppStrings.size.tr,
                          value: controller.size.value.tr,
                        ),
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
      bottomNavigationBar: _buildBottomActions(),
    );
  }

  Widget _buildBottomActions() {
    return Obx(() {
      if (controller.isLoading.value || controller.errorMessage.value.isNotEmpty) {
        return const SizedBox.shrink();
      }

      final status = controller.requestStatus.value;
      if (status == 'none' || status == '') {
        return Container(
          padding: EdgeInsets.fromLTRB(16, 10, 16, 24),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Color(0xFFF0F0F0))),
          ),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: controller.onSendRequest,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00CBA9),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              child: Text(
                AppStrings.sendRequest.tr,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      } else if (status == 'pending' || status == 'sent') {
        return Container(
          padding: EdgeInsets.fromLTRB(16, 10, 16, 24),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Color(0xFFF0F0F0))),
          ),
          child: SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: controller.onCancelRequest,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: AppColors.redColor.withOpacity(0.3)),
                ),
                backgroundColor: const Color(0xFFF5F5F5), // Light background to match the second screenshot roughly, or white
              ),
              child: Text(
                AppStrings.cancelRequest.tr,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.redColor,
                ),
              ),
            ),
          ),
        );
      }
      return const SizedBox.shrink();
    });
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
                              value: controller.size.value.tr,
                            ),
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
      bottomNavigationBar: _buildBottomActions(),
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
              Text(
                title,
                style: TextStyle(
                  fontSize: isTablet ? 28 : 20,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1A1A2E),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: isTablet ? 18 : 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                publishedTime,
                style: TextStyle(
                  fontSize: isTablet ? 14 : 12,
                  color: Colors.grey,
                ),
              ),
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
        Text(
          label,
          style: isTablet
              ? AppTextStyles.body.copyWith(fontSize: 18)
              : AppTextStyles.body,
        ),
        Text(
          value,
          style: isTablet
              ? AppTextStyles.body.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                )
              : AppTextStyles.body,
        ),
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
          horizontal: isTablet ? 16 : 10,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: isTablet ? 18 : 14,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: isTablet ? 18 : 14,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}
