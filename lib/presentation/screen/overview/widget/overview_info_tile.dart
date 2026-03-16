import 'package:flutter/material.dart';
import 'package:jeebjab/utils/app_text_style/app_text_style.dart';

import '../../../../utils/app_colors/app_colors.dart';

class OverviewInfoTile extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback? onPressed; // ✅ Add this

  const OverviewInfoTile({
    super.key,
    required this.title,
    required this.value,
    this.onPressed, // ✅ Optional
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed, // ✅ Trigger callback
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(color:AppColors.blackColor),
            ),
            Row(
              children: [
                Text(value,style: AppTextStyles.hint.copyWith(fontSize: 14),),
                const SizedBox(width: 5),
                const Icon(Icons.arrow_forward_ios, size: 14),
              ],
            )
          ],
        ),
      ),
    );
  }
}