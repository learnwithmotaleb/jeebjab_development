import 'package:flutter/material.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
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
        SizedBox(height: Dimensions.h(24)),

        // ── Avatar with Premium Gaps ──────────────────────────────────────
        Container(
          padding: EdgeInsets.all(Dimensions.r(4)),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primaryColor.withOpacity(0.2), width: 2),
          ),
          child: CircleAvatar(
            radius: Dimensions.r(50),
            backgroundColor: const Color(0xFFF5F5F5),
            backgroundImage: NetworkImage(imageUrl),
            onBackgroundImageError: (_, __) {},
          ),
        ),

        SizedBox(height: Dimensions.h(16)),

        // ── Name ──────────────────────────────────────────────────────────
        Text(
          name,
          style: TextStyle(
            fontSize: Dimensions.f(22),
            fontWeight: FontWeight.w800,
            color: const Color(0xFF1A1A2E),
            letterSpacing: 0.5,
          ),
        ),

        SizedBox(height: Dimensions.h(4)),

        // ── Phone ─────────────────────────────────────────────────────────
        Text(
          phone,
          style: TextStyle(
            fontSize: Dimensions.f(14),
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),

        SizedBox(height: Dimensions.h(16)),

        // ── Star Row + Rating Number ──────────────────────────────────────
        Container(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w(20), vertical: Dimensions.h(10)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Dimensions.r(30)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _StarRow(rating: rating),
              SizedBox(width: Dimensions.w(12)),
              Text(
                rating.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: Dimensions.f(24),
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF1A1A2E),
                ),
              ),
              SizedBox(width: Dimensions.w(6)),
              Text(
                'Ratings',
                style: TextStyle(
                  fontSize: Dimensions.f(13), 
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: Dimensions.h(24)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w(24)),
          child: const Divider(color: Color(0xFFF0F0F0), thickness: 1.5),
        ),
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
          return Icon(Icons.star_rounded,
              color: const Color(0xFFFFA500), size: Dimensions.f(26));
        } else if (i < rating) {
          return Icon(Icons.star_half_rounded,
              color: const Color(0xFFFFA500), size: Dimensions.f(26));
        } else {
          return Icon(Icons.star_outline_rounded,
              color: const Color(0xFFFFA500), size: Dimensions.f(26));
        }
      }),
    );
  }
}