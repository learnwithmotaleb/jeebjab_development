import 'package:flutter/material.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';

import '../controller/driver_home_controller.dart';

class RecentJobCard extends StatelessWidget {
  final RecentJob job;
  final VoidCallback onTap;

  const RecentJobCard({super.key, required this.job, required this.onTap});

  IconData get _icon {
    switch (job.categoryIcon) {
      case 'recycle':
        return Icons.recycling_outlined;
      default:
        return Icons.inventory_2_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Image with overlays ────────────────────────────────────────
          ClipRRect(
            borderRadius: BorderRadius.circular(Dimensions.r(12)),
            child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                    job.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: const Color(0xFFE0E0E0),
                      child: const Icon(Icons.image_outlined, color: Colors.grey),
                    ),
                  ),
                ),
                // ── Category icon bottom-left ──────────────────────────
                Positioned(
                  bottom: Dimensions.h(8),
                  left: Dimensions.w(8),
                  child: Container(
                    padding: EdgeInsets.all(Dimensions.w(5)),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(Dimensions.r(6)),
                    ),
                    child: Icon(_icon, color: Colors.white, size: Dimensions.w(14)),
                  ),
                ),
                // ── Price bottom-right ─────────────────────────────────
                Positioned(
                  bottom: Dimensions.h(8),
                  right: Dimensions.w(8),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.w(7),
                      vertical: Dimensions.h(3),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(Dimensions.r(6)),
                    ),
                    child: Text(
                      'AED ${job.price.toInt()}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimensions.f(11),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: Dimensions.h(6)),

          Text(
            job.title,
            style: TextStyle(
              fontSize: Dimensions.f(13),
              fontWeight: FontWeight.w600,
              color: AppColors.labelColor,
            ),
          ),

          SizedBox(height: Dimensions.h(3)),

          Row(
            children: [
              Icon(Icons.map_outlined, size: Dimensions.w(12), color: AppColors.greyColor),
              SizedBox(width: Dimensions.w(4)),
              Text(
                job.distance,
                style: TextStyle(fontSize: Dimensions.f(11), color: AppColors.greyColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}