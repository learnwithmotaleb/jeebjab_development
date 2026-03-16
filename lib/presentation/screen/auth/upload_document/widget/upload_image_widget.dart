import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/upload_document_controller.dart';


class UploadImageWidget extends StatelessWidget {
  final UploadDocumentController controller;

  const UploadImageWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        children: [
          /// Image Preview Box
          if (controller.imageFile.value != null)
            Stack(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: FileImage(controller.imageFile.value!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: GestureDetector(
                    onTap: controller.removeImage,
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

          const SizedBox(width: 12),

          /// Add Image Box
          GestureDetector(
            onTap: controller.pickImage,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: const Center(
                child: Icon(
                  Icons.add,
                  size: 32,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
