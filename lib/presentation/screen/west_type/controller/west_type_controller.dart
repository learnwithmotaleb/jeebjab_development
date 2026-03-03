import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';

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
  // ── Selected items set ─────────────────────────────
  final RxSet<String> selectedItems = <String>{}.obs;

  // ── Waste categories and items ─────────────────────
  final List<WasteCategory> categories = [
    WasteCategory(
      title: AppStrings.recyclable.tr,
      items: [
        WasteItem(label: AppStrings.paperCardboard.tr, icon: Icons.description_outlined),
        WasteItem(label: AppStrings.glass.tr, icon: Icons.local_drink_outlined),
        WasteItem(label: AppStrings.newspaper.tr, icon: Icons.newspaper_outlined),
        WasteItem(label: AppStrings.plastic.tr, icon: Icons.water_drop_outlined),
        WasteItem(label: AppStrings.metal.tr, icon: Icons.hardware_outlined),
        WasteItem(label: AppStrings.furniture.tr, icon: Icons.chair_outlined),
        WasteItem(label: AppStrings.foodWaste.tr, icon: Icons.no_food_outlined, hasInfo: true),
      ],
    ),
    WasteCategory(
      title: AppStrings.bulkyWaste.tr,
      items: [
        WasteItem(label: AppStrings.gardenWaste.tr, icon: Icons.grass_outlined),
        WasteItem(label: AppStrings.brokenFurniture.tr, icon: Icons.weekend_outlined),
        WasteItem(label: AppStrings.wood.tr, icon: Icons.forest_outlined),
        WasteItem(label: AppStrings.sortedConstruction.tr, icon: Icons.construction_outlined, hasInfo: true),
        WasteItem(label: AppStrings.sanitaryWare.tr, icon: Icons.bathtub_outlined),
        WasteItem(label: AppStrings.rigidPlastic.tr, icon: Icons.inventory_2_outlined, hasInfo: true),
        WasteItem(label: AppStrings.tyres.tr, icon: Icons.album_outlined),
        WasteItem(label: AppStrings.kitchenAppliances.tr, icon: Icons.kitchen_outlined),
        WasteItem(label: AppStrings.electronics.tr, icon: Icons.devices_outlined),
        WasteItem(label: AppStrings.reuse.tr, icon: Icons.recycling_outlined),
        WasteItem(label: AppStrings.otherWaste.tr, icon: Icons.delete_outline_rounded),
      ],
    ),
    WasteCategory(
      title: AppStrings.householdHazardousWaste.tr,
      items: [
        WasteItem(label: AppStrings.impregnatedWood.tr, icon: Icons.forest_outlined),
        WasteItem(label: AppStrings.paint.tr, icon: Icons.format_paint_outlined),
        WasteItem(label: AppStrings.wasteOil.tr, icon: Icons.opacity_outlined),
        WasteItem(label: AppStrings.asbestos.tr, icon: Icons.warning_amber_outlined, hasInfo: true),
        WasteItem(label: AppStrings.otherHazardousWaste.tr, icon: Icons.dangerous_outlined, hasInfo: true),
      ],
    ),
  ];

  // ── Select/Deselect an item ───────────────────────
  void toggleItem(String label) {
    if (selectedItems.contains(label)) {
      selectedItems.remove(label);
    } else {
      selectedItems.add(label);
    }
  }

  // ── Info items → navigate, not selectable ─────────
  void onInfoItemTap(String label) {
    // Navigate to info screen or show snackbar
    Get.toNamed(RoutePath.notAllowWest);
  }

  // ── Check if selected ─────────────────────────────
  bool isSelected(String label) => selectedItems.contains(label);

  // ── Count of selected items ───────────────────────
  int get selectedCount => selectedItems.length;

  // ── Continue button action ────────────────────────
  void onContinue() {
    Get.toNamed(RoutePath.iWillPay);

  }

  // ── Add new waste item (future) ───────────────────
  void onAddItem() {
    // TODO: Get.toNamed(RoutePath.addWasteItem);
  }
}