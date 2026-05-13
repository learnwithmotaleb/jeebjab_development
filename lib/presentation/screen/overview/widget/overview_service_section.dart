import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/routes/route_path.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/static_strings/static_strings.dart';
import '../controller/overview_controller.dart';
import 'overview_info_tile.dart';

class OverviewServiceSection extends StatelessWidget {
  const OverviewServiceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OverviewController>();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: _boxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => OverviewInfoTile(
              title: AppStrings.typeOfService.tr,
              onPressed: null, // No chevron, bold value
              value: controller.serviceType.value.tr,
            ),
          ),

          Obx(
            () => OverviewInfoTile(
              title: AppStrings.titleOfService.tr,
              onPressed: () {
                Get.toNamed(
                  RoutePath.captureInfo,
                  arguments: {'isEdit': true},
                )?.then((result) {
                  controller.loadData();
                  if (result == true) {
                    controller.publishPost();
                  }
                });
              },
              value: controller.serviceTitle.value,
            ),
          ),

          Obx(
            () => OverviewInfoTile(
              title: AppStrings.descriptionOfService.tr,
              onPressed: () {
                Get.toNamed(
                  RoutePath.captureInfo,
                  arguments: {'isEdit': true},
                )?.then((result) {
                  controller.loadData();
                  if (result == true) {
                    controller.publishPost();
                  }
                });
              },
              value: controller.description.value,
            ),
          ),

          Obx(
            () => OverviewInfoTile(
              title: AppStrings.wasteCategories.tr,
              onPressed: () {
                Get.toNamed(
                  RoutePath.westType,
                  arguments: {'isEdit': true},
                )?.then((result) {
                  controller.loadData();
                  if (result == true) {
                    controller.publishPost();
                  }
                });
              },
              value: controller.wasteCount.value,
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: AppColors.forgroundColor,
    );
  }
}
