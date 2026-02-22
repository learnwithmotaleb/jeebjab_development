import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/widget/app_bottom_sheet.dart';

import '../widget/catagory_info_sheet_widget.dart';

class PostCategoryModel {
  final String title;
  final String subtitle;
  final bool isEnabled;

  PostCategoryModel({
    required this.title,
    required this.subtitle,
    this.isEnabled = true,
  });
}

class CreatePostController extends GetxController {
  // ── Selected Category ─────────────────────────────────────────────────────
  final Rx<PostCategoryModel?> selectedCategory = Rx<PostCategoryModel?>(null);

  // ── Categories List ───────────────────────────────────────────────────────
  final List<PostCategoryModel> categories = [
    PostCategoryModel(
      title: 'Move',
      subtitle: 'Delivers Package From One Place To Another Place',
      isEnabled: true,
    ),
    PostCategoryModel(
      title: 'Recycling',
      subtitle: 'Used Or Discarded Materials Transforming Them Into New',
      isEnabled: true,
    ),
    PostCategoryModel(
      title: 'Buy For Me',
      subtitle: 'Used Or Discarded Materials Transforming Them Into New',
      isEnabled: false,
    ),
    PostCategoryModel(
      title: 'Give Away',
      subtitle: 'Used Or Discarded Materials Transforming Them Into New',
      isEnabled: false,
    ),
  ];

  // ── Select Category → show bottom sheet ──────────────────────────────────
  void selectCategory(PostCategoryModel category) {
    if (!category.isEnabled) return;
    selectedCategory.value = category;
    _showCategorySheet(category);
  }

  void _showCategorySheet(PostCategoryModel category) {
    AppBottomSheet(
      child: CategoryInfoSheet(
        categoryKey: category.title, // 'Move' or 'Recycling'
        onContinue: () {
          Get.back(); // close sheet
          Get.toNamed(RoutePath.captureImage); // 2. then navigate

        },
      ),
    );
  }

  void _navigateToNextStep(PostCategoryModel category) {
    // TODO: Navigate based on category
    // Get.toNamed(RoutePath.createPostDetails, arguments: {
    //   'category': category.title,
    // });
  }

  bool isSelected(PostCategoryModel category) {
    return selectedCategory.value?.title == category.title;
  }
}