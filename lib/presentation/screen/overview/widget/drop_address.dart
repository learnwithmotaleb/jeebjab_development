import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../../core/routes/route_path.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/static_strings/static_strings.dart';
import '../controller/overview_controller.dart';
import 'overview_info_tile.dart';

class DropAddressSection extends StatelessWidget {
  const DropAddressSection({super.key});

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
          // Use localized string
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 4),
            child: Text(
              AppStrings.dropOffAddress.tr,
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
                Get.toNamed(RoutePath.setDropOffAddress, arguments: {'isEdit': true})?.then((result) {
                  controller.loadData();
                  if (result == true) {
                    controller.publishPost();
                  }
                });
              },
              value: controller.dropAddress.value)),

          Obx(() => OverviewInfoTile(
              title: AppStrings.placement.tr,
              onPressed: () {
                Get.toNamed(RoutePath.placementDropOff, arguments: {'isEdit': true})?.then((result) {
                  controller.loadData();
                  if (result == true) {
                    controller.publishPost();
                  }
                });
              },
              value: controller.dropPlacement.value)),

          Obx(() => OverviewInfoTile(
              title: AppStrings.floorAndDoorCode.tr,
              onPressed: () {
                Get.toNamed(RoutePath.dropOffFloor, arguments: {'isEdit': true})?.then((result) {
                  controller.loadData();
                  if (result == true) {
                    controller.publishPost();
                  }
                });
              },
              value: controller.dropFloor.value)),
        ],
      ),
    );
  }
}