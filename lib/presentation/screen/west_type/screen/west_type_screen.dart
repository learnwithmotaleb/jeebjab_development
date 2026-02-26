import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
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
    return ResponsiveLayout(mobile: _buildMobile());
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: CommonAppBar(title: "Waste Types"),
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
                      children: const [
                        TextSpan(
                          text: 'All Waste Is Sorted\n',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1A1A2E),
                          ),
                        ),
                        TextSpan(
                          text:
                          'We sort all the waste types and you can be sure that all the waste items will be handled correctly.',
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: Dimensions.w(8)),

                Transform.scale(
                  scale: 1.0, // 1.0 = default size
                  child:
                  Switch(
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
                          // ✅ Each tile wrapped in own Obx
                          return Obx(() => WasteItemTile(
                            item: item,
                            isSelected: controller.isSelected(item.label),
                            onTap: () => controller.toggleItem(item.label),
                            onInfoTap: () => controller.onInfoItemTap(item.label),
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
                            size: Dimensions.w(12),
                            color: Colors.white)
                            : null,
                      ),
                    ),
                    SizedBox(width: Dimensions.w(10)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select All Relevant Waste Types',
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
                      padding: EdgeInsets.symmetric(
                          vertical: Dimensions.h(16)),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(Dimensions.r(30)),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Continue',
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
}