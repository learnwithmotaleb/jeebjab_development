import 'package:flutter/material.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';

class PlacementOptionRow extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final bool isRadio; // true = single select circle, false = multi checkbox
  final VoidCallback onTap;

  const PlacementOptionRow({
    super.key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    this.isRadio = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryColor
                : const Color(0xFFE8E8E8),
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // ── Icon ──────────────────────────────────────────────────
            Icon(icon, size: 22, color: const Color(0xFF888888)),
            const SizedBox(width: 12),

            // ── Label ─────────────────────────────────────────────────
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1A1A2E),
                ),
              ),
            ),

            // ── Radio / Checkbox indicator ────────────────────────────
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: isRadio ? BoxShape.circle : BoxShape.rectangle,
                borderRadius: isRadio ? null : BorderRadius.circular(100),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryColor
                      : const Color(0xFFCCCCCC),
                  width: 2,
                ),
                color: isSelected ? AppColors.primaryColor : Colors.white,
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 13, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}