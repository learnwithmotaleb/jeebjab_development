import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';

class BecomeDriverBannerCard extends StatelessWidget {
  final VoidCallback onBecomeDriver;

  const BecomeDriverBannerCard({
    super.key,
    required this.onBecomeDriver,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 280,
      padding: EdgeInsets.all(Dimensions.w(24)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.r(20)),
        gradient: const LinearGradient(
          colors: [
            Color(0xFFF3F3F3), // light mint
            Color(0xFF17C5B5), // teal
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: Dimensions.h(16)),

          // ── Headline ──────────────────────────────────────────────────
          Text(
          AppStrings.startDrivingStartEarning.tr,
            style: TextStyle(
              fontSize: Dimensions.f(20),
              fontWeight: FontWeight.w700,
              color: Colors.white,
              height: 1.4,
            ),
          ),

          SizedBox(height: Dimensions.h(24)),

          // ── Become a Driver button ────────────────────────────────────
          GestureDetector(
            onTap: onBecomeDriver,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: Dimensions.h(16)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimensions.r(30)),
              ),
              alignment: Alignment.center,
              child: Text(
               AppStrings.becomeADriver.tr,
                style: TextStyle(
                  fontSize: Dimensions.f(15),
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),

          SizedBox(height: Dimensions.h(8)),
        ],
      ),
    );
  }
}