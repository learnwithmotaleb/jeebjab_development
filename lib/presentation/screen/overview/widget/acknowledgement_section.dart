import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';

import '../../../../utils/app_colors/app_colors.dart';
import '../controller/overview_controller.dart';

class AcknowledgementSection extends StatelessWidget {
  const AcknowledgementSection({super.key});

  @override
  Widget build(BuildContext context) {
    final OverviewController controller = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => Row(
          children: [
            Checkbox(
              value: controller.acknowledgePickup.value,
              onChanged: (value) {
                controller.acknowledgePickup.value = value ?? false;
              },
            ),
             Expanded(
              child: Text(AppStrings.iHereByAcknowledgeThatIsBeingPickedUp.tr),
            ),
          ],
        )),
        Padding(
          padding: const EdgeInsets.only(left: 32.0),
          child: Column(
            children: [
              Row(
                children: [
                 Container(
                   width: 16,
                   height: 16,

                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(5),
                     color: AppColors.greyColor.withOpacity(0.5),
                   ),
                 ),
                  SizedBox(width: 10,),
                   Expanded(
                    child: Text(AppStrings.correspondsWithAd.tr),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 16,
                    height: 16,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.greyColor.withOpacity(0.5),
                    ),
                  ),
                  SizedBox(width: 10,),
                   Expanded(
                    child: Text(AppStrings.doesNotContainToxicOrHarmful.tr),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 16,
                    height: 16,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.greyColor.withOpacity(0.5),
                    ),
                  ),
                  SizedBox(width: 10,),
                   Expanded(
                    child: Text(AppStrings.willBeAvailableAtTheTimeForPickUp.tr),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
