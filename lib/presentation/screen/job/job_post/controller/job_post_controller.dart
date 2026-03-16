import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';

class JobPostCategory {
  final String label;
  final IconData icon;

  JobPostCategory({required this.label, required this.icon});
}

class JobPostModel {
  final String title;
  final String imageUrl;
  final double price;
  final String distance;
  final String categoryIcon;

  JobPostModel({
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.distance,
    required this.categoryIcon,
  });
}

class JobPostController extends GetxController {
  // ── Categories ────────────────────────────────────────────────────────────
  final List<JobPostCategory> categories = [
    JobPostCategory(label: 'Move', icon: Icons.inventory_2_outlined),
    JobPostCategory(label: 'Cart', icon: Icons.shopping_cart_outlined),
    JobPostCategory(label: 'Recycle', icon: Icons.recycling_outlined),
    JobPostCategory(label: 'Gift', icon: Icons.card_giftcard_outlined),
  ];

  final RxSet<String> selectedCategories = <String>{'Move'}.obs;

  // ── Sort options ──────────────────────────────────────────────────────────
  final RxString selectedSort = AppStrings.nearest.tr.obs;
  final List<String> sortOptions = [AppStrings.nearest.tr, AppStrings.newest.tr];
  final RxBool showDropdown = false.obs;

  // ── Posts ─────────────────────────────────────────────────────────────────
  final RxList<JobPostModel> posts = <JobPostModel>[
    JobPostModel(
      title: 'Ducati Bike',
      imageUrl: 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400',
      price: 85,
      distance: '3 KM',
      categoryIcon: 'move',
    ),
    JobPostModel(
      title: 'Plastic & Paper',
      imageUrl: 'https://images.unsplash.com/photo-1532996122724-e3c354a0b15b?w=400',
      price: 260,
      distance: '3 KM',
      categoryIcon: 'recycle',
    ),
    JobPostModel(
      title: 'Plastic & Paper',
      imageUrl: 'https://images.unsplash.com/photo-1532996122724-e3c354a0b15b?w=400',
      price: 260,
      distance: '3 KM',
      categoryIcon: 'recycle',
    ),

    JobPostModel(
      title: 'Plastic & Paper',
      imageUrl: 'https://images.unsplash.com/photo-1532996122724-e3c354a0b15b?w=400',
      price: 260,
      distance: '3 KM',
      categoryIcon: 'recycle',
    ),
  ].obs;

  void selectCategory(String label) {
    if (selectedCategories.contains(label)) {
      selectedCategories.remove(label);
    } else {
      selectedCategories.add(label);
    }
  }

  void selectSort(String sort) {
    selectedSort.value = sort;
    showDropdown.value = false;
  }

  void toggleDropdown() => showDropdown.value = !showDropdown.value;

  void openDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }
}