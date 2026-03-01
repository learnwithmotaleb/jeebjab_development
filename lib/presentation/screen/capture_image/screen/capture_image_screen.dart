import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';

import '../controller/capture_image_controller.dart';
import '../widget/camera_control_widget.dart';
import '../widget/image_thumnail_slot_widget.dart';

class CaptureImageScreen extends StatefulWidget {
  const CaptureImageScreen({super.key});

  @override
  State<CaptureImageScreen> createState() => _CaptureImageScreenState();
}

class _CaptureImageScreenState extends State<CaptureImageScreen> {
  final CaptureImageController controller = Get.put(CaptureImageController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobile: _buildMobile());
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // ── Top: Camera Preview ────────────────────────────────────
            Expanded(
              child: Stack(
                children: [
                  Obx(() {
                    final preview = controller.previewImage.value;
                    return Container(
                      width: double.infinity,
                      color: Colors.black,
                      child: preview != null
                          ? Image.file(
                        preview,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                          : const Center(
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white24,
                          size: 64,
                        ),
                      ),
                    );
                  }),

                  // ── Back Button ──────────────────────────────────────
                  Positioned(
                    top: 16,
                    left: 16,
                    child: GestureDetector(
                      onTap: controller.onBack,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),

                  // ── Close Button ─────────────────────────────────────
                  Positioned(
                    top: 16,
                    right: 16,
                    child: GestureDetector(
                      onTap: controller.onBack,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Bottom: Controls Panel ─────────────────────────────────
            Container(
              color: Colors.black,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: Obx(() {
                final images = controller.selectedImages;
                final preview = controller.previewImage.value;
                final hasImages = controller.hasImages;

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ── Thumbnail Row (4 slots) ────────────────────────
                    Row(
                      children: List.generate(
                        CaptureImageController.maxImages,
                            (index) {
                          final File? img =
                          index < images.length ? images[index] : null;
                          final bool isSelected =
                              img != null && preview?.path == img.path;
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ImageThumbnailSlot(
                              image: img,
                              isSelected: isSelected,
                              onTap: () => img != null
                                  ? controller.selectPreview(img)
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ── Camera Controls ───────────────────────────────
                    CameraControlsWidget(
                      onGallery: controller.pickFromGallery,
                      onCapture: controller.captureFromCamera,
                      onFlip: () {},
                    ),

                    // ── Next Button ────────────────────────────────────
                    AnimatedSize(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                      child: hasImages
                          ? Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: controller.onNext,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              AppStrings.next.tr,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                          : const SizedBox.shrink(),
                    ),

                    const SizedBox(height: 8),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}