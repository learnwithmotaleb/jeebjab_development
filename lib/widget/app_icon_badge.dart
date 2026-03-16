
import 'package:flutter/material.dart';

class AppIconBadge extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? color;

  const AppIconBadge({super.key, required this.icon, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final bg = (color ?? t.colorScheme.secondary).withOpacity(0.15);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 16, color: color ?? t.colorScheme.secondary),
        const SizedBox(width: 6),
        Text(text, style: t.textTheme.labelMedium),
      ]),
    );
  }
}
