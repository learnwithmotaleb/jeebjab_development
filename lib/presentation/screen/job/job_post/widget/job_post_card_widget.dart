import 'package:flutter/material.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/service/api_url.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';

import '../model/job_post_model.dart';

class JobPostCard extends StatelessWidget {
  final PostItem post;
  final VoidCallback onTap;

  const JobPostCard({super.key, required this.post, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final imageUrl =
        post.photo != null && post.photo!.isNotEmpty
            ? ApiUrl.buildImageUrl(post.photo!)
            : '';

    final distanceLabel =
        post.distanceKm != null
            ? '${post.distanceKm!.toStringAsFixed(1)} KM'
            : 'N/A';

    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Image with overlays ────────────────────────────────────────────
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.r(12)),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // ── Photo ─────────────────────────────────────────────────
                  imageUrl.isNotEmpty
                      ? Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          loadingBuilder: (_, child, progress) {
                            if (progress == null) return child;
                            return Container(
                              color: const Color(0xFFEEEEEE),
                              child: const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) => _imagePlaceholder(),
                        )
                      : _imagePlaceholder(),

                  // ── Category icon — bottom-left ────────────────────────────
                  Positioned(
                    bottom: Dimensions.h(8),
                    left: Dimensions.w(8),
                    child: Container(
                      padding: EdgeInsets.all(Dimensions.w(6)),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.45),
                        borderRadius: BorderRadius.circular(Dimensions.r(8)),
                      ),
                      child: Icon(
                        _categoryIcon(post.type),
                        color: Colors.white,
                        size: Dimensions.w(16),
                      ),
                    ),
                  ),

                  // ── Price — bottom-right ───────────────────────────────────
                  Positioned(
                    bottom: Dimensions.h(8),
                    right: Dimensions.w(8),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.w(8),
                        vertical: Dimensions.h(3),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(Dimensions.r(6)),
                      ),
                      child: Text(
                        'SAR ${post.price ?? 0}',
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
          ),

          SizedBox(height: Dimensions.h(8)),

          // ── Title ──────────────────────────────────────────────────────────
          Text(
            post.title ?? '',
            style: TextStyle(
              fontSize: Dimensions.f(13),
              fontWeight: FontWeight.w600,
              color: AppColors.labelColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          SizedBox(height: Dimensions.h(4)),

          // ── Distance ────────────────────────────────────────────────────────
          Row(
            children: [
              Icon(
                Icons.map_outlined,
                size: Dimensions.w(13),
                color: AppColors.greyColor,
              ),
              SizedBox(width: Dimensions.w(4)),
              Text(
                distanceLabel,
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

  // ── Helpers ────────────────────────────────────────────────────────────────

  Widget _imagePlaceholder() {
    return Container(
      color: const Color(0xFFE0E0E0),
      child: const Icon(Icons.image_outlined, color: Colors.grey, size: 40),
    );
  }

  IconData _categoryIcon(String? type) {
    switch (type) {
      case 'recycling':
        return Icons.recycling_outlined;
      case 'buy_for_me':
        return Icons.shopping_cart_outlined;
      case 'give_away':
        return Icons.card_giftcard_outlined;
      case 'move':
      default:
        return Icons.inventory_2_outlined;
    }
  }
}