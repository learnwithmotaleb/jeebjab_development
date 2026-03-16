import 'package:flutter/material.dart';
import 'package:jeebjab/presentation/screen/capture_info/controller/capture_info_controller.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';

class SizeCardWidget extends StatelessWidget {
  final ProductSize size;
  final bool isSelected;
  final VoidCallback onTap;

  const SizeCardWidget({
    super.key,
    required this.size,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 88,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : const Color(0xFFDDDDDD),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ]
              : [],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(isSelected ? 8 : 9),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // ── Background Image ──────────────────────────────────────
              Image.network(
                size.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: const Color(0xFFF0F0F0),
                  child: const Icon(Icons.inventory_2_outlined,
                      size: 32, color: Colors.grey),
                ),
              ),

              // ── Semi-transparent overlay so text is readable ──────────
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.0),
                      Colors.black.withOpacity(0.35),
                    ],
                  ),
                ),
              ),

              // ── Label Text on TOP ─────────────────────────────────────
              Positioned(
                top: 6,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      size.label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: size.label.length > 6 ? 9 : 11,
                        fontWeight: FontWeight.w700,
                        color: isSelected
                            ? AppColors.primaryColor
                            : const Color(0xFF333333),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}