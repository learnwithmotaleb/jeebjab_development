import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/utils/assets_image/app_images.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';

class DriverHeaderWidget extends StatelessWidget {
  final String name;
  final String email;
  final int completedJobs;
  final double totalEarn;
  final VoidCallback onNotification;

  const DriverHeaderWidget({
    super.key,
    required this.name,
    required this.email,
    required this.completedJobs,
    required this.totalEarn,
    required this.onNotification,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: Dimensions.h(50),
        bottom: Dimensions.h(20),
        left: Dimensions.w(20),
        right: Dimensions.w(20),
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(Dimensions.r(28)),
          bottomRight: Radius.circular(Dimensions.r(28)),
        ),
      ),
      child: Column(
        children: [
          // ── App logo ──────────────────────────────────────────────────
          Image.asset(AppImages.appLogo, width: 100, height: 100),

          SizedBox(height: Dimensions.h(10)),

          // ── Profile row ───────────────────────────────────────────────
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(RoutePath.profile);
                },
                child: CircleAvatar(
                  radius: Dimensions.w(22),
                  backgroundImage: AssetImage(AppImages.profileImage),
                ),
              ),
              SizedBox(width: Dimensions.w(12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: Dimensions.f(15),
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      email,
                      style: TextStyle(
                        fontSize: Dimensions.f(12),
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
              // ── Notification bell ─────────────────────────────────────
              GestureDetector(
                onTap: onNotification,
                child: Container(
                  width: Dimensions.w(40),
                  height: Dimensions.w(40),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.notifications_outlined,
                    color: AppColors.primaryColor,
                    size: Dimensions.w(20),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: Dimensions.h(16)),

          // ── Stats row ─────────────────────────────────────────────────
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.w(20),
              vertical: Dimensions.h(12),
            ),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(Dimensions.r(12)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _StatItem(
                    label: AppStrings.completedJobs.tr,
                    value: completedJobs.toString(),
                  ),
                ),
                Container(
                  width: 1,
                  height: Dimensions.h(32),
                  color: Colors.black.withOpacity(0.3),
                ),
                Expanded(
                  child: _StatItem(
                    label: AppStrings.totalEarn.tr,
                    value: '${AppStrings.aed.tr} ${totalEarn.toInt()}',
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

class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: Dimensions.f(11),
            color: AppColors.greyColor,
          ),
        ),
        SizedBox(height: Dimensions.h(4)),
        Text(
          value,
          style: TextStyle(
            fontSize: Dimensions.f(16),
            fontWeight: FontWeight.w800,
            color: AppColors.blackColor,
          ),
        ),
      ],
    );
  }
}