import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';
import 'package:jeebjab/service/api_url.dart';
import 'package:jeebjab/widget/custom_appbar.dart';

import '../../../../core/responsive_layout/dimensions.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/app_text_style/app_text_style.dart';
import '../../../../utils/assets_image/app_images.dart';
import '../../../../utils/static_strings/static_strings.dart';
import '../../bottom_nav/page/home/model/home_model.dart';
import '../controller/read_more_post_controller.dart';

class ReadMoreScreen extends StatefulWidget {
  const ReadMoreScreen({super.key});

  @override
  State<ReadMoreScreen> createState() => _ReadMoreScreenState();
}

class _ReadMoreScreenState extends State<ReadMoreScreen> {
  final ReadMoreController controller = Get.put(ReadMoreController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobile: _buildMobile(), tablet: _buildTablet());
  }

  ImageProvider _promoImage(WhatsNewItemModel? item) {
    if (item?.image != null && item!.image!.isNotEmpty) {
      return NetworkImage(ApiUrl.resolveImageUrl(item.image!));
    }
    return AssetImage(AppImages.homeImage1);
  }

  /// Mobile Layout
  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(
        title: AppStrings.whatsNew.tr,
        titleColor: AppColors.primaryColor,
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.items.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: controller.fetchWhatsNew,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: Dimensions.h(20)),

                // ── How it Works (static, not part of the promos API) ──────
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.howItWorksSteps.tr,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.body.copyWith(
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: Dimensions.h(30)),

                if (controller.items.isEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.w(20),
                      vertical: Dimensions.h(20),
                    ),
                    child: Text(
                      "Nothing new right now — check back later.",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body,
                    ),
                  )
                else
                  ...controller.items.map(
                    (item) => Padding(
                      padding: EdgeInsets.only(bottom: Dimensions.h(30)),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 180,
                                margin: EdgeInsets.symmetric(
                                  horizontal: Dimensions.w(20),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    Dimensions.w(20),
                                  ),
                                  image: DecorationImage(
                                    image: _promoImage(item),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                right: 0,
                                bottom: 0,
                                top: 0,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Text(
                                      item.title,
                                      textAlign: TextAlign.center,
                                      style: AppTextStyles.title.copyWith(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Dimensions.h(10)),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.w(20),
                            ),
                            child: Text(
                              item.description,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                SizedBox(height: Dimensions.h(10)),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildTablet() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(
        title: AppStrings.whatsNew.tr,
        titleColor: AppColors.primaryColor,
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.items.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        final items = controller.items;
        final hero = items.isNotEmpty ? items.first : null;

        return RefreshIndicator(
          onRefresh: controller.fetchWhatsNew,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w(48)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Dimensions.h(40)),

                      // ── Hero Banner ──────────────────────────────────────
                      _buildTabletBanner(
                        image: _promoImage(hero),
                        text: hero?.title ?? AppStrings.lifeMakeEasier.tr,
                        height: 300,
                      ),

                      SizedBox(height: Dimensions.h(32)),

                      // ── How it Works Section (static) ────────────────────
                      Text(
                        AppStrings.howItWorks.tr,
                        style: AppTextStyles.title.copyWith(
                          fontSize: 28,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: Dimensions.h(16)),
                      Text(
                        AppStrings.howItWorksSteps.tr,
                        style: AppTextStyles.body.copyWith(
                          fontSize: 18,
                          color: Colors.black87,
                          height: 1.6,
                        ),
                      ),

                      SizedBox(height: Dimensions.h(48)),

                      // ── Promo Grid ────────────────────────────────────────
                      if (items.isEmpty)
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: Dimensions.h(20),
                          ),
                          child: Text(
                            "Nothing new right now — check back later.",
                            style: AppTextStyles.body,
                          ),
                        )
                      else
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          mainAxisSpacing: 30,
                          crossAxisSpacing: 30,
                          childAspectRatio: 0.85,
                          children: items
                              .map(
                                (item) => _buildTabletPromoItem(
                                  image: _promoImage(item),
                                  title: item.title,
                                  subtitle: item.description,
                                ),
                              )
                              .toList(),
                        ),

                      SizedBox(height: Dimensions.h(60)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildTabletBanner({
    required ImageProvider image,
    required String text,
    double height = 220,
  }) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.w(24)),
            image: DecorationImage(image: image, fit: BoxFit.cover),
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.w(24)),
              color: Colors.black.withValues(alpha: 0.3),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.title.copyWith(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabletPromoItem({
    required ImageProvider image,
    required String title,
    required String subtitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.w(20)),
              image: DecorationImage(image: image, fit: BoxFit.cover),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.w(20)),
                color: Colors.black.withValues(alpha: 0.2),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.title.copyWith(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: Dimensions.h(16)),
        Text(
          subtitle,
          style: AppTextStyles.body.copyWith(
            fontSize: 16,
            color: Colors.black87,
            height: 1.5,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
