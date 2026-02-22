import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';

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
    return ResponsiveLayout(mobile: _buildMobile());
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: "Review & Ratings"),
      body: Obx(() {
        // ── Loading ──────────────────────────────────────────────────────
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
        }

        // ── Empty ────────────────────────────────────────────────────────
        if (controller.reviews.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.rate_review_outlined,
                    size: 64, color: Colors.grey),
                SizedBox(height: 12),
                Text(
                  'No Reviews Yet',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
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
            padding: const EdgeInsets.symmetric(vertical: 12),
            itemCount: controller.reviews.length,
            itemBuilder: (context, index) {
              return ReviewListItemWidget(review: controller.reviews[index]);
            },
          ),
        );
      }),
    );
  }
}