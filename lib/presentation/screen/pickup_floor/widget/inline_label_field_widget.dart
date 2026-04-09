import 'package:flutter/material.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';

class InlineLabelField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;

  const InlineLabelField({
    super.key,
    required this.label,
    required this.controller,
    this.hint = '',
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    final bool isTablet = Dimensions.isTablet;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.w(isTablet ? 24 : 16),
        vertical: Dimensions.h(isTablet ? 12 : 4),
      ),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(Dimensions.r(isTablet ? 16 : 10)),
        border: Border.all(color: const Color(0xFFE8E8E8)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: isTablet ? 8 : 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // ── Label ────────────────────────────────────────────────────
          SizedBox(
            width: Dimensions.w(isTablet ? 140 : 90),
            child: Text(
              label,
              style: TextStyle(
                fontSize: Dimensions.f(isTablet ? 16 : 14),
                fontWeight: FontWeight.w600,
                color: AppColors.labelColor,
              ),
            ),
          ),

          // ── Divider ──────────────────────────────────────────────────
          Container(
            width: 1,
            height: Dimensions.h(isTablet ? 36 : 28),
            color: const Color(0xFFE8E8E8),
            margin: EdgeInsets.symmetric(horizontal: Dimensions.w(isTablet ? 20 : 12)),
          ),

          // ── Input ────────────────────────────────────────────────────
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: Dimensions.f(isTablet ? 16 : 14),
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1A1A2E),
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  fontSize: Dimensions.f(isTablet ? 16 : 14),
                  color: AppColors.hintColor,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  vertical: Dimensions.h(isTablet ? 16 : 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}