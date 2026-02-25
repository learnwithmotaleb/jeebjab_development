import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

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
            const Expanded(
              child: Text("I hereby acknowledge that is being picked up"),
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
                  const Expanded(
                    child: Text("Corresponds with the pictures and description in the ad"),
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
                  const Expanded(
                    child: Text("Does not contain anything toxic or harmful"),
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
                  const Expanded(
                    child: Text("Will be available at the time for pick-up"),
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
