import 'package:flutter/material.dart';
import 'package:jeebjab/presentation/screen/review_profile/controller/review_profile_controller.dart';

class ReviewListItemWidget extends StatelessWidget {
  final ReviewModel review;

  const ReviewListItemWidget({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEEEEEE)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
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
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              Text(
                review.timeAgo,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          // ── Stars ──────────────────────────────────────────────────────
          Row(
            children: List.generate(5, (i) {
              return Icon(
                i < review.rating.floor()
                    ? Icons.star_rounded
                    : Icons.star_outline_rounded,
                size: 17,
                color: const Color(0xFFFFA500),
              );
            }),
          ),

          const SizedBox(height: 8),

          // ── Title ──────────────────────────────────────────────────────
          Text(
            review.title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A2E),
            ),
          ),

          const SizedBox(height: 4),

          // ── Body ───────────────────────────────────────────────────────
          Text(
            review.body,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF777777),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}