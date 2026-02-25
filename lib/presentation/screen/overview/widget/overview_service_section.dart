import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/routes/route_path.dart';
import '../../../../utils/app_colors/app_colors.dart';
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
        children: [
          Obx(() => OverviewInfoTile(
              title: "Type Of Service",
              onPressed: (){
                Get.toNamed(RoutePath.captureInfo);
              },
              value: controller.serviceType.value)),

          Obx(() => OverviewInfoTile(
              title: "Title",
              onPressed: (){
                Get.toNamed(RoutePath.captureInfo);
              },
              value: controller.serviceTitle.value)),

          Obx(() => OverviewInfoTile(
              title: "Description",
              onPressed: (){
                Get.toNamed(RoutePath.captureInfo);
              },
              value: controller.description.value)),

          Obx(() => OverviewInfoTile(
              title: "Size Of Product",
              onPressed: (){
                Get.toNamed(RoutePath.captureInfo);
              },
              value: controller.sizeOfProduct.value)),
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