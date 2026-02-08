import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_colors/app_colors.dart';

class ShowAppSnackBar {
  ShowAppSnackBar._();

  /// ✅ Success snackbar
  static void success(String message, {String? title}) {
    _show(
      message,
      title: title,
      backgroundColor: AppColors.whiteColor,
      textColor: AppColors.blackColor,
    );
  }

  /// ❌ Failure snackbar
  static void fail(String message, {String? title}) {
    _show(
      message,
      title: title,
      backgroundColor: AppColors.emergencyColor,
    );
  }

  /// ℹ️ Info / Warning snackbar
  static void info(String message, {String? title}) {
    _show(
      message,
      title: title,
      textColor: AppColors.whiteColor,
      backgroundColor: AppColors.loginLogoRadiusColor,
    );
  }

  /// 🔒 Generic snackbar (private)
  static void _show(
      String message, {
        String? title,
        Color backgroundColor = AppColors.whiteColor,
        Color textColor = AppColors.blackColor,
        Duration duration = const Duration(seconds: 3),
      }) {
    Get.snackbar(
      title ?? '', // ✅ title optional
      message,     // ✅ message mandatory
      snackPosition: SnackPosition.TOP,
      backgroundColor: backgroundColor,
      colorText: textColor,
      duration: duration,
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      animationDuration: const Duration(milliseconds: 300),
    );
  }
}
