import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors/app_colors.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed; // make nullable
  final Color backgroundColor;
  final Color textColor;
  final double height;
  final double width;
  final Color? borderSideColor;
  final double borderRadius;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final bool isLoading;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor = AppColors.primaryColor,
    this.textColor = AppColors.whiteColor,
    this.height = 50,
    this.width = double.infinity,
    this.borderRadius = 10,
    this.leadingIcon,
    this.trailingIcon,
    this.borderSideColor = AppColors.primaryColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: (onPressed == null || isLoading)
              ? AppColors
                    .greyColor // disabled color
              : backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: borderSideColor != null
                ? BorderSide(color: borderSideColor!, width: 1.0)
                : BorderSide.none,
          ),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? SpinKitFadingFour(color: textColor, size: 24)
            : Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (leadingIcon != null) ...[
                    leadingIcon!,
                    const SizedBox(width: 8),
                  ],
                  Flexible(
                    child: Text(
                      label,
                      style: TextStyle(color: textColor, fontSize: 20),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (trailingIcon != null) ...[
                    const SizedBox(width: 8),
                    trailingIcon!,
                  ],
                ],
              ),
      ),
    );
  }
}
