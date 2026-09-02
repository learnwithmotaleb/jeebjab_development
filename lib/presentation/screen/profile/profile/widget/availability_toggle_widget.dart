import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';

/// Online/Offline availability card shown to approved drivers on the
/// Profile screen. Wired to `PATCH /driver/availability`, which simply
/// flips the current status on every call.
class AvailabilityToggleWidget extends StatelessWidget {
  final bool isAvailable;
  final bool isLoading;
  final VoidCallback onChanged;

  const AvailabilityToggleWidget({
    super.key,
    required this.isAvailable,
    required this.isLoading,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = isAvailable ? Colors.green.shade600 : AppColors.greyColor;

    return Container(
      padding: Dimensions.pSym(h: 16, v: 14),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(Dimensions.r(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: Dimensions.w(10),
            height: Dimensions.w(10),
            decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
          ),
          Dimensions.gapW(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${AppStrings.availability.tr}: ${(isAvailable ? AppStrings.online : AppStrings.offline).tr}",
                  style: TextStyle(
                    fontSize: Dimensions.fs(15, tablet: 17, desktop: 19),
                    fontWeight: FontWeight.w600,
                    color: AppColors.labelColor,
                  ),
                ),
                SizedBox(height: Dimensions.h(2)),
                Text(
                  (isAvailable
                          ? AppStrings.availabilityOnlineSubtitle
                          : AppStrings.availabilityOfflineSubtitle)
                      .tr,
                  style: TextStyle(
                    fontSize: Dimensions.fs(12, tablet: 13, desktop: 14),
                    color: AppColors.greyColor,
                  ),
                ),
              ],
            ),
          ),
          if (isLoading)
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.primaryColor,
              ),
            )
          else
            Switch(
              value: isAvailable,
              activeThumbColor: AppColors.primaryColor,
              onChanged: (_) => onChanged(),
            ),
        ],
      ),
    );
  }
}
