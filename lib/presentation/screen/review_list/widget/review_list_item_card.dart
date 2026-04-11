import 'package:flutter/material.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/presentation/screen/review_profile/controller/review_profile_controller.dart';

class ReviewListItemWidget extends StatelessWidget {
  final ReviewModel review;

  const ReviewListItemWidget({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimensions.w(16), vertical: Dimensions.h(8)),
      padding: EdgeInsets.all(Dimensions.w(20)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.r(20)),
        border: Border.all(color: const Color(0xFFF0F0F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Username + Time ────────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                review.username,
                style: TextStyle(
                  fontSize: Dimensions.f(15),
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1A1A2E),
                ),
              ),
              Text(
                review.timeAgo,
                style: TextStyle(
                  fontSize: Dimensions.f(12),
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          SizedBox(height: Dimensions.h(8)),

          // ── Stars ──────────────────────────────────────────────────────
          Row(
            children: List.generate(5, (i) {
              return Icon(
                i < review.rating.floor()
                    ? Icons.star_rounded
                    : Icons.star_outline_rounded,
                size: Dimensions.f(17),
                color: const Color(0xFFFFA500),
              );
            }),
          ),

          SizedBox(height: Dimensions.h(12)),

          // ── Title ──────────────────────────────────────────────────────
          Text(
            review.title,
            style: TextStyle(
              fontSize: Dimensions.f(15),
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1A1A2E),
            ),
          ),

          SizedBox(height: Dimensions.h(6)),

          // ── Body ───────────────────────────────────────────────────────
          Text(
            review.body,
            style: TextStyle(
              fontSize: Dimensions.f(14),
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}