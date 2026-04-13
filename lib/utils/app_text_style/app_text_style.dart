import 'package:flutter/material.dart';
import '../../core/responsive_layout/dimensions.dart';
import '../app_colors/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const String urbanist = "urbanist";
  static const String poppins = "poppins";

  // 🔹 TITLE
  static TextStyle title = TextStyle(
    fontFamily: urbanist,
    fontSize: Dimensions.fs(16, tablet: 18, desktop: 20),
    fontWeight: FontWeight.w700,
    color: AppColors.blackColor,
  );

  // 🔹 LABEL
  static TextStyle label = TextStyle(
    fontFamily: poppins,
    fontSize: Dimensions.fs(12, tablet: 14, desktop: 16),
    fontWeight: FontWeight.w400,
    color: AppColors.labelColor,
  );

  // 🔹 BODY
  static TextStyle body = TextStyle(
    fontFamily: urbanist,
    fontSize: Dimensions.fs(14, tablet: 16, desktop: 18),
    fontWeight: FontWeight.w400,
    color: AppColors.blackColor.withOpacity(0.6),
  );

  // 🔹 HINT
  static TextStyle hint = TextStyle(
    fontFamily: poppins,
    fontSize: Dimensions.fs(14, tablet: 15, desktop: 16),
    fontWeight: FontWeight.w400,
    color: AppColors.hintTextColor,
  );

  // 🔹 BUTTON
  static TextStyle button = TextStyle(
    fontFamily: poppins,
    fontSize: Dimensions.fs(14, tablet: 16, desktop: 18),
    fontWeight: FontWeight.w600,
    color: AppColors.whiteColor,
  );
}