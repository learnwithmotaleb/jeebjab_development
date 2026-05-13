import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import '../../../../helper/tost_message/show_snackbar.dart';

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

  // ── Sizes (getter so .tr is evaluated at runtime) ─────────────────────────
  List<ProductSize> get sizes => [
    ProductSize(
      label: AppStrings.small.tr,
      imageUrl:
      'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=200',
    ),
    ProductSize(
      label: AppStrings.medium.tr,
      imageUrl:
      'https://images.unsplash.com/photo-1485965120184-e220f721d03e?w=200',
    ),
    ProductSize(
      label: AppStrings.large.tr,
      imageUrl:
      'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=200',
    ),
    ProductSize(
      label: AppStrings.extraLarge.tr,
      imageUrl:
      'https://images.unsplash.com/photo-1416879595882-3373a0480b5b?w=200',
    ),
  ];

  // ── Restricted Items (getter so .tr is evaluated at runtime) ──────────────
  List<String> get restrictedItems => [
    AppStrings.pianos.tr,
    AppStrings.safetyBoxes.tr,
    AppStrings.bouldersGravelSoil.tr,
  ];



  @override
  void onInit() {
    super.onInit();
    // ── Load images passed from CaptureImageScreen ────────────────────────
    if (Get.arguments != null && Get.arguments['images'] != null) {
      capturedImages.value = List<File>.from(Get.arguments['images']);
      print('📸 CaptureInfoController: Loaded ${capturedImages.length} images');
    }
  }

  void selectSize(String size) => selectedSize.value = size;

  bool get isValid =>
      nameController.text.trim().isNotEmpty && selectedSize.value.isNotEmpty;

  // ── Remove image from gallery ──────────────────────────────────────────
  void removeImage(File image) {
    capturedImages.remove(image);
    capturedImages.refresh(); // Trigger UI update
    print('🗑️ Image removed. Remaining: ${capturedImages.length}');
  }

  void onContinue() {
    if (nameController.text.trim().isEmpty) {
      AppSnackBar.fail("Please enter the name of the product.", title: "Required");
      return;
    }
    if (selectedSize.value.isEmpty) {
      AppSnackBar.fail("Please select the size of the product.", title: "Required");
      return;
    }
    final bool isEditMode = Get.arguments?['isEdit'] ?? false;
    
    if (isEditMode) {
      Get.back();
    } else {
      Get.toNamed(RoutePath.pickupDateTime);
    }
  }

  void onSaveAndPublish() {
    if (nameController.text.trim().isEmpty) {
      AppSnackBar.fail("Please enter the name of the product.", title: "Required");
      return;
    }
    if (selectedSize.value.isEmpty) {
      AppSnackBar.fail("Please select the size of the product.", title: "Required");
      return;
    }
    Get.back(result: true);
  }

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}