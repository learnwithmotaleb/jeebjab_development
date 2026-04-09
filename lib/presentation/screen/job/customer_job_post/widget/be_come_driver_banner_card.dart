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
    final bool isTablet = Dimensions.isTablet;

    return Container(
      width: double.infinity,
      height: isTablet ? 350 : 280,
      padding: EdgeInsets.all(isTablet ? 48 : Dimensions.w(24)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isTablet ? 30 : Dimensions.r(20)),
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
              fontSize: isTablet ? 32 : Dimensions.f(20),
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1.3,
            ),
          ),

          SizedBox(height: Dimensions.h(24)),

          // ── Become a Driver button ────────────────────────────────────
          GestureDetector(
            onTap: onBecomeDriver,
            child: Container(
              width: isTablet ? 300 : double.infinity,
              height: isTablet ? 100 : 65,
              padding: EdgeInsets.symmetric(
                vertical: isTablet ? 20 : Dimensions.h(16),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimensions.r(30)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                AppStrings.becomeADriver.tr,
                style: TextStyle(
                  fontSize: isTablet ? 18 : Dimensions.f(15),
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