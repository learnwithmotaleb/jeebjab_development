import 'package:flutter/material.dart';
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ── Left: Image ──────────────────────────────────────────────
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  post.imageUrl,
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 90,
                    height: 90,
                    color: const Color(0xFFF5F6FA),
                    child: const Icon(
                      Icons.image_not_supported_rounded,
                      color: AppColors.greyColor,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // ── Middle: Info ─────────────────────────────────────────────
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      post.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      post.category,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.greyColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      post.date,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.greyColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      post.size,
                      style: const TextStyle(
                        fontSize: 13,
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
                  _StatusBadge(status: post.status),
                  const SizedBox(height: 16),
                  _PriceText(price: post.price),
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

  const _StatusBadge({required this.status});

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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: _color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _label,
        style: const TextStyle(
          color: AppColors.whiteColor,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ── Price Text ────────────────────────────────────────────────────────────────
class _PriceText extends StatelessWidget {
  final double price;

  const _PriceText({required this.price});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          const TextSpan(
            text: 'SAR ',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A2E),
            ),
          ),
          TextSpan(
            text: price.toInt().toString(),
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1A1A2E),
            ),
          ),
        ],
      ),
    );
  }
}