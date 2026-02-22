import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/utils/app_text_style/app_text_style.dart';
import 'package:jeebjab/widget/custom_appbar.dart';

import '../../../../utils/app_colors/app_colors.dart';
import '../controller/review_profile_controller.dart';
import '../widget/profile_header_widget.dart';
import '../widget/rating_breakdown_widget.dart';
import '../widget/review_card_widget.dart';

class ReviewProfileScreen extends StatefulWidget {
  const ReviewProfileScreen({super.key});

  @override
  State<ReviewProfileScreen> createState() => _ReviewProfileScreenState();
}

class _ReviewProfileScreenState extends State<ReviewProfileScreen> {
  final ReviewProfileController controller = Get.put(ReviewProfileController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobile: _buildMobile());
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: "Advertiser"),
      body: Obx(
            () => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── 1. Profile Header ───────────────────────────────────────
              ProfileHeaderWidget(
                name: controller.name.value,
                phone: controller.phone.value,
                imageUrl: controller.profileImage.value,
                rating: controller.overallRating.value,
                totalReviews: controller.totalReviews.value,
              ),

              // ── 2. Section Title ────────────────────────────────────────
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Review & Ratings',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'What Others Think About You',
                      style: AppTextStyles.body,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ── 3. Overall Rating Row ───────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Reviews & Ratings',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1A1A2E),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              controller.overallRating.value
                                  .toStringAsFixed(1),
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1A1A2E),
                              ),
                            ),
                            const SizedBox(width: 4),
                            _SmallStars(
                                rating: controller.overallRating.value),
                            const SizedBox(width: 4),
                            Text(
                              '(${controller.totalReviews.value} Rating)',
                              style: const TextStyle(
                                  fontSize: 11, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      '${controller.totalReviews.value} Review',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ── 4. Rating Breakdown Card ────────────────────────────────
              RatingBreakdownWidget(
                overallRating: controller.overallRating.value,
                totalReviews: controller.totalReviews.value,
                breakdown: controller.ratingBreakdown,
                maxCount: controller.maxRatingCount,
              ),

              const SizedBox(height: 16),

              // ── 5. Review Cards ─────────────────────────────────────────
              ...controller.reviews.map(
                    (review) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: ReviewCardWidget(review: review),
                ),
              ),

              const SizedBox(height: 8),

              // ── 6. Read All Reviews Button ──────────────────────────────
              Center(
                  child: TextButton(
                    onPressed: controller.onReadAllReviews,
                    child: const Text(
                      'Read All Reviews',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),


              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Small Stars (used in overall rating row) ──────────────────────────────────
class _SmallStars extends StatelessWidget {
  final double rating;

  const _SmallStars({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        if (i < rating.floor()) {
          return const Icon(Icons.star_rounded,
              color: Color(0xFFFFA500), size: 13);
        } else if (i < rating) {
          return const Icon(Icons.star_half_rounded,
              color: Color(0xFFFFA500), size: 13);
        } else {
          return const Icon(Icons.star_outline_rounded,
              color: Color(0xFFFFA500), size: 13);
        }
      }),
    );
  }
}