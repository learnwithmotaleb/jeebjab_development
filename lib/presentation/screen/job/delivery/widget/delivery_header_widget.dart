import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';

class DeliveryHeader extends StatelessWidget {
  final String title;

  const DeliveryHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.w(16),
        vertical: Dimensions.h(16),
      ),
      child: Row(
        children: [
          // ── Back Button ────────────────────────────────────────────
          GestureDetector(
            onTap: () => Get.back(),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: Dimensions.w(24),
              color: AppColors.labelColor,
            ),
          ),

          // ── Title ──────────────────────────────────────────────────
          Expanded(
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: Dimensions.f(18),
                  fontWeight: FontWeight.w700,
                  color: AppColors.labelColor,
                ),
              ),
            ),
          ),

          // ── Spacer ─────────────────────────────────────────────────
          SizedBox(width: Dimensions.w(24)),
        ],
      ),
    );
  }
}