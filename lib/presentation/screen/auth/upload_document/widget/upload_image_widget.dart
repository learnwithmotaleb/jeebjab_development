import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/upload_document_controller.dart';
import '../../../../../utils/app_colors/app_colors.dart';

class UploadImageWidget extends StatelessWidget {
  final UploadDocumentController controller;
  final String docType;
  final String label;

  const UploadImageWidget({
    super.key,
    required this.controller,
    required this.docType,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.blackColor,
          ),
        ),
        const SizedBox(height: 8),
        Obx(() {
          final file = controller.documentFiles[docType];
          
          return Row(
            children: [
              /// Image Preview Box
              if (file != null)
                Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: FileImage(file),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: () => controller.removeImage(docType),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            size: 16,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

              if (file != null) const SizedBox(width: 12),

              /// Add Image Box
              if (file == null)
                GestureDetector(
                  onTap: () => controller.pickImage(docType),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade400, width: 1.5),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.add_a_photo_outlined,
                        size: 32,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
            ],
          );
        }),
      ],
    );
  }
}
