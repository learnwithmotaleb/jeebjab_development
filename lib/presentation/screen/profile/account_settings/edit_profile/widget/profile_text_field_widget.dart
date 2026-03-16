import 'package:flutter/material.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';

class ProfileTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? suffixIcon;

  const ProfileTextField({
    super.key,
    required this.label,
    required this.controller,
    this.readOnly = false,
    this.onTap,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Label ─────────────────────────────────────────────────────
        Text(
          label,
          style: TextStyle(
            fontSize: Dimensions.f(13),
            fontWeight: FontWeight.w500,
            color: AppColors.greyColor,
          ),
        ),

        SizedBox(height: Dimensions.h(6)),

        // ── Field ──────────────────────────────────────────────────────
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(Dimensions.r(10)),
              border: Border.all(color: const Color(0xFFE8E8E8)),
            ),
            child: TextField(
              controller: controller,
              readOnly: readOnly,
              onTap: onTap,
              style: TextStyle(
                fontSize: Dimensions.f(14),
                fontWeight: FontWeight.w500,
                color: AppColors.labelColor,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: Dimensions.w(16),
                  vertical: Dimensions.h(14),
                ),
                border: InputBorder.none,
                suffixIcon: suffixIcon,
              ),
            ),
          ),
        ),
      ],
    );
  }
}