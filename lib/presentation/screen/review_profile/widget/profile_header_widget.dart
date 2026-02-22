import 'package:flutter/material.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final String name;
  final String phone;
  final String imageUrl;
  final double rating;
  final int totalReviews;

  const ProfileHeaderWidget({
    super.key,
    required this.name,
    required this.phone,
    required this.imageUrl,
    required this.rating,
    required this.totalReviews,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),

        // ── Avatar ────────────────────────────────────────────────────────
        CircleAvatar(
          radius: 46,
          backgroundColor: const Color(0xFFEEEEEE),
          backgroundImage: NetworkImage(imageUrl),
          onBackgroundImageError: (_, __) {},
        ),

        const SizedBox(height: 12),

        // ── Name ──────────────────────────────────────────────────────────
        Text(
          name,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A2E),
          ),
        ),

        const SizedBox(height: 4),

        // ── Phone ─────────────────────────────────────────────────────────
        Text(
          phone,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.grey,
          ),
        ),

        const SizedBox(height: 12),

        // ── Star Row + Rating Number ──────────────────────────────────────
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _StarRow(rating: rating),
            const SizedBox(width: 8),
            Text(
              rating.toStringAsFixed(1),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1A1A2E),
              ),
            ),
            const SizedBox(width: 4),
            const Text(
              'Ratings',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ],
        ),

        const SizedBox(height: 20),
        const Divider(color: Color(0xFFEEEEEE), thickness: 1),
      ],
    );
  }
}

class _StarRow extends StatelessWidget {
  final double rating;

  const _StarRow({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        if (i < rating.floor()) {
          return const Icon(Icons.star_rounded,
              color: Color(0xFFFFA500), size: 26);
        } else if (i < rating) {
          return const Icon(Icons.star_half_rounded,
              color: Color(0xFFFFA500), size: 26);
        } else {
          return const Icon(Icons.star_outline_rounded,
              color: Color(0xFFFFA500), size: 26);
        }
      }),
    );
  }
}