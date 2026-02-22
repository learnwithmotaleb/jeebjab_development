import 'package:flutter/material.dart';
import 'package:jeebjab/presentation/screen/create_post/controller/create_post_controller.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';

class CategoryCardWidget extends StatelessWidget {
  final PostCategoryModel category;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryCardWidget({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool enabled = category.isEnabled;

    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryColor
                : const Color(0xFFDDDDDD),
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ]
              : [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ── Title ────────────────────────────────────────────────────
            SizedBox(
              width: 90,
              child: Text(
                category.title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: enabled
                      ? AppColors.primaryColor
                      : AppColors.greyColor.withOpacity(0.5),
                ),
              ),
            ),


            // ── Subtitle ─────────────────────────────────────────────────
            Expanded(
              child: Text(
                category.subtitle,
                style: TextStyle(
                  fontSize: 12,
                  height: 1.4,
                  color: enabled
                      ? AppColors.blackColor
                      : AppColors.greyColor.withOpacity(0.4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}