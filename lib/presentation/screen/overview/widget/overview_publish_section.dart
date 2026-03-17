import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/widget/app_button.dart';

import '../../../../helper/tost_message/show_snackbar.dart';
import '../../../../utils/static_strings/static_strings.dart';
import '../../../../widget/confirmataion_alert.dart';
import '../../../../widget/custom_alert.dart';

class OverviewPublishSection extends StatelessWidget {
  const OverviewPublishSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      color: AppColors.forgroundColor,
      child: Row(
        children: [
          Expanded(
            child: AppButton(
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
              textColor: AppColors.blackColor,///
              borderSideColor: AppColors.whiteColor,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: AppButton(
              onPressed: () {
                // AppAlerts.success(message: AppStrings.success.tr);
                AppAlerts.confirm(title: AppStrings.appName.tr, message: AppStrings.payments.tr, onConfirm: () {

                  Get.toNamed(RoutePath.login);


                });

              },
              label: AppStrings.publish.tr,
            ),
          ),
        ],
      ),
    );
  }
}