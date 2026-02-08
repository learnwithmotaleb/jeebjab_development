import 'package:flutter/material.dart';
import 'dimensions.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        // Desktop
        if (width >= 1024) {
          return desktop ?? tablet ?? mobile;
        }

        // Tablet
        if (width >= 600) {
          return tablet ?? mobile;
        }

        // Mobile
        return mobile;
      },
    );
  }
}
