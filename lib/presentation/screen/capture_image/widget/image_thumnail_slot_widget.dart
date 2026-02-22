import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';

class ImageThumbnailSlot extends StatelessWidget {
  final File? image;
  final bool isSelected;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;

  const ImageThumbnailSlot({
    super.key,
    this.image,
    this.isSelected = false,
    this.onTap,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: image != null ? onTap : null,
      child: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(8),
          border: isSelected
              ? Border.all(color: AppColors.primaryColor, width: 2)
              : null,
        ),
        child: image != null
            ? Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(
                  isSelected ? 6 : 8),
              child: Image.file(
                image!,
                width: 72,
                height: 72,
                fit: BoxFit.cover,
              ),
            ),
          ],
        )
            : null,
      ),
    );
  }
}