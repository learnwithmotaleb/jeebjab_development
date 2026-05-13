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
              activeColor: const Color(0xFF1ABC9C), // Primary teal color
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              onChanged: (value) {
                controller.acknowledgePickup.value = value ?? false;
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  AppStrings.iHereByAcknowledgeThatIsBeingPickedUp.tr,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
              ),
            ),
          ],
        )),

        /// Sub Points
        Padding(
          padding: const EdgeInsets.only(left: 48, top: 0),
          child: Column(
            children: [
              _bulletItem(AppStrings.correspondsWithAd.tr),
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
          width: 8,
          height: 8,
          margin: const EdgeInsets.only(top: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF9CA3AF),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF6B7280),
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}