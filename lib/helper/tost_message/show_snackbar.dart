import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_colors/app_colors.dart';

class AppSnackBar {
  AppSnackBar._();

  /// ✅ Success snackbar
  static void success(String message, {String? title}) {
    _show(
      message,
      title: title,
      backgroundColor: AppColors.primaryColor,
      textColor: AppColors.whiteColor,
    );
  }

  /// ❌ Failure snackbar
  static void fail(String message, {String? title}) {
    _show(
      message,
      title: title,
      backgroundColor: AppColors.emergencyColor,
      textColor: AppColors.whiteColor,
    );
  }

  // ❌ Error snackbar (alias for fail)
  static void error(String message, {String? title}) {
    fail(message, title: title);
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
  //
  // A snackbar shown in the same tick as a Get.back() / Get.offAllNamed() /
  // Get.close() call races that navigation's own transition on GetX's
  // overlay stack — whichever "wins" isn't reliable, and the usual symptom
  // is the snackbar silently never appearing. Rather than hand-ordering
  // every call site across the app (there are ~20+), the call is deferred
  // slightly here so any adjacent navigation settles first regardless of
  // which the calling code does first. Imperceptible when nothing's
  // navigating — the message just shows ~150ms later.
  static void _show(
      String message, {
        String? title,
        Color backgroundColor = AppColors.whiteColor,
        Color textColor = AppColors.blackColor,
        Duration duration = const Duration(seconds: 3),
      }) {
    Future.delayed(const Duration(milliseconds: 150), () {
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
        isDismissible: true,
        forwardAnimationCurve: Curves.easeOutBack,
      );
    });
  }
}
