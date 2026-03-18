
import 'package:flutter/material.dart';
import '../app_colors/app_colors.dart';


class AppTextStyles {
  static const TextStyle title = TextStyle(
    fontFamily: "urbanist",
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.blackColor,
  );

  static  TextStyle label = TextStyle(
    fontFamily: "poppins",
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.labelColor,
  );

  static  TextStyle body = TextStyle(
    fontFamily: "urbanist",
    fontWeight: FontWeight.w400,

    fontSize: 14,
    color: AppColors.blackColor.withOpacity(0.6),
  );

  static  TextStyle hint = TextStyle(
    fontFamily: "poppins",
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.hintTextColor,
  );


  static const TextStyle button = TextStyle(
    fontFamily: "poppins",
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.whiteColor,
  );
}
