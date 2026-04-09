import 'package:flutter/material.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../model/my_post_model.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  final VoidCallback? onTap;

  const PostCard({
    super.key,
    required this.post,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isTablet = Dimensions.isTablet;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(isTablet ? 20 : 16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(isTablet ? 20 : 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ── Left: Image ──────────────────────────────────────────────
              ClipRRect(
                borderRadius: BorderRadius.circular(isTablet ? 16 : 12),
                child: Image.network(
                  post.imageUrl,
                  width: isTablet ? 110 : 90,
                  height: isTablet ? 110 : 90,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: isTablet ? 110 : 90,
                    height: isTablet ? 110 : 90,
                    color: const Color(0xFFF5F6FA),
                    child: Icon(
                      Icons.image_not_supported_rounded,
                      color: AppColors.greyColor,
                      size: isTablet ? 40 : 24,
                    ),
                  ),
                ),
              ),

              SizedBox(width: isTablet ? 20 : 12),

              // ── Middle: Info ─────────────────────────────────────────────
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      post.title,
                      style: TextStyle(
                        fontSize: isTablet ? 18 : 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1A1A2E),
                      ),
                    ),
                    SizedBox(height: isTablet ? 8 : 4),
                    Text(
                      post.category,
                      style: TextStyle(
                        fontSize: isTablet ? 16 : 13,
                        color: AppColors.greyColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      post.date,
                      style: TextStyle(
                        fontSize: isTablet ? 16 : 13,
                        color: AppColors.greyColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      post.size,
                      style: TextStyle(
                        fontSize: isTablet ? 16 : 13,
                        color: AppColors.greyColor,
                      ),
                    ),
                  ],
                ),
              ),

              // ── Right: Status Badge + Price ──────────────────────────────
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _StatusBadge(status: post.status, isTablet: isTablet),
                  SizedBox(height: isTablet ? 24 : 16),
                  _PriceText(price: post.price, isTablet: isTablet),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Status Badge ──────────────────────────────────────────────────────────────
class _StatusBadge extends StatelessWidget {
  final PostStatus status;
  final bool isTablet;

  const _StatusBadge({required this.status, required this.isTablet});

  Color get _color {
    switch (status) {
      case PostStatus.pending:
        return AppColors.pendingColor;
      case PostStatus.active:
        return AppColors.activeColor;
      case PostStatus.completed:
        return AppColors.completeColor;
    }
  }

  String get _label {
    switch (status) {
      case PostStatus.pending:
        return 'Pending';
      case PostStatus.active:
        return 'Active';
      case PostStatus.completed:
        return 'Completed';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 16 : 10,
        vertical: isTablet ? 8 : 5,
      ),
      decoration: BoxDecoration(
        color: _color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _label,
        style: TextStyle(
          color: AppColors.whiteColor,
          fontSize: isTablet ? 12 : 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ── Price Text ────────────────────────────────────────────────────────────────
class _PriceText extends StatelessWidget {
  final double price;
  final bool isTablet;

  const _PriceText({required this.price, required this.isTablet});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'SAR ',
            style: TextStyle(
              fontSize: isTablet ? 14 : 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1A1A2E),
            ),
          ),
          TextSpan(
            text: price.toInt().toString(),
            style: TextStyle(
              fontSize: isTablet ? 24 : 22,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1A1A2E),
            ),
          ),
        ],
      ),
    );
  }
}