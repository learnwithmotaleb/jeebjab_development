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
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 4),
            child: Text(
              AppStrings.pickupAddressTitle.tr,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: Color(0xFF1A1A2E),
              ),
            ),
          ),

          Obx(() => OverviewInfoTile(
              title: AppStrings.address.tr,
              onPressed: () {
                Get.toNamed(RoutePath.pickupAddress, arguments: {'isEdit': true})?.then((result) {
                  controller.loadData();
                  if (result == true) {
                    controller.publishPost();
                  }
                });
              },
              value: controller.pickupAddress.value)),

          Obx(() => OverviewInfoTile(
              title: AppStrings.placement.tr,
              onPressed: () {
                Get.toNamed(RoutePath.placementPickup, arguments: {'isEdit': true})?.then((result) {
                  controller.loadData();
                  if (result == true) {
                    controller.publishPost();
                  }
                });
              },
              value: controller.pickupPlacement.value)),

          Obx(() => OverviewInfoTile(
              title: AppStrings.floorAndDoorCode.tr,
              onPressed: () {
                Get.toNamed(RoutePath.pickupFloor, arguments: {'isEdit': true})?.then((result) {
                  controller.loadData();
                  if (result == true) {
                    controller.publishPost();
                  }
                });
              },
              value: controller.pickupFloor.value)),
        ],
      ),
    );
  }
}