import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import 'package:jeebjab/widget/custom_appbar.dart';

import '../controller/west_type_controller.dart';
import '../widget/west_item_title_widget.dart';

class WestTypeScreen extends StatefulWidget {
  const WestTypeScreen({super.key});

  @override
  State<WestTypeScreen> createState() => _WestTypeScreenState();
}

class _WestTypeScreenState extends State<WestTypeScreen> {
  final WestTypeController controller = Get.put(WestTypeController());
  bool _showInfo = false;

  @override
  Widget build(BuildContext context) {
    final bool isEditMode = Get.arguments?['isEdit'] ?? false;
    return ResponsiveLayout(
      mobile: _buildMobile(isEditMode),
      tablet: _buildTablet(isEditMode),
    );
  }

  Widget _buildMobile(bool isEditMode) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: CommonAppBar(
        title: AppStrings.wasteTypes.tr,
        actions: isEditMode
            ? [
                IconButton(
                  icon: const Icon(Icons.check_rounded, color: AppColors.primaryColor, size: 26),
                  tooltip: 'Save & Publish',
                  onPressed: controller.onSaveAndPublish,
                ),
              ]
            : null,
      ),
      body: Column(
        children: [
          // ── Top info banner ───────────────────────────────────────────
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.w(16),
              vertical: Dimensions.h(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: Dimensions.f(12),
                        color: AppColors.greyColor,
                        height: 1.5,
                      ),
                      children: [
                        TextSpan(
                          text: "${AppStrings.allWasteSorted.tr}\n",
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1A1A2E),
                          ),
                        ),
                        TextSpan(text: AppStrings.wasteSortedDescription.tr),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: Dimensions.w(8)),
                Transform.scale(
                  scale: 1.0, 
                  child: Switch(
                    inactiveThumbColor: AppColors.greyColor.withOpacity(0.5),
                    value: _showInfo,
                    onChanged: (value) {
                      setState(() {
                        _showInfo = value;
                      });
                    },
                  ),
                )
              ],
            ),
          ),

          // ── Scrollable List ───────────────────────────────────────────
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: controller.categories.length,
              itemBuilder: (context, catIndex) {
                final category = controller.categories[catIndex];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Category Header ──────────────────────────
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.w(16),
                        vertical: Dimensions.h(10),
                      ),
                      color: const Color(0xFFF5F6FA),
                      child: Text(
                        category.title,
                        style: TextStyle(
                          fontSize: Dimensions.f(13),
                          fontWeight: FontWeight.w700,
                          color: AppColors.labelColor,
                        ),
                      ),
                    ),

                    // ── Items ─────────────────────────────────────
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: category.items.map((item) {
                          return Obx(() => WasteItemTile(
                                item: item,
                                isSelected: controller.isSelected(item.label),
                                onTap: () => controller.toggleItem(item.label),
                                onInfoTap: () =>
                                    controller.onInfoItemTap(item.label),
                              ));
                        }).toList(),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          // ── Bottom selection count + Continue ─────────────────────────
          Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(
              Dimensions.w(16),
              Dimensions.h(10),
              Dimensions.w(16),
              Dimensions.h(24),
            ),
            child: Obx(() => Column(
                  children: [
                    Row(
                      children: [
                        // ── Checkbox all ──────────────────────────────
                        GestureDetector(
                          onTap: () {
                            // Select/deselect all relevant items
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            width: Dimensions.w(20),
                            height: Dimensions.w(20),
                            decoration: BoxDecoration(
                              color: controller.selectedCount > 0
                                  ? AppColors.primaryColor
                                  : Colors.white,
                              borderRadius:
                                  BorderRadius.circular(Dimensions.r(4)),
                              border: Border.all(
                                color: controller.selectedCount > 0
                                    ? AppColors.primaryColor
                                    : const Color(0xFFCCCCCC),
                                width: 2,
                              ),
                            ),
                            child: controller.selectedCount > 0
                                ? Icon(Icons.check_rounded,
                                    size: Dimensions.w(12), color: Colors.white)
                                : null,
                          ),
                        ),
                        SizedBox(width: Dimensions.w(10)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.selectAllRelevantWaste.tr,
                              style: TextStyle(
                                fontSize: Dimensions.f(12),
                                fontWeight: FontWeight.w600,
                                color: AppColors.labelColor,
                              ),
                            ),
                            Text(
                              'You Have Selected ${controller.selectedCount} Types',
                              style: TextStyle(
                                fontSize: Dimensions.f(11),
                                color: AppColors.greyColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: Dimensions.h(12)),
                    // ── Continue button ────────────────────────────────
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: controller.onContinue,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          padding:
                              EdgeInsets.symmetric(vertical: Dimensions.h(16)),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(Dimensions.r(30)),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          isEditMode ? AppStrings.update.tr : AppStrings.continueButton.tr,
                          style: TextStyle(
                            fontSize: Dimensions.f(16),
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildTablet(bool isEditMode) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: CommonAppBar(
        title: AppStrings.wasteTypes.tr,
        actions: isEditMode
            ? [
                IconButton(
                  icon: const Icon(Icons.check_rounded, color: AppColors.primaryColor, size: 26),
                  tooltip: 'Save & Publish',
                  onPressed: controller.onSaveAndPublish,
                ),
              ]
            : null,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              // ── Top info banner ───────────────────────────────────────────
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.withOpacity(0.1)),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.w(48),
                  vertical: Dimensions.h(20),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.greyColor,
                            height: 1.6,
                          ),
                          children: [
                            TextSpan(
                              text: "${AppStrings.allWasteSorted.tr}\n",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF1A1A2E),
                              ),
                            ),
                            TextSpan(text: AppStrings.wasteSortedDescription.tr),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 32),
                    Transform.scale(
                      scale: 1.4,
                      child: Switch(
                        activeColor: AppColors.primaryColor,
                        inactiveThumbColor: AppColors.greyColor.withOpacity(0.5),
                        value: _showInfo,
                        onChanged: (value) {
                          setState(() {
                            _showInfo = value;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),

              // ── Scrollable List ───────────────────────────────────────────
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: controller.categories.length,
                  itemBuilder: (context, catIndex) {
                    final category = controller.categories[catIndex];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Category Header ──────────────────────────
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.w(48),
                            vertical: Dimensions.h(16),
                          ),
                          color: const Color(0xFFF5F6FA),
                          child: Text(
                            category.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: AppColors.labelColor,
                            ),
                          ),
                        ),

                        // ── Items ─────────────────────────────────────
                        Container(
                          color: Colors.white,
                          child: Column(
                            children: category.items.map((item) {
                              return Obx(() => WasteItemTile(
                                    item: item,
                                    isSelected: controller.isSelected(item.label),
                                    onTap: () => controller.toggleItem(item.label),
                                    onInfoTap: () =>
                                        controller.onInfoItemTap(item.label),
                                  ));
                            }).toList(),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              // ── Bottom selection count + Continue ─────────────────────────
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                padding: EdgeInsets.fromLTRB(
                  Dimensions.w(48),
                  Dimensions.h(24),
                  Dimensions.w(48),
                  Dimensions.h(40),
                ),
                child: Obx(() => Column(
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 180),
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: controller.selectedCount > 0
                                      ? AppColors.primaryColor
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: controller.selectedCount > 0
                                        ? AppColors.primaryColor
                                        : const Color(0xFFCCCCCC),
                                    width: 2.5,
                                  ),
                                ),
                                child: controller.selectedCount > 0
                                    ? const Icon(Icons.check_rounded,
                                        size: 18, color: Colors.white)
                                    : null,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.selectAllRelevantWaste.tr,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.labelColor,
                                  ),
                                ),
                                Text(
                                  'You Have Selected ${controller.selectedCount} Types',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: AppColors.greyColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: controller.onContinue,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              isEditMode ? AppStrings.update.tr : AppStrings.continueButton.tr,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}