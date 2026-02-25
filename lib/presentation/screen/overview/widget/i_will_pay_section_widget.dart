import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../controller/overview_controller.dart';
import 'overview_info_tile.dart';

class OverviewIWillPayBottomSection extends StatelessWidget {
  const OverviewIWillPayBottomSection({super.key});

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
        children: [

          Obx(() => OverviewInfoTile(
              title: "I Will Pay",
              onPressed: (){
                Get.toNamed(RoutePath.iWillPay);
              },
              value: controller.price.value)),
        ],
      ),
    );
  }
}