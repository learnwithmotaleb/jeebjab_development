import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/widget/app_button.dart';

import '../../../../helper/tost_message/show_snackbar.dart';
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

            child:AppButton(
              onPressed: () {
                CustomAlertDialog.show(
                  context: context,
                  title: "Do you want to cancel",
                  body: "Are you sure you want to cancel? your new ad will be deleted.",
                  onYes:  () => Get.back(),
                  onNo: () => Get.back(),
                );
              },
              backgroundColor: AppColors.whiteColor,
              label:"Cancel",
              textColor: AppColors.blackColor ,
              borderSideColor: AppColors.whiteColor,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child:AppButton(
              onPressed: () {

                Get.toNamed(RoutePath.addCard);


              },
              label:"Publish",
            ),
          ),
        ],
      ),
    );
  }
}