import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/utils/app_text_style/app_text_style.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import 'package:jeebjab/widget/custom_appbar.dart';

import '../../../../core/responsive_layout/dimensions.dart';
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
    return ResponsiveLayout(
      mobile: _buildMobile(),
      tablet: _buildTablet(),
    );
  }

  Widget _buildTablet() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.advertiser.tr),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Obx(
                () => SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: Dimensions.h(24), horizontal: Dimensions.w(16)),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Column: Profile Info & Breakdown
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              ProfileHeaderWidget(
                                name: controller.name.value,
                                phone: controller.phone.value,
                                imageUrl: controller.profileImage.value,
                                rating: controller.overallRating.value,
                                totalReviews: controller.totalReviews.value,
                              ),
                              SizedBox(height: Dimensions.h(24)),
                              RatingBreakdownWidget(
                                overallRating: controller.overallRating.value,
                                totalReviews: controller.totalReviews.value,
                                breakdown: controller.ratingBreakdown,
                                maxCount: controller.maxRatingCount,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: Dimensions.w(32)),
                        // Right Column: Reviews
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: Dimensions.w(16)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppStrings.reviewAndRatings.tr,
                                      style: TextStyle(
                                        fontSize: Dimensions.f(20),
                                        fontWeight: FontWeight.w800,
                                        color: const Color(0xFF1A1A2E),
                                      ),
                                    ),
                                    SizedBox(height: Dimensions.h(6)),
                                    Text(
                                      AppStrings.whatOthersThinkAboutYou.tr,
                                      style: TextStyle(
                                        fontSize: Dimensions.f(14),
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: Dimensions.h(24)),
                              ...controller.reviews.map(
                                    (review) => Padding(
                                  padding: EdgeInsets.only(bottom: Dimensions.h(16)),
                                  child: ReviewCardWidget(review: review),
                                ),
                              ),
                              SizedBox(height: Dimensions.h(16)),
                              Center(
                                child: ElevatedButton(
                                  onPressed: controller.onReadAllReviews,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                    padding: EdgeInsets.symmetric(horizontal: Dimensions.w(32), vertical: Dimensions.h(14)),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(Dimensions.r(30)),
                                    ),
                                  ),
                                  child: Text(
                                    'Read All Reviews',
                                    style: TextStyle(
                                      fontSize: Dimensions.f(14),
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Dimensions.h(40)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.advertiser.tr),
      body: Obx(
            () => SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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

              SizedBox(height: Dimensions.h(16)),

              // ── 2. Section Title ────────────────────────────────────────
               Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                     AppStrings.reviewAndRatings.tr,
                      style: TextStyle(
                        fontSize: Dimensions.f(16),
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF1A1A2E),
                      ),
                    ),
                    SizedBox(height: Dimensions.h(4)),
                    Text(
                      AppStrings.whatOthersThinkAboutYou.tr,
                      style: TextStyle(
                        fontSize: Dimensions.f(13),
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: Dimensions.h(20)),

              // ── 3. Overall Rating Row ───────────────────────────────────
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w(16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(
                          AppStrings.reviewAndRatings.tr,
                          style: TextStyle(
                            fontSize: Dimensions.f(13),
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1A1A2E),
                          ),
                        ),
                        SizedBox(height: Dimensions.h(4)),
                        Row(
                          children: [
                            Text(
                              controller.overallRating.value
                                  .toStringAsFixed(1),
                              style: TextStyle(
                                fontSize: Dimensions.f(13),
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF1A1A2E),
                              ),
                            ),
                            SizedBox(width: Dimensions.w(4)),
                            _SmallStars(
                                rating: controller.overallRating.value),
                            SizedBox(width: Dimensions.w(4)),
                            Text(
                              '(${controller.totalReviews.value} Rating)',
                              style: TextStyle(
                                  fontSize: Dimensions.f(11), color: Colors.grey[500]),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      '${controller.totalReviews.value} Review',
                      style: TextStyle(
                        fontSize: Dimensions.f(13),
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1A1A2E),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: Dimensions.h(20)),

              // ── 4. Rating Breakdown Card ────────────────────────────────
              RatingBreakdownWidget(
                overallRating: controller.overallRating.value,
                totalReviews: controller.totalReviews.value,
                breakdown: controller.ratingBreakdown,
                maxCount: controller.maxRatingCount,
              ),

              SizedBox(height: Dimensions.h(24)),

              // ── 5. Review Cards ─────────────────────────────────────────
              ...controller.reviews.map(
                    (review) => Padding(
                  padding: EdgeInsets.only(bottom: Dimensions.h(12)),
                  child: ReviewCardWidget(review: review),
                ),
              ),

              SizedBox(height: Dimensions.h(8)),

              // ── 6. Read All Reviews Button ──────────────────────────────
              Center(
                  child: TextButton(
                    onPressed: controller.onReadAllReviews,
                    child: Text(
                      'Read All Reviews',
                      style: TextStyle(
                        fontSize: Dimensions.f(14),
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),


              SizedBox(height: Dimensions.h(40)),
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
          return Icon(Icons.star_rounded,
              color: const Color(0xFFFFA500), size: Dimensions.f(14));
        } else if (i < rating) {
          return Icon(Icons.star_half_rounded,
              color: const Color(0xFFFFA500), size: Dimensions.f(14));
        } else {
          return Icon(Icons.star_outline_rounded,
              color: const Color(0xFFFFA500), size: Dimensions.f(14));
        }
      }),
    );
  }
}