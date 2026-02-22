import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/routes/route_path.dart';

class ProductSize {
  final String label;
  final String imageUrl;

  ProductSize({required this.label, required this.imageUrl});
}

class CaptureInfoController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final RxString selectedSize = ''.obs;

  // ── Images received from CaptureImageScreen ───────────────────────────────
  final RxList<File> capturedImages = <File>[].obs;

  final List<ProductSize> sizes = [
    ProductSize(
      label: 'Small',
      imageUrl: 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=200',
    ),
    ProductSize(
      label: 'Medium',
      imageUrl: 'https://images.unsplash.com/photo-1485965120184-e220f721d03e?w=200',
    ),
    ProductSize(
      label: 'Large',
      imageUrl: 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=200',
    ),
    ProductSize(
      label: 'Extra Large',
      imageUrl: 'https://images.unsplash.com/photo-1416879595882-3373a0480b5b?w=200',
    ),
  ];

  final List<String> restrictedItems = [
    'Pianos',
    'Safety Boxes',
    'Boulders, Gravel, Soil Or Other Large Piles Of Rubble',
  ];

  @override
  void onInit() {
    super.onInit();
    // ── Load images passed from CaptureImageScreen ────────────────────────
    if (Get.arguments != null && Get.arguments['images'] != null) {
      capturedImages.value = List<File>.from(Get.arguments['images']);
    }
  }

  void selectSize(String size) => selectedSize.value = size;

  bool get isValid =>
      nameController.text.trim().isNotEmpty && selectedSize.value.isNotEmpty;

  void onContinue() {
    // if (!isValid) return;
    Get.toNamed(RoutePath.pickupDateTime);
  }

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}