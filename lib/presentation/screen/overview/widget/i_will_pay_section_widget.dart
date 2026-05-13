import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
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
              title:AppStrings.iWillPay.tr,
              onPressed: (){
                Get.toNamed(RoutePath.iWillPay, arguments: {'isEdit': true})?.then((result) {
                  controller.loadData();
                  if (result == true) {
                    controller.publishPost();
                  }
                });
              },
              value: controller.price.value)),
          const SizedBox(height: 12),
          Obx(() => OverviewInfoTile(
              title:AppStrings.paymentMethod.tr,
              onPressed: (){
                Get.toNamed(RoutePath.addCard, arguments: {'isEdit': true})?.then((result) {
                  controller.loadData();
                  if (result == true) {
                    controller.publishPost();
                  }
                });
              },
              value: controller.paymentCard.value)),
        ],
      ),
    );
  }
}