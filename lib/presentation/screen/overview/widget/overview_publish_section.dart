import 'package:flutter/material.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/widget/app_button.dart';

class OverviewPublishSection extends StatelessWidget {
  const OverviewPublishSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(

            child:AppButton(
              onPressed: () {},
              backgroundColor: AppColors.whiteColor,
              label:"Cancel",
              textColor: AppColors.blackColor ,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child:AppButton(
              onPressed: () {},
              label:"Publish",
            ),
          ),
        ],
      ),
    );
  }
}