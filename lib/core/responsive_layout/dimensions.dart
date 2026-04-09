import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Responsive scaling helpers based on a base design size.
/// Base Figma: 390 x 844 (iPhone 12).
class Dimensions {
  Dimensions._();

  // Base design (Figma reference)
  static const double baseWidth = 390.0;
  static const double baseHeight = 844.0;

  // Live screen size
  static double get screenWidth => Get.width;
  static double get screenHeight => Get.height;

  // Orientation-aware sides
  static double get shortestSide =>
      screenWidth < screenHeight ? screenWidth : screenHeight;

  static double get longestSide =>
      screenWidth > screenHeight ? screenWidth : screenHeight;

  // MediaQuery safe access
  static MediaQueryData? get _mq =>
      Get.context != null ? MediaQuery.of(Get.context!) : null;

  static double get pixelRatio => _mq?.devicePixelRatio ?? 2.0;
  static double get textScale => _mq?.textScaleFactor ?? 1.0;

  /// Width scale
  static double w(double value) {
    final scaled = value * (screenWidth / baseWidth);
    return clampSpace(scaled);
  }

  /// Height scale
  static double h(double value) {
    final scaled = value * (screenHeight / baseHeight);
    return clampSpace(scaled);
  }

  /// Font scale (stable on rotation)
  static double f(double size, {bool respectTextScale = true}) {
    double scaled = size * (shortestSide / baseWidth);

    if (respectTextScale) {
      scaled *= textScale;
    }

    return clampFont(scaled);
  }

  /// Radius scale
  static double r(double radius) {
    final scaled = radius * (screenWidth / baseWidth);
    return clampSpace(scaled);
  }


  ///Responsive Font Size
  static double responsiveFont({
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    if (isDesktop) return f(desktop ?? tablet ?? mobile);
    if (isTablet) return f(tablet ?? mobile);
    return f(mobile);
  }


  ///Responsive height and widget for container
  static double responsiveHeightWidth({
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    if (isDesktop) return f(desktop ?? tablet ?? mobile);
    if (isTablet) return f(tablet ?? mobile);
    return f(mobile);
  }

  //Responsive Icon Size
  static double responsiveIcon({
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    if (isDesktop) return w(desktop ?? tablet ?? mobile);
    if (isTablet) return w(tablet ?? mobile);
    return w(mobile);
  }

  // Padding helpers
  static EdgeInsets pAll(double v) => EdgeInsets.all(w(v));

  static EdgeInsets pSym({double h = 16, double v = 16}) =>
      EdgeInsets.symmetric(horizontal: w(h), vertical: h);

  static EdgeInsets pOnly({
    double l = 0,
    double t = 0,
    double r = 0,
    double b = 0,
  }) =>
      EdgeInsets.only(
        left: w(l),
        top: h(t),
        right: w(r),
        bottom: h(b),
      );

  // Common paddings
  static EdgeInsets get pSmall => pAll(8);
  static EdgeInsets get pMedium => pAll(16);
  static EdgeInsets get pLarge => pAll(24);

  // Common gaps
  static SizedBox gapW(double v) => SizedBox(width: w(v));
  static SizedBox gapH(double v) => SizedBox(height: h(v));

  /// Safe areas
  static EdgeInsets get safePadding => _mq?.padding ?? EdgeInsets.zero;

  /// Breakpoints (shortestSide based = orientation safe)
  static bool get isMobile => shortestSide < 600;
  static bool get isTablet =>
      shortestSide >= 600 && shortestSide < 1024;
  static bool get isDesktop => shortestSide >= 1024;

  /// Clamp font sizes
  static double clampFont(
      double value, {
        double min = 12,
        double max = 28,
      }) {
    return value.clamp(min, max);
  }

  /// Clamp spacing
  static double clampSpace(
      double value, {
        double min = 4,
        double max = 80,
      }) {
    return value.clamp(min, max);
  }
}
