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
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.w(16),
              vertical: Dimensions.h(14),
            ),
            child: Row(
              children: [
                // ── Icon ────────────────────────────────────────────────
                Icon(
                  item.icon,
                  size: Dimensions.w(22),
                  color: item.iconColor ?? AppColors.primaryColor,
                ),

                SizedBox(width: Dimensions.w(14)),

                // ── Label ────────────────────────────────────────────────
                Expanded(
                  child: Text(
                    item.title,
                    style: TextStyle(
                      fontSize: Dimensions.f(14),
                      fontWeight: FontWeight.w500,
                      color: item.iconColor ?? AppColors.labelColor,
                    ),
                  ),
                ),

                // ── Arrow ────────────────────────────────────────────────
                if (item.iconColor == null)
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: Dimensions.w(14),
                    color: const Color(0xFFCCCCCC),
                  ),
              ],
            ),
          ),
        ),

        // ── Divider (hidden for last item / logout) ───────────────────
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
}