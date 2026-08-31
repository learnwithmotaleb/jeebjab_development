import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';

class AvatarPickerWidget extends StatelessWidget {
  final File? pickedImage;
  final String? networkImageUrl;
  final VoidCallback onTap;

  const AvatarPickerWidget({
    super.key,
    required this.pickedImage,
    this.networkImageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    ImageProvider? backgroundImage;
    if (pickedImage != null) {
      backgroundImage = FileImage(pickedImage!);
    } else if (networkImageUrl != null && networkImageUrl!.isNotEmpty) {
      backgroundImage = NetworkImage(networkImageUrl!);
    }

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          // ── Avatar ─────────────────────────────────────────────────
          CircleAvatar(
            radius: Dimensions.w(44),
            backgroundColor: const Color(0xFFEEEEEE),
            backgroundImage: backgroundImage,
            child: backgroundImage == null
                ? Icon(
                    Icons.person_rounded,
                    size: Dimensions.w(44),
                    color: Colors.grey,
                  )
                : null,
          ),

          // ── Edit badge ─────────────────────────────────────────────
          Container(
            width: Dimensions.w(26),
            height: Dimensions.w(26),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.whiteColor, width: 2),
            ),
            child: Icon(
              Icons.camera_alt_rounded,
              size: Dimensions.w(13),
              color: AppColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
