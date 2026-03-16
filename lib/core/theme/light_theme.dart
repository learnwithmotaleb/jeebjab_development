
import 'package:flutter/material.dart';
import '../../utils/app_colors/app_colors.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primaryColor,                 // Brand action
    onPrimary: AppColors.whiteColor,

    secondary: AppColors.loginLogoRadiusColor,       // Accent
    onSecondary: AppColors.whiteColor,

    tertiary: AppColors.progressColor,               // Success/progress
    onTertiary: AppColors.whiteColor,

    error: AppColors.emergencyColor,                 // Danger
    onError: AppColors.whiteColor,

    background: AppColors.secondaryColor,            // White backgrounds
    onBackground: AppColors.emergencyBlackColor,     // Dark text

    surface: AppColors.secondaryColor,               // Cards/surfaces
    onSurface: AppColors.emergencyBlackColor,

    surfaceVariant: AppColors.bottomNavigationColor, // Soft cyan surface
    outline: AppColors.greyColor,                    // Borders/lines
  ),

  scaffoldBackgroundColor: AppColors.secondaryColor,

  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.secondaryColor,
    foregroundColor: AppColors.emergencyBlackColor,
    centerTitle: true,
    elevation: 0,
    titleTextStyle: TextStyle(
      fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.blackColor,
    ),
    iconTheme: IconThemeData(color: AppColors.emergencyBlackColor),
    actionsIconTheme: IconThemeData(color: AppColors.emergencyBlackColor),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: AppColors.whiteColor,
      minimumSize: const Size(48, 48),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.emergencyBlackColor,
      side: BorderSide(color: AppColors.loginLogoRadiusColor.withOpacity(.5)),
      minimumSize: const Size(48, 48),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: AppColors.loginLogoRadiusColor),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.secondaryColor,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    hintStyle: TextStyle(color: AppColors.emergencyBlackColor.withOpacity(.6)),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: AppColors.bottomNavigationColor, width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: AppColors.bottomNavigationColor, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.2),
    ),
  ),

  cardTheme: CardThemeData(
    color: AppColors.secondaryColor,
    elevation: 1,
    margin: const EdgeInsets.all(8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),

  chipTheme: ChipThemeData(
    backgroundColor: AppColors.bottomNavigationColor,
    selectedColor: AppColors.loginLogoRadiusColor,
    secondarySelectedColor: AppColors.primaryColor,
    labelStyle: const TextStyle(color: AppColors.emergencyBlackColor),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    shape: StadiumBorder(side: BorderSide(color: AppColors.bottomNavigationColor)),
  ),

  dividerTheme: const DividerThemeData(
    color: Color(0xFFE0E0E0), thickness: 0.8, space: 24,
  ),

  snackBarTheme: const SnackBarThemeData(
    backgroundColor: AppColors.loginLogoRadiusColor,
    contentTextStyle: TextStyle(color: AppColors.whiteColor),
    behavior: SnackBarBehavior.floating,
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.bottomNavigationColor,
    selectedItemColor: AppColors.primaryColor,
    unselectedItemColor: AppColors.emergencyBlackColor.withOpacity(.6),
    selectedIconTheme: const IconThemeData(size: 28),
    type: BottomNavigationBarType.fixed,
    elevation: 1,
  ),

  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: AppColors.progressColor,
    linearTrackColor: AppColors.bottomNavigationColor,
    circularTrackColor: AppColors.bottomNavigationColor,
  ),
);
