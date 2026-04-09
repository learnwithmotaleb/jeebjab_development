import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/static_strings/static_strings.dart';
import '../controller/overview_controller.dart';

class AcknowledgementSection extends StatelessWidget {
  const AcknowledgementSection({super.key});

  @override
  Widget build(BuildContext context) {
    final OverviewController controller = Get.find();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Main Checkbox
        Obx(() => Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: controller.acknowledgePickup.value,
              onChanged: (value) {
                controller.acknowledgePickup.value = value ?? false;
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  AppStrings.iHereByAcknowledgeThatIsBeingPickedUp.tr,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
          ],
        )),

        /// Sub Points
        Padding(
          padding: const EdgeInsets.only(left: 40),
          child: Column(
            children: [
              _bulletItem(AppStrings.correspondsWithAd.tr),
              const SizedBox(height: 8),
              _bulletItem(AppStrings.doesNotContainToxicOrHarmful.tr),
              const SizedBox(height: 8),
              _bulletItem(AppStrings.willBeAvailableAtTheTimeForPickUp.tr),
            ],
          ),
        ),
      ],
    );
  }

  /// 🔹 Reusable Bullet Item
  Widget _bulletItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 14,
          height: 14,
          margin: const EdgeInsets.only(top: 4),
          decoration: BoxDecoration(
            color: AppColors.greyColor.withOpacity(0.4),
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 13),
          ),
        ),
      ],
    );
  }
}