import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/utils/assets_image/app_images.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import '../../../../utils/app_colors/app_colors.dart';

class OverviewPhotosSection extends StatelessWidget {
  const OverviewPhotosSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isTablet = Dimensions.isTablet;

    return GestureDetector(
      onTap: () {
        Get.toNamed(RoutePath.captureImage);
      },
      child: Container(
        padding: EdgeInsets.all(isTablet ? 24 : 12),
        decoration: BoxDecoration(
          color: AppColors.forgroundColor,
          borderRadius: BorderRadius.circular(isTablet ? 20 : 12),
          boxShadow: isTablet ? [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ] : null,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.photos.tr, 
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: isTablet ? 18 : 14,
                  )
                ),
                Icon(Icons.arrow_forward_ios, size: isTablet ? 22 : 18),
              ],
            ),
            SizedBox(height: isTablet ? 20 : 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                3,
                (index) => Container(
                  width: isTablet ? 180 : 90,
                  height: isTablet ? 120 : 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(isTablet ? 12 : 8),
                    color: AppColors.greyColor.withOpacity(0.2),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(isTablet ? 12 : 8),
                    child: Image.asset(AppImages.homeImage1, fit: BoxFit.cover,)
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}