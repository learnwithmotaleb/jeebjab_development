import 'package:flutter/material.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';

class CameraControlsWidget extends StatelessWidget {
  final VoidCallback onGallery;
  final VoidCallback onCapture;
  final VoidCallback onFlip;

  const CameraControlsWidget({
    super.key,
    required this.onGallery,
    required this.onCapture,
    required this.onFlip,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // ── Gallery Button ──────────────────────────────────────────────
        GestureDetector(
          onTap: onGallery,
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.photo_library_outlined,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),

        // ── Capture Button ──────────────────────────────────────────────
        GestureDetector(
          onTap: onCapture,
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
            ),
            child: Container(
              margin: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),

        // ── Flip Camera Button ──────────────────────────────────────────
        GestureDetector(
          onTap: onFlip,
          child: const Icon(
            Icons.flip_camera_ios_outlined,
            color: Colors.white,
            size: 32,
          ),
        ),
      ],
    );
  }
}