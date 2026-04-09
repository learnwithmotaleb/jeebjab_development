import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/presentation/screen/capture_info/controller/capture_info_controller.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';

class SizeCardWidget extends StatelessWidget {
  final ProductSize size;
  final bool isSelected;
  final File? productImage;
  final VoidCallback onTap;

  const SizeCardWidget({
    super.key,
    required this.size,
    required this.isSelected,
    this.productImage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isTablet = Dimensions.isTablet;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: isTablet ? 150 : 88,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(isTablet ? 16 : 10),
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : const Color(0xFFDDDDDD),
            width: isSelected ? (isTablet ? 3 : 2) : 1,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.15),
              blurRadius: isTablet ? 12 : 8,
              offset: Offset(0, isTablet ? 4 : 3),
            ),
          ]
              : [],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(isSelected ? (isTablet ? 14 : 8) : (isTablet ? 15 : 9)),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // ── Background Image (File or Network) ──────────────────
              productImage != null
                  ? Image.file(
                productImage!,
                fit: BoxFit.cover,
              )
                  : Image.network(
                size.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: const Color(0xFFF0F0F0),
                  child: Icon(Icons.inventory_2_outlined,
                      size: isTablet ? 48 : 32, color: Colors.grey),
                ),
              ),

              // ── Semi-transparent overlay ──────────────────────────
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.0),
                      Colors.black.withOpacity(0.4),
                    ],
                  ),
                ),
              ),

              // ── Label Text on TOP ─────────────────────────────────────
              Positioned(
                top: isTablet ? 12 : 6,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: isTablet ? 12 : 4, 
                        vertical: isTablet ? 6 : 2),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(isTablet ? 8 : 4),
                    ),
                    child: Text(
                      size.label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isTablet ? 18 : (size.label.length > 6 ? 9 : 11),
                        fontWeight: FontWeight.w800,
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