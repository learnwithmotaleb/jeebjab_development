import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/utils/assets_image/app_images.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';

import '../controller/driver_home_controller.dart';

class DriverHeaderWidget extends StatelessWidget {
  final String name;
  final String email;
  final int completedJobs;
  final double totalEarn;
  final VoidCallback onNotification;
  final DriverHomeController controller;

  const DriverHeaderWidget({
    super.key,
    required this.name,
    required this.email,
    required this.completedJobs,
    required this.totalEarn,
    required this.onNotification,
    required this.controller,
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

          // ── Profile row: Avatar + Name + Rating + Notification ────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ── Avatar ────────────────────────────────────────────────
              GestureDetector(
                onTap: () {
                  Get.toNamed(RoutePath.profile);
                },
                child: CircleAvatar(
                  radius: Dimensions.w(28),
                  backgroundImage: AssetImage(AppImages.profileImage),
                ),
              ),
              SizedBox(width: Dimensions.w(12)),

              // ── Name + Rating (Column) ────────────────────────────────
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Name
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: Dimensions.f(16),
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: Dimensions.h(4)),
                    // Star Rating
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ...List.generate(
                          4,
                              (index) => Icon(
                            Icons.star_rounded,
                            size: Dimensions.w(20),
                            color: const Color(0xFFFFA500),
                          ),
                        ),
                        Icon(
                          Icons.star_rounded,
                          size: Dimensions.w(18),
                          color: Colors.white.withOpacity(0.4),
                        ),
                        SizedBox(width: Dimensions.w(4)),
                        Text(
                          '4.7',
                          style: TextStyle(
                            fontSize: Dimensions.f(16),
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
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

          // ── Activity Summary with Dropdown ────────────────────────────
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.w(16),
              vertical: Dimensions.h(14),
            ),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(Dimensions.r(12)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Title + Dropdown ──────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Activity Summary',
                      style: TextStyle(
                        fontSize: Dimensions.f(14),
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    Obx(() => PopupMenuButton<String>(
                      onSelected: (value) =>
                          controller.setActivityPeriod(value),
                      itemBuilder: (BuildContext context) =>
                          controller.periodOptions
                              .map((String choice) =>
                              PopupMenuItem<String>(
                                value: choice,
                                child: Text(choice),
                              ))
                              .toList(),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.w(10),
                          vertical: Dimensions.h(6),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius:
                          BorderRadius.circular(Dimensions.r(6)),
                          border: Border.all(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              controller.activityPeriod.value,
                              style: TextStyle(
                                fontSize: Dimensions.f(12),
                                fontWeight: FontWeight.w600,
                                color: AppColors.greyColor,
                              ),
                            ),
                            SizedBox(width: Dimensions.w(4)),
                            Icon(
                              Icons.arrow_drop_down,
                              size: Dimensions.w(16),
                              color: AppColors.greyColor,
                            ),
                          ],
                        ),
                      ),
                    )),
                  ],
                ),

                SizedBox(height: Dimensions.h(12)),

                // ── Stats Row ─────────────────────────────────────────
                Row(
                  children: [
                    Expanded(
                      child: _StatItem(
                        label: AppStrings.completedJobs.tr,
                        value: completedJobs.toString(),
                      ),
                    ),
                    Container(
                      width: 1,
                      height: Dimensions.h(40),
                      color: Colors.black.withOpacity(0.1),
                    ),
                    Expanded(
                      child: _StatItem(
                        label: AppStrings.totalEarn.tr,
                        value: '${AppStrings.aed.tr} ${totalEarn.toInt()}',
                      ),
                    ),
                  ],
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