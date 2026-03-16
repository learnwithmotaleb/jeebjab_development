import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';

// ── Bottom Sheet Data Model ───────────────────────────────────────────────────
class CategorySheetData {
  final String title;
  final List<String> bulletPoints;
  final List<_SheetIconItem> icons;

  CategorySheetData({
    required this.title,
    required this.bulletPoints,
    required this.icons,
  });
}

class _SheetIconItem {
  final IconData icon;
  final String label;

  _SheetIconItem({required this.icon, required this.label});
}

// ── Sheet Data per Category ───────────────────────────────────────────────────
final Map<String, CategorySheetData> categorySheetDataMap = {
  'move': CategorySheetData(
    title: 'Move And Delivery',
    bulletPoints: [
      'Move Anything From A To B',
      'Same Day Delivery',
      'Secure In App Payment Once You Confirm The Job Done',
    ],
    icons: [
      _SheetIconItem(icon: Icons.local_shipping_outlined, label: 'Small\nMoves'),
      _SheetIconItem(icon: Icons.chair_outlined, label: '2nd Hand\nStuff'),
      _SheetIconItem(icon: Icons.inventory_2_outlined, label: 'Pick Up Lost\nItems'),
      _SheetIconItem(icon: Icons.storefront_outlined, label: 'From A\nStore'),
    ],
  ),
  'recycling': CategorySheetData(
    title: 'Remove And Recycle',
    bulletPoints: [
      'Max 3 Cubic Meters Of Waste Per Ad',
      'Set Your Own Price And Pay Securely Via The App',
      'Helpers Verify All Recycling To Jimjap',
    ],
    icons: [
      _SheetIconItem(icon: Icons.eco_outlined, label: 'Garden\nWaste'),
      _SheetIconItem(icon: Icons.weekend_outlined, label: 'Old\nFurniture'),
      _SheetIconItem(icon: Icons.recycling_outlined, label: 'Daily\nRecyclable'),
      _SheetIconItem(icon: Icons.delete_outline_rounded, label: 'General\nDeclutter'),
    ],
  ),
};

// ── Category Info Bottom Sheet Widget ────────────────────────────────────────
class CategoryInfoSheet extends StatelessWidget {
  final String categoryKey;
  final VoidCallback onContinue;

  const CategoryInfoSheet({
    super.key,
    required this.categoryKey,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final data = categorySheetDataMap[categoryKey];
    if (data == null) return const SizedBox.shrink();

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Drag Handle ──────────────────────────────────────────────────
          Container(
            width: 40,
            height: 2,
            decoration: BoxDecoration(
              color: const Color(0xFFDDDDDD),
              borderRadius: BorderRadius.circular(2),
            ),
          ),


          // ── Close Button ─────────────────────────────────────────────────
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFCCCCCC), width: 1.5),
                ),
                child: const Icon(Icons.close, size: 16, color: Colors.grey),
              ),
            ),
          ),



          // ── Icon Row ──────────────────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: data.icons.map((item) => _IconLabel(item: item)).toList(),
          ),

          const SizedBox(height: 10),
          // ── Title ─────────────────────────────────────────────────────────
          Text(
            data.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1A1A2E),
            ),
          ),

          const SizedBox(height: 10),

          // ── Bullet Points ─────────────────────────────────────────────────
          ...data.bulletPoints.map(
                (point) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: CircleAvatar(
                      radius: 5,
                      backgroundColor: Color(0xFFCCCCCC),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      point,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF444444),
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          // ── Continue Button ───────────────────────────────────────────────
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onContinue,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child:  Text(
                AppStrings.continueButton.tr,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Icon + Label widget ───────────────────────────────────────────────────────
class _IconLabel extends StatelessWidget {
  final _SheetIconItem item;

  const _IconLabel({required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(item.icon, size: 34, color: const Color(0xFF888888)),
        const SizedBox(height: 6),
        Text(
          item.label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF888888),
            height: 1.3,
          ),
        ),
      ],
    );
  }
}