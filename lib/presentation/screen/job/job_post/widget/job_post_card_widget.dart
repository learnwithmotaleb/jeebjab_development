import 'package:flutter/material.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';

import '../controller/job_post_controller.dart';

class JobPostCard extends StatelessWidget {
  final JobPostModel post;
  final VoidCallback onTap;

  const JobPostCard({super.key, required this.post, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Image with price overlay ────────────────────────────────
          ClipRRect(
            borderRadius: BorderRadius.circular(Dimensions.r(12)),
            child: Stack(
              children: [
                // Image
                AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                    post.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: const Color(0xFFE0E0E0),
                      child: const Icon(Icons.image_outlined,
                          color: Colors.grey, size: 40),
                    ),
                  ),
                ),

                // Category icon bottom-left
                Positioned(
                  bottom: Dimensions.h(8),
                  left: Dimensions.w(8),
                  child: Container(
                    padding: EdgeInsets.all(Dimensions.w(6)),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(Dimensions.r(8)),
                    ),
                    child: Icon(
                      post.categoryIcon == 'recycle'
                          ? Icons.recycling_outlined
                          : Icons.inventory_2_outlined,
                      color: Colors.white,
                      size: Dimensions.w(16),
                    ),
                  ),
                ),

                // Price bottom-right
                Positioned(
                  bottom: Dimensions.h(8),
                  right: Dimensions.w(8),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.w(8),
                      vertical: Dimensions.h(3),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(Dimensions.r(6)),
                    ),
                    child: Text(
                      'SAR ${post.price.toInt()}',
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

          SizedBox(height: Dimensions.h(8)),

          // ── Title ───────────────────────────────────────────────────
          Text(
            post.title,
            style: TextStyle(
              fontSize: Dimensions.f(13),
              fontWeight: FontWeight.w600,
              color: AppColors.labelColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          SizedBox(height: Dimensions.h(4)),

          // ── Distance ────────────────────────────────────────────────
          Row(
            children: [
              Icon(
                Icons.map_outlined,
                size: Dimensions.w(13),
                color: AppColors.greyColor,
              ),
              SizedBox(width: Dimensions.w(4)),
              Text(
                post.distance,
                style: TextStyle(
                  fontSize: Dimensions.f(11),
                  color: AppColors.greyColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}