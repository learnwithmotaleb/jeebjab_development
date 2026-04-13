import 'package:flutter/material.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import '../controller/profile_controller.dart';

class ProfileMenuItemWidget extends StatelessWidget {
  final ProfileMenuItem item;
  final bool showDivider;

  const ProfileMenuItemWidget({
    super.key,
    required this.item,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: item.onTap,
          borderRadius: BorderRadius.circular(Dimensions.r(8)),
          child: Padding(
            padding: Dimensions.pSym(h: 16, v: 14), // 🔥 cleaner
            child: Row(
              children: [
                // 🔹 Icon
                Icon(
                  item.icon,
                  size: Dimensions.icon(18, tablet: 20, desktop: 24),
                  color: item.iconColor ?? AppColors.primaryColor,
                ),

                Dimensions.gapW(14),

                // 🔹 Label
                Expanded(
                  child: Text(
                    item.title,
                    style: _textStyle,
                  ),
                ),

                // 🔹 Arrow
                if (item.iconColor == null)
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: Dimensions.icon(14),
                    color: const Color(0xFFCCCCCC),
                  ),
              ],
            ),
          ),
        ),

        // 🔹 Divider
        if (showDivider)
          Divider(
            height: 1,
            thickness: 1,
            color: const Color(0xFFF0F0F0),
            indent: Dimensions.w(52),
          ),
      ],
    );
  }

  // 🔥 Extracted TextStyle (Cleaner + Reusable)
  TextStyle get _textStyle => TextStyle(
    fontSize: Dimensions.fs(16, tablet: 18, desktop: 20), // 🔥 fixed scale
    fontWeight: FontWeight.w500,
    color: item.iconColor ?? AppColors.labelColor,
  );
}