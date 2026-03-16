import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/utils/assets_image/app_images.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import '../../../../utils/app_colors/app_colors.dart';

class OverviewPhotosSection extends StatelessWidget {
  const OverviewPhotosSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.toNamed(RoutePath.captureImage);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.forgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                Text(AppStrings.photos.tr, style: TextStyle(fontWeight: FontWeight.bold)),
                Icon(Icons.arrow_forward_ios, size: 18),
              ],
            ),
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                3,
                    (index) => Container(
                  width: 90,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.greyColor.withOpacity(0.2),
                  ),
                  child: Image.asset(AppImages.homeImage1,fit: BoxFit.cover,),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}