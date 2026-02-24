import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/routes/route_path.dart';
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
        color: Colors.grey.shade100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Pickup - Address",
              style: TextStyle(fontWeight: FontWeight.bold)),

          Obx(() => OverviewInfoTile(
              title: "Address",
              onPressed: (){
                Get.toNamed(RoutePath.pickupAddress);
              },
              value: controller.pickupAddress.value)),

          Obx(() => OverviewInfoTile(
              title: "Placement",
              onPressed: (){
                Get.toNamed(RoutePath.placementPickup);
              },
              value: controller.pickupPlacement.value)),

          Obx(() => OverviewInfoTile(
              title: "Floor & Door Code",
              onPressed: (){
                Get.toNamed(RoutePath.pickupFloor);
              },
              value: controller.pickupFloor.value)),

        ],
      ),
    );
  }
}