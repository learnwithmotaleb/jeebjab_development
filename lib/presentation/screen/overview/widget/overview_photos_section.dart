import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/utils/assets_image/app_images.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../controller/overview_controller.dart';

class OverviewPhotosSection extends StatelessWidget {
  const OverviewPhotosSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isTablet = Dimensions.isTablet;
    final OverviewController controller = Get.find<OverviewController>();

    return Container(
      padding: EdgeInsets.all(isTablet ? 24 : 12),
      decoration: BoxDecoration(
        color: AppColors.forgroundColor,
        borderRadius: BorderRadius.circular(isTablet ? 20 : 12),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RoutePath.captureImage, arguments: {'isEdit': true})?.then((result) {
                controller.loadData();
                if (result == true) {
                  controller.publishPost();
                }
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.photos.tr, 
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: isTablet ? 18 : 13,
                    color: const Color(0xFF1A1A2E),
                  )
                ),
                const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Color(0xFF1A1A2E)),
              ],
            ),
          ),
          SizedBox(height: isTablet ? 20 : 12),

          Obx(() {
            if (controller.capturedImages.isEmpty) {
              return Container(
                height: isTablet ? 150 : 80,
                alignment: Alignment.center,
                child: Text(
                  AppStrings.noImages.tr,
                  style: const TextStyle(color: AppColors.hintColor),
                ),
              );
            }
            return SizedBox(
              height: isTablet ? 150 : 80,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: controller.capturedImages.length,
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      controller.capturedImages[index],
                      width: isTablet ? 150 : 80,
                      height: isTablet ? 150 : 80,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}