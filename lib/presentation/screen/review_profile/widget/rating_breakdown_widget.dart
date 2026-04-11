import 'package:flutter/material.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';

class RatingBreakdownWidget extends StatelessWidget {
  final double overallRating;
  final int totalReviews;
  final Map<int, int> breakdown;
  final int maxCount;

  const RatingBreakdownWidget({
    super.key,
    required this.overallRating,
    required this.totalReviews,
    required this.breakdown,
    required this.maxCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimensions.w(16)),
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
          Text(
            'Rating Breakdown',
            style: TextStyle(
              fontSize: Dimensions.f(17),
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1A1A2E),
            ),
          ),
          SizedBox(height: Dimensions.h(20)),

          // ── Bar Rows 5 → 1 ────────────────────────────────────────────
          ...List.generate(5, (i) {
            final star = 5 - i;
            final count = breakdown[star] ?? 0;
            final fraction = maxCount > 0 ? count / maxCount : 0.0;
            return _RatingBarRow(
              star: star,
              count: count,
              fraction: fraction,
            );
          }),
        ],
      ),
    );
  }
}

class _RatingBarRow extends StatelessWidget {
  final int star;
  final int count;
  final double fraction;

  const _RatingBarRow({
    required this.star,
    required this.count,
    required this.fraction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Dimensions.h(6)),
      child: Row(
        children: [
          // Star number
          SizedBox(
            width: Dimensions.w(12),
            child: Text(
              '$star',
              style: TextStyle(
                fontSize: Dimensions.f(13),
                fontWeight: FontWeight.w700,
                color: const Color(0xFF555555),
              ),
            ),
          ),
          SizedBox(width: Dimensions.w(6)),
          Icon(Icons.star_rounded, size: Dimensions.f(15), color: const Color(0xFFFFA500)),
          SizedBox(width: Dimensions.w(12)),

          // Progress bar
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.r(10)),
              child: LinearProgressIndicator(
                value: fraction,
                minHeight: Dimensions.h(10),
                backgroundColor: const Color(0xFFF5F5F5),
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFFA500)),
              ),
            ),
          ),

          SizedBox(width: Dimensions.w(16)),

          // Count
          SizedBox(
            width: Dimensions.w(32),
            child: Text(
              '$count',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: Dimensions.f(13),
                fontWeight: FontWeight.w700,
                color: const Color(0xFF555555),
              ),
            ),
          ),
        ],
      ),
    );
  }
}