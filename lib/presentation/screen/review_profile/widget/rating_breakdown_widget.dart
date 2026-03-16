import 'package:flutter/material.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';

class RatingBreakdownWidget extends StatelessWidget {
  final double overallRating;
  final int totalReviews;
  final Map<int, int> breakdown; // { 5: 80, 4: 20, ... }
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
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEEEEEE)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ratings',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A2E),
            ),
          ),
          const SizedBox(height: 14),

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
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          // Star number
          Text(
            '$star',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF555555),
            ),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.star_rounded, size: 13, color: Color(0xFFFFA500)),
          const SizedBox(width: 8),

          // Progress bar
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: fraction,
                minHeight: 7,
                backgroundColor: const Color(0xFFEEEEEE),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFFFFA500),
                ),
              ),
            ),
          ),

          const SizedBox(width: 10),

          // Count
          SizedBox(
            width: 24,
            child: Text(
              '$count',
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF555555),
              ),
            ),
          ),
        ],
      ),
    );
  }
}