import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/static_strings/static_strings.dart';

class RestrictedItemsWidget extends StatelessWidget {
  final List<String> items;

  const RestrictedItemsWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // ── No-entry icon ────────────────────────────────────────────────
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.red.withOpacity(0.5),
              width: 3,
            ),
          ),
          child: Center(
            child: Transform.rotate(
              angle: pi / 6, // 30 degrees
              child: Container(
                width: double.infinity,
                height: 3,
                color: Colors.red.withOpacity(0.5),
              ),
            ),
          ),
        ),

        const SizedBox(height: 14),

        // ── Warning title ────────────────────────────────────────────────
        Text(
          AppStrings.restrictedItemsTitle.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A2E),
            height: 1.4,
          ),
        ),

        const SizedBox(height: 16),

        // ── Example label ────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Align(
            alignment: AlignmentGeometry.centerLeft,
            child: Text(
              AppStrings.exampleOfSuchAsItemsAre.tr,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.blackColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        const SizedBox(height: 8),

        // ── Bullet list ──────────────────────────────────────────────────
        ...items.map(
              (item) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '• ',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.blackColor,
                  ),
                ),
                Expanded(
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.blackColor,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}