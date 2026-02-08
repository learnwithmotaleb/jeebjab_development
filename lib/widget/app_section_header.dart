
import 'package:flutter/material.dart';

class AppSectionHeader extends StatelessWidget {
  final String title;
  final String? trailingText;
  final VoidCallback? onAction;

  const AppSectionHeader({super.key, required this.title, this.trailingText, this.onAction});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Text(title, style: t.textTheme.titleMedium),
          const Spacer(),
          if (trailingText != null)
            TextButton(onPressed: onAction, child: Text(trailingText!)),
        ],
      ),
    );
  }
}
