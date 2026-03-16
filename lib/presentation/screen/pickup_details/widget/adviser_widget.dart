import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';

class AdvertiserWidget extends StatelessWidget {
  final String name;
  final double rating;
  final String imageUrl;
  final VoidCallback? onTap;   // 👈 add this

  const AdvertiserWidget({
    super.key,
    required this.name,
    required this.rating,
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          AppStrings.advertiser.tr,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A2E),
          ),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap:  onTap,
          child: Row(
            children: [
              // ── Avatar ────────────────────────────────────────────────────
              CircleAvatar(
                radius: 24,
                backgroundColor:AppColors.whiteColor,
                backgroundImage: NetworkImage(imageUrl),
                onBackgroundImageError: (_, __) {},
              ),
               SizedBox(width: Dimensions.w(20)),

              // ── Name + Stars ──────────────────────────────────────────────
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      _StarRating(rating: rating),
                      const SizedBox(width: 4),
                      Text(
                        rating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StarRating extends StatelessWidget {
  final double rating;

  const _StarRating({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (i) {
        if (i < rating.floor()) {
          return const Icon(Icons.star_rounded,
              color: Color(0xFFFFC107), size: 16);
        } else if (i < rating) {
          return const Icon(Icons.star_half_rounded,
              color: Color(0xFFFFC107), size: 16);
        } else {
          return const Icon(Icons.star_outline_rounded,
              color: Color(0xFFFFC107), size: 16);
        }
      }),
    );
  }
}