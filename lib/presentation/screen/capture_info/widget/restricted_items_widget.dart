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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Warning Icon ────────────────────────────────────────────────
          Align(
            alignment: Alignment.center,
            child: Container(
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
              )
            ),
          ),

          const SizedBox(height: 12),

          // ── Warning title ────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              AppStrings.restrictedItemsTitle.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1A1A2E),
                height: 1.3,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // ── Content Wrapper for items (Left Aligned) ───────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Example label ──────────────────────────────────────────
                Text(
                  AppStrings.exampleOfSuchAsItemsAre.tr,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 10),

                // ── Bullet list ────────────────────────────────────────────
                ...items.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '• ',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            item,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade800
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}