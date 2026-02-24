import 'package:flutter/material.dart';

class OverviewInfoTile extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback? onPressed; // ✅ Add this

  const OverviewInfoTile({
    super.key,
    required this.title,
    required this.value,
    this.onPressed, // ✅ Optional
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed, // ✅ Trigger callback
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.grey),
            ),
            Row(
              children: [
                Text(value),
                const SizedBox(width: 5),
                const Icon(Icons.arrow_forward_ios, size: 14),
              ],
            )
          ],
        ),
      ),
    );
  }
}