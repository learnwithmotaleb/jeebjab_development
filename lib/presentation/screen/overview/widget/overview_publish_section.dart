import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/widget/app_button.dart';

import '../../../../widget/confirmataion_alert.dart';
import '../../../../utils/static_strings/static_strings.dart';
import '../../../../widget/custom_alert.dart';
import '../controller/overview_controller.dart'; // Import the controller

class OverviewPublishSection extends StatelessWidget {
  const OverviewPublishSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isTablet = Dimensions.isTablet;
    final OverviewController controller = Get.find();

    return Container(
      padding: EdgeInsets.all(isTablet ? 40 : 16),
      decoration: BoxDecoration(
        color: AppColors.forgroundColor,
        boxShadow: isTablet
            ? [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          )
        ]
            : null,
      ),
      child: Row(
        children: [
          /// ❌ Cancel Button
          Expanded(
            child: AppButton(
              height: isTablet ? 100 : 65,
              onPressed: () {
                CustomAlertDialog.show(
                  context: context,
                  title: AppStrings.doYouWantToCancel.tr,
                  body: AppStrings.cancelBody.tr,
                  onYes: () => Get.back(),
                  onNo: () => Get.back(),
                );
              },
              backgroundColor: AppColors.whiteColor,
              label: AppStrings.cancel.tr,
              textColor: AppColors.blackColor,
              borderSideColor: AppColors.whiteColor,
            ),
          ),

          SizedBox(width: isTablet ? 24 : 10),

          /// ✅ Publish Button
          Expanded(
            child: Obx(() => AppButton(
              height: isTablet ? 100 : 65,

              /// 🔥 Main Fix Here
              onPressed: controller.canPublish
                  ? () {
                AppAlerts.confirm(
                  title: AppStrings.payments.tr,
                  message: AppStrings.yourPostHasBeenSuccessfullyPublished.tr,
                  onConfirm: () {
                    Get.offAllNamed(
                      RoutePath.bottomNav,
                      arguments: 3,
                    );
                  },
                );
              }
                  : null,

              label: AppStrings.publish.tr,

              /// 🎨 Optional UX Improvement
              backgroundColor: controller.canPublish
                  ? AppColors.primaryColor
                  : AppColors.greyColor.withOpacity(0.5),
            )),
          ),
        ],
      ),
    );
  }
}