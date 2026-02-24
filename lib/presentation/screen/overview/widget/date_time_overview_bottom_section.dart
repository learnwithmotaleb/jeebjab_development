import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/overview_controller.dart';
import 'overview_info_tile.dart';

class OverviewDatetimeBottomSection extends StatelessWidget {
  const OverviewDatetimeBottomSection({super.key});

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
        children: [
          Obx(() => OverviewInfoTile(
              title: "Date & Time Slot",
              value: controller.dateTime.value)),
        ],
      ),
    );
  }
}