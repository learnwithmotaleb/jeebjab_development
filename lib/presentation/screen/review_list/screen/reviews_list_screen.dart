import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';

import '../../../../core/responsive_layout/dimensions.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../widget/custom_appbar.dart';
import '../controller/reviews_list_controller.dart';
import '../widget/review_list_item_card.dart';

class ReviewsListScreen extends StatefulWidget {
  const ReviewsListScreen({super.key});

  @override
  State<ReviewsListScreen> createState() => _ReviewsListScreenState();
}

class _ReviewsListScreenState extends State<ReviewsListScreen> {
  final ReviewsListController controller = Get.put(ReviewsListController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobile: _buildMobile(), tablet: _buildTablet());
  }

  Widget _buildTablet() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.reviewAndRatings.tr),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: _buildReviewContent(),
        ),
      ),
    );
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.reviewAndRatings.tr),
      body: _buildReviewContent(),
    );
  }

  Widget _buildReviewContent() {
    return Obx(() {
      // ── Loading ──────────────────────────────────────────────────────
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(color: AppColors.primaryColor),
        );
      }

      // ── Empty ────────────────────────────────────────────────────────
      if (controller.reviews.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.rate_review_outlined,
                size: Dimensions.f(64),
                color: Colors.grey[400],
              ),
              SizedBox(height: Dimensions.h(16)),
              Text(
                AppStrings.noReviewsYet.tr,
                style: TextStyle(
                  fontSize: Dimensions.f(18),
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      }

      // ── List ─────────────────────────────────────────────────────────
      return RefreshIndicator(
        color: AppColors.primaryColor,
        onRefresh: controller.refreshReviews,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: Dimensions.h(16)),
          itemCount: controller.reviews.length,
          itemBuilder: (context, index) {
            return ReviewListItemWidget(review: controller.reviews[index]);
          },
        ),
      );
    });
  }
}
