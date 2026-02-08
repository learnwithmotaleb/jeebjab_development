
import 'package:flutter/material.dart';

class AppPillChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  const AppPillChip({super.key, required this.label, this.selected = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final bg = selected ? t.colorScheme.secondaryContainer : t.colorScheme.surface;
    final fg = selected ? t.colorScheme.onSecondaryContainer : t.colorScheme.onSurface;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: t.colorScheme.outlineVariant),
        ),
        child: Text(label, style: t.textTheme.labelLarge?.copyWith(color: fg)),
      ),
    );
  }
}