
import 'package:flutter/material.dart';
import '../../utils/app_colors/app_colors.dart';

// A genuine dark palette — this used to be a byte-for-byte copy of
// lightTheme (including `brightness: Brightness.light`), so ThemeMode.dark
// / ThemeMode.system never actually looked any different. Most screens
// still hardcode AppColors.whiteColor etc. directly rather than reading
// from Theme, so this won't repaint every screen — but it fixes anything
// that *does* read Theme/brightness (system UI chrome, default Material
// widgets like Switch/TextField/CircularProgressIndicator, dialogs).
final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.primaryColor,                 // Brand action
    onPrimary: AppColors.whiteColor,

    secondary: AppColors.loginLogoRadiusColor,       // Accent
    onSecondary: AppColors.whiteColor,

    tertiary: AppColors.progressColor,               // Success/progress
    onTertiary: AppColors.whiteColor,

    error: AppColors.emergencyColor,                 // Danger
    onError: AppColors.whiteColor,

    background: Color(0xFF121212),                   // Dark background
    onBackground: Color(0xFFECECEC),                 // Light text

    surface: Color(0xFF1E1E1E),                       // Cards/surfaces
    onSurface: Color(0xFFECECEC),

    surfaceVariant: Color(0xFF2A2A2A),                // Soft dark surface
    outline: Color(0xFF5A5A5A),                       // Borders/lines
  ),

  scaffoldBackgroundColor: const Color(0xFF121212),

  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1E1E1E),
    foregroundColor: Color(0xFFECECEC),
    centerTitle: true,
    elevation: 0,
    titleTextStyle: TextStyle(
      fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFFECECEC),
    ),
    iconTheme: IconThemeData(color: Color(0xFFECECEC)),
    actionsIconTheme: IconThemeData(color: Color(0xFFECECEC)),
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
      foregroundColor: const Color(0xFFECECEC),
      side: BorderSide(color: AppColors.loginLogoRadiusColor.withValues(alpha: .6)),
      minimumSize: const Size(48, 48),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: AppColors.loginLogoRadiusColor),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF1E1E1E),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    hintStyle: const TextStyle(color: Color(0xFFAAAAAA)),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF3A3A3A), width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF3A3A3A), width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.2),
    ),
  ),

  cardTheme: const CardThemeData(
    color: Color(0xFF1E1E1E),
    elevation: 1,
    margin: EdgeInsets.all(8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
  ),

  chipTheme: ChipThemeData(
    backgroundColor: const Color(0xFF2A2A2A),
    selectedColor: AppColors.loginLogoRadiusColor,
    secondarySelectedColor: AppColors.primaryColor,
    labelStyle: const TextStyle(color: Color(0xFFECECEC)),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    shape: const StadiumBorder(side: BorderSide(color: Color(0xFF2A2A2A))),
  ),

  dividerTheme: const DividerThemeData(
    color: Color(0xFF2E2E2E), thickness: 0.8, space: 24,
  ),

  snackBarTheme: const SnackBarThemeData(
    backgroundColor: AppColors.loginLogoRadiusColor,
    contentTextStyle: TextStyle(color: AppColors.whiteColor),
    behavior: SnackBarBehavior.floating,
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF1E1E1E),
    selectedItemColor: AppColors.primaryColor,
    unselectedItemColor: Color(0xFFAAAAAA),
    selectedIconTheme: IconThemeData(size: 28),
    type: BottomNavigationBarType.fixed,
    elevation: 1,
  ),

  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: AppColors.progressColor,
    linearTrackColor: Color(0xFF2A2A2A),
    circularTrackColor: Color(0xFF2A2A2A),
  ),
);
