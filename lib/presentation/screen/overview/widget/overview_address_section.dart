import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/routes/route_path.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/static_strings/static_strings.dart';
import '../controller/overview_controller.dart';
import 'overview_info_tile.dart';
class OverviewAddressSection extends StatelessWidget {
  const OverviewAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OverviewController>();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.forgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Use AppStrings with .tr for localization
          Text(
            AppStrings.pickupAddressTitle.tr,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),

          Obx(() => OverviewInfoTile(
              title: AppStrings.address.tr,
              onPressed: () {
                Get.toNamed(RoutePath.pickupAddress);
              },
              value: controller.pickupAddress.value)),

          Obx(() => OverviewInfoTile(
              title: AppStrings.placement.tr,
              onPressed: () {
                Get.toNamed(RoutePath.placementPickup);
              },
              value: controller.pickupPlacement.value)),

          Obx(() => OverviewInfoTile(
              title: AppStrings.floorAndDoorCode.tr,
              onPressed: () {
                Get.toNamed(RoutePath.pickupFloor);
              },
              value: controller.pickupFloor.value)),
        ],
      ),
    );
  }
}