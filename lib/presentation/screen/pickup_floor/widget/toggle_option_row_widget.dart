import 'package:flutter/material.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';

class ToggleOptionRow extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const ToggleOptionRow({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isTablet = Dimensions.isTablet;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.w(isTablet ? 24 : 16),
          vertical: Dimensions.h(isTablet ? 20 : 14),
        ),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(Dimensions.r(isTablet ? 16 : 10)),
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : const Color(0xFFE8E8E8),
            width: isSelected ? (isTablet ? 2.5 : 1.5) : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: isTablet ? 10 : 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // ── Label ────────────────────────────────────────────────
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: Dimensions.f(isTablet ? 16 : 14),
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1A1A2E),
                ),
              ),
            ),

            // ── Radio indicator ───────────────────────────────────────
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: Dimensions.w(isTablet ? 30 : 22),
              height: Dimensions.w(isTablet ? 30 : 22),
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
                  width: Dimensions.w(isTablet ? 16 : 12),
                  height: Dimensions.w(isTablet ? 16 : 12),
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