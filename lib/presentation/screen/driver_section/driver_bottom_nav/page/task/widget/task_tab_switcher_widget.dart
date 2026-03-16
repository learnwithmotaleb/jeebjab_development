import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';

class TaskTabSwitcher extends StatelessWidget {
  final bool isActive;
  final VoidCallback onActiveTab;
  final VoidCallback onCompletedTab;

  const TaskTabSwitcher({
    super.key,
    required this.isActive,
    required this.onActiveTab,
    required this.onCompletedTab,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.h(44),
      padding: EdgeInsets.all(Dimensions.w(4)),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(Dimensions.r(30)),
      ),
      child: Row(
        children: [
          // ── Active Post tab ─────────────────────────────────────────
          Expanded(
            child: GestureDetector(
              onTap: onActiveTab,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: isActive ? AppColors.primaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(Dimensions.r(26)),
                ),
                alignment: Alignment.center,
                child: Text(
                 AppStrings.activePost.tr,
                  style: TextStyle(
                    fontSize: Dimensions.f(13),
                    fontWeight: FontWeight.w700,
                    color: isActive ? Colors.white : AppColors.blackColor,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 5,),

          // ── Completed Post tab ──────────────────────────────────────
          Expanded(
            child: GestureDetector(
              onTap: onCompletedTab,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: !isActive ? AppColors.primaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(Dimensions.r(26)),
                ),
                alignment: Alignment.center,
                child: Text(
                  AppStrings.completedPost.tr,
                  style: TextStyle(
                    fontSize: Dimensions.f(13),
                    fontWeight: FontWeight.w700,
                    color: !isActive ? Colors.white : AppColors.blackColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}