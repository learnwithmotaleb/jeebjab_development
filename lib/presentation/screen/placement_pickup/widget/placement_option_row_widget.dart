import 'package:flutter/material.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';

class PlacementOptionRow extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final bool isRadio; // true = single select circle, false = multi checkbox
  final VoidCallback onTap;

  const PlacementOptionRow({
    super.key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    this.isRadio = true,
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
            horizontal: 16, 
            vertical: isTablet ? 18 : 14
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(isTablet ? 16 : 10),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryColor
                : const Color(0xFFE8E8E8),
            width: isSelected ? (isTablet ? 2.5 : 1.5) : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: isTablet ? 8 : 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // ── Icon ──────────────────────────────────────────────────
            Icon(
              icon, 
              size: isTablet ? 28 : 22, 
              color: isSelected ? AppColors.primaryColor : const Color(0xFF888888)
            ),
            const SizedBox(width: 12),

            // ── Label ─────────────────────────────────────────────────
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: isTablet ? 17 : 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1A1A2E),
                ),
              ),
            ),

            // ── Radio / Checkbox indicator ────────────────────────────
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: isTablet ? 28 : 22,
              height: isTablet ? 28 : 22,
              decoration: BoxDecoration(
                shape: isRadio ? BoxShape.circle : BoxShape.rectangle,
                borderRadius: isRadio ? null : BorderRadius.circular(100),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryColor
                      : const Color(0xFFCCCCCC),
                  width: 2,
                ),
                color: isSelected ? AppColors.primaryColor : Colors.white,
              ),
              child: isSelected
                  ? Icon(
                      Icons.check, 
                      size: isTablet ? 18 : 13, 
                      color: Colors.white
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}