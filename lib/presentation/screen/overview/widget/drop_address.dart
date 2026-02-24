import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/routes/route_path.dart';
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
        color: Colors.grey.shade100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text("Drop-Off Address",
              style: TextStyle(fontWeight: FontWeight.bold)),

          Obx(() => OverviewInfoTile(
              title: "Address",
              onPressed: (){
                Get.toNamed(RoutePath.setDropOffAddress);
              },

              value: controller.dropAddress.value)),

          Obx(() => OverviewInfoTile(
              title: "Placement",
              onPressed: (){
                Get.toNamed(RoutePath.placementDropOff);
              },
              value: controller.dropPlacement.value)),

          Obx(() => OverviewInfoTile(
              title: "Floor & Door Code",
              onPressed: (){
                Get.toNamed(RoutePath.dropOffFloor);
              },
              value: controller.dropFloor.value)),
        ],
      ),
    );
  }
}