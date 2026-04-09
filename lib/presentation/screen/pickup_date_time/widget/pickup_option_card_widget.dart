import 'package:flutter/material.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';

class PickupOptionCard extends StatelessWidget {
  final String type;
  final String title;
  final bool isSelected;
  final bool showArrow;
  final bool arrowDown;
  final VoidCallback onTap;

  const PickupOptionCard({
    super.key,
    required this.type,
    required this.title,
    required this.isSelected,
    required this.onTap,
    this.showArrow = false,
    this.arrowDown = true,
  });

  @override
  Widget build(BuildContext context) {
    final bool isTablet = Dimensions.isTablet;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
            horizontal: 16, 
            vertical: isTablet ? 20 : 14
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(isTablet ? 16 : 12),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryColor
                : const Color(0xFFE8E8E8),
            width: isSelected ? (isTablet ? 2.5 : 1.5) : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: isTablet ? 8 : 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // ── Clock Icon ──────────────────────────────────────────────
            Icon(
              Icons.access_time_rounded,
              size: isTablet ? 32 : 22,
              color: isSelected ? AppColors.primaryColor : Colors.grey,
            ),

            const SizedBox(width: 12),

            // ── Labels ──────────────────────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    type,
                    style: TextStyle(
                      fontSize: isTablet ? 14 : 11,
                      fontWeight: FontWeight.w500,
                      color: isSelected
                          ? AppColors.primaryColor
                          : Colors.grey,
                    ),
                  ),
                  SizedBox(height: isTablet ? 4 : 2),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: isTablet ? 18 : 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1A1A2E),
                    ),
                  ),
                ],
              ),
            ),

            // ── Radio / Arrow ────────────────────────────────────────────
            if (showArrow)
              Icon(
                arrowDown
                    ? Icons.keyboard_arrow_down_rounded
                    : Icons.keyboard_arrow_up_rounded,
                color: Colors.grey,
                size: isTablet ? 32 : 22,
              )
            else
              Container(
                width: isTablet ? 28 : 20,
                height: isTablet ? 28 : 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primaryColor
                        : const Color(0xFFCCCCCC),
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? Center(
                  child: Container(
                    width: isTablet ? 14 : 10,
                    height: isTablet ? 14 : 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryColor,
                    ),
                  ),
                )
                    : null,
              ),
          ],
        ),
      ),
    );
  }
}