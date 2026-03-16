
import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final VoidCallback? onTap;

  const AppCard({super.key, required this.child, this.padding, this.onTap});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final radius = BorderRadius.circular(12);

    final content = Padding(
      padding: padding ?? const EdgeInsets.all(12),
      child: child,
    );

    return Card(
      elevation: t.brightness == Brightness.light ? 1 : 0,
      shape: RoundedRectangleBorder(borderRadius: radius),
      child: onTap != null
          ? InkWell(borderRadius: radius, onTap: onTap, child: content)
          : content,
    );
  }
}
