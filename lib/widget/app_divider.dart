
import 'package:flutter/material.dart';

class AppDivider extends StatelessWidget {
  final double thickness;
  final EdgeInsetsGeometry? margin;

  const AppDivider({super.key, this.thickness = 0.6, this.margin});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).dividerColor;
    return Padding(
      padding: margin ?? const EdgeInsets.symmetric(vertical: 8),
      child: Divider(color: color, thickness: thickness, height: thickness),
    );
  }
}
