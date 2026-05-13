import 'package:flutter/material.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/utils/app_text_style/app_text_style.dart';

import '../../../../utils/app_colors/app_colors.dart';

class OverviewInfoTile extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback? onPressed;

  const OverviewInfoTile({
    super.key,
    required this.title,
    required this.value,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final bool isTablet = Dimensions.isTablet;

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(isTablet ? 12 : 8),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: isTablet ? 18 : 10,
            horizontal: isTablet ? 12 : 4
        ),
        child: Row(
          children: [
            /// ✅ Label (Left)
            Expanded(
              flex: 4,
              child: Text(
                title,
                style: TextStyle(
                    color: const Color(0xFF1A1A2E), // Darker title color
                    fontSize: isTablet ? 17 : 14,
                    fontWeight: isTablet ? FontWeight.w600 : FontWeight.w500
                ),
              ),
            ),
            const SizedBox(width: 8),

            /// ✅ Value (Right)
            Expanded(
              flex: 6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: Text(
                      value,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: isTablet ? 16 : 13,
                        color: onPressed == null 
                            ? const Color(0xFF1A1A2E) // Dark bold for service type
                            : const Color(0xFF6B7280), 
                        fontWeight: onPressed == null ? FontWeight.w800 : FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (onPressed != null) ...[
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14,
                      color: Color(0xFF1A1A2E),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}