import 'package:flutter/material.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';

import '../controller/west_type_controller.dart';

class WasteItemTile extends StatelessWidget {
  final WasteItem item;
  final bool isSelected;
  final VoidCallback onTap; // toggles selection
  final VoidCallback onInfoTap; // navigates to info screen

  const WasteItemTile({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
    required this.onInfoTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isTablet = Dimensions.isTablet;
    // ── Info items (hasInfo=true) → tappable row → navigate, no checkbox ──
    final bool isNavigable = item.hasInfo;

    return GestureDetector(
      onTap: isNavigable ? onInfoTap : onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 48 : Dimensions.w(12),
          vertical: isTablet ? 18 : Dimensions.h(10),
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: Color(0xFFF2F2F2)),
          ),
        ),
        child: Row(
          children: [
            // ── Icon box ──────────────────────────────────────────────
            Container(
              width: isTablet ? 60 : Dimensions.w(44),
              height: isTablet ? 60 : Dimensions.w(44),
              decoration: BoxDecoration(
                color: (!isNavigable && isSelected)
                    ? AppColors.primaryColor.withOpacity(0.12)
                    : const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(isTablet ? 15 : Dimensions.r(10)),
              ),
              child: Icon(
                item.icon,
                size: isTablet ? 30 : Dimensions.w(22),
                color: (!isNavigable && isSelected)
                    ? AppColors.primaryColor
                    : const Color(0xFF888888),
              ),
            ),

            SizedBox(width: isTablet ? 20 : Dimensions.w(12)),

            // ── Label ─────────────────────────────────────────────────
            Expanded(
              child: Text(
                item.label,
                style: TextStyle(
                  fontSize: isTablet ? 18 : 14,
                  fontWeight: isTablet ? FontWeight.w600 : FontWeight.w500,
                  color: AppColors.labelColor,
                ),
              ),
            ),

            // ── Right side: arrow (navigable) OR checkbox (selectable) ──
            if (isNavigable)
              // Arrow → navigates to info page
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: isTablet ? 20 : 14,
                color: const Color(0xFFCCCCCC),
              )
            else
              // Teal checkbox
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: isTablet ? 30 : 22,
                height: isTablet ? 30 : 22,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(isTablet ? 8 : 5),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primaryColor
                        : const Color(0xFFCCCCCC),
                    width: 2.5,
                  ),
                ),
                child: isSelected
                    ? Icon(Icons.check_rounded,
                        size: isTablet ? 20 : 14, color: Colors.white)
                    : null,
              ),
          ],
        ),
      ),
    );
  }
}