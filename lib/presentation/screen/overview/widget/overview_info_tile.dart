import 'package:flutter/material.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/utils/app_text_style/app_text_style.dart';

import '../../../../utils/app_colors/app_colors.dart';

class OverviewInfoTile extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback? onPressed;

  const OverviewInfoTile({
    super.key,
    required this.title,
    required this.value,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final bool isTablet = Dimensions.isTablet;

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(isTablet ? 12 : 8),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: isTablet ? 18 : 10,
            horizontal: isTablet ? 12 : 0
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: AppColors.blackColor,
                  fontSize: isTablet ? 17 : 14,
                  fontWeight: isTablet ? FontWeight.w600 : FontWeight.normal
              ),
            ),
            Row(
              children: [
                Text(
                  value,
                  style: isTablet
                      ? TextStyle(
                          fontSize: 16,
                          color: AppColors.hintColor,
                          fontWeight: FontWeight.w500
                        )
                      : AppTextStyles.hint.copyWith(fontSize: 14),
                ),
                SizedBox(width: isTablet ? 10 : 5),
                Icon(
                    Icons.arrow_forward_ios, 
                    size: isTablet ? 18 : 14,
                    color: AppColors.hintColor,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}