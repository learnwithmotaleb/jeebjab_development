import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';

import '../controller/driver_home_controller.dart';

class CurrentTaskCard extends StatelessWidget {
  final DriverTask task;
  final VoidCallback onPickUp;
  final VoidCallback onOpenMap;

  const CurrentTaskCard({
    super.key,
    required this.task,
    required this.onPickUp,
    required this.onOpenMap,
  });

  IconData get _icon {
    switch (task.categoryIcon) {
      case 'recycle':
        return Icons.recycling_outlined;
      default:
        return Icons.shopping_cart_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Dimensions.h(12)),
      padding: EdgeInsets.all(Dimensions.w(14)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.r(12)),
        border: Border.all(color: const Color(0xFFEEEEEE)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Title + Price ──────────────────────────────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(_icon, size: Dimensions.w(20), color: AppColors.labelColor),
              SizedBox(width: Dimensions.w(8)),
              Expanded(
                child: Text(
                  task.title,
                  style: TextStyle(
                    fontSize: Dimensions.f(15),
                    fontWeight: FontWeight.w800,
                    color: AppColors.labelColor,
                  ),
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${AppStrings.aed.tr} ',
                      style: TextStyle(
                        fontSize: Dimensions.f(10),
                        fontWeight: FontWeight.w600,
                        color: AppColors.labelColor,
                      ),
                    ),
                    TextSpan(
                      text: task.price.toInt().toString(),
                      style: TextStyle(
                        fontSize: Dimensions.f(22),
                        fontWeight: FontWeight.w900,
                        color: AppColors.labelColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: Dimensions.h(6)),

          // ── Person ────────────────────────────────────────────────────
          Row(
            children: [
              Icon(Icons.person_outline_rounded,
                  size: Dimensions.w(14), color: AppColors.greyColor),
              SizedBox(width: Dimensions.w(5)),
              Text(
                task.person,
                style: TextStyle(
                    fontSize: Dimensions.f(12), color: AppColors.greyColor),
              ),
            ],
          ),

          SizedBox(height: Dimensions.h(3)),

          // ── Address ───────────────────────────────────────────────────
          Row(
            children: [
              Icon(Icons.location_on_outlined,
                  size: Dimensions.w(14), color: AppColors.greyColor),
              SizedBox(width: Dimensions.w(5)),
              Expanded(
                child: Text(
                  task.address,
                  style: TextStyle(
                      fontSize: Dimensions.f(12), color: AppColors.greyColor),
                ),
              ),
            ],
          ),

          SizedBox(height: Dimensions.h(12)),

          // ── Action buttons (reactive) ─────────────────────────────────
          Obx(() {
            final isPickUp = task.status.value == TaskStatus.pickUp;
            return Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: isPickUp ? onPickUp : null,
                    child: Container(
                      height: Dimensions.h(40),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(Dimensions.r(8)),
                        border: Border.all(color: AppColors.primaryColor),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        isPickUp
                            ? AppStrings.pickUp.tr
                            : AppStrings.delivered.tr,
                        style: TextStyle(
                          fontSize: Dimensions.f(13),
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: Dimensions.w(10)),
                Expanded(
                  child: GestureDetector(
                    onTap: onOpenMap,
                    child: Container(
                      height: Dimensions.h(40),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(Dimensions.r(8)),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        AppStrings.openMap.tr,
                        style: TextStyle(
                          fontSize: Dimensions.f(13),
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}