import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/routes/route_path.dart';

class WasteItem {
  final String label;
  final IconData icon;
  final bool hasInfo; // if true → tap navigates, NOT selectable

  WasteItem({required this.label, required this.icon, this.hasInfo = false});
}

class WasteCategory {
  final String title;
  final List<WasteItem> items;

  WasteCategory({required this.title, required this.items});
}

class WestTypeController extends GetxController {
  final RxSet<String> selectedItems = <String>{}.obs;

  final List<WasteCategory> categories = [
    WasteCategory(
      title: 'Recyclable',
      items: [
        WasteItem(label: 'Paper, Cardboard', icon: Icons.description_outlined),
        WasteItem(label: 'Glass', icon: Icons.local_drink_outlined),
        WasteItem(label: 'Newspaper', icon: Icons.newspaper_outlined),
        WasteItem(label: 'Plastic', icon: Icons.water_drop_outlined),
        WasteItem(label: 'Metal', icon: Icons.hardware_outlined),
        WasteItem(label: 'Furniture', icon: Icons.chair_outlined),
        WasteItem(
            label: 'Food Waste',
            icon: Icons.no_food_outlined,
            hasInfo: true),
      ],
    ),
    WasteCategory(
      title: 'Bulky Waste',
      items: [
        WasteItem(label: 'Garden Waste', icon: Icons.grass_outlined),
        WasteItem(
            label: 'Broken Furniture', icon: Icons.weekend_outlined),
        WasteItem(label: 'Wood', icon: Icons.forest_outlined),
        WasteItem(
            label: 'Sorted Construction',
            icon: Icons.construction_outlined,
            hasInfo: true),
        WasteItem(label: 'Sanitary Ware', icon: Icons.bathtub_outlined),
        WasteItem(
            label: 'Rigid Plastic, Safe PVC, Styrofoam',
            icon: Icons.inventory_2_outlined,
            hasInfo: true),
        WasteItem(label: 'Tyres', icon: Icons.album_outlined),
        WasteItem(
            label: 'Kitchen Appliances', icon: Icons.kitchen_outlined),
        WasteItem(label: 'Electronics', icon: Icons.devices_outlined),
        WasteItem(label: 'Reuse', icon: Icons.recycling_outlined),
        WasteItem(label: 'Other Waste', icon: Icons.delete_outline_rounded),
      ],
    ),
    WasteCategory(
      title: 'Household Hazardous Waste',
      items: [
        WasteItem(
            label: 'Impregnated Wood',
            icon: Icons.forest_outlined),
        WasteItem(label: 'Paint', icon: Icons.format_paint_outlined),
        WasteItem(label: 'Waste Oil', icon: Icons.opacity_outlined),
        WasteItem(label: 'Asbestos', icon: Icons.warning_amber_outlined, hasInfo: true),
        WasteItem(
            label: 'Others Hazardous Waste',
            icon: Icons.dangerous_outlined,
            hasInfo: true),
      ],
    ),
  ];

  void toggleItem(String label) {
    if (selectedItems.contains(label)) {
      selectedItems.remove(label);
    } else {
      selectedItems.add(label);
    }
  }

  // ── Info items → navigate, not selectable ─────────────────────────────────
  void onInfoItemTap(String label) {
    // TODO: Get.toNamed(RoutePath.wasteItemInfo, arguments: {'label': label});
    // Get.snackbar(
    //   label,
    //   'More information about this waste type.',
    //   snackPosition: SnackPosition.BOTTOM,
    //   backgroundColor: const Color(0xFF1A1A2E),
    //   colorText: Colors.white,
    //   borderRadius: 12,
    //   margin: const EdgeInsets.all(16),
    // );
    Get.toNamed(RoutePath.notAllowWest);
  }

  bool isSelected(String label) => selectedItems.contains(label);

  int get selectedCount => selectedItems.length;

  void onContinue() {
    if (selectedItems.isEmpty) return;
    // TODO: navigate next
  }

  // ── Add new waste item (future) ───────────────────────────────────────────
  void onAddItem() {
    // TODO: Get.toNamed(RoutePath.addWasteItem);
    // On return, append new WasteItem to relevant category
  }
}