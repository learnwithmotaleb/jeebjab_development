import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';

class BottomSheetTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final List<String> items;

  const BottomSheetTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.items,
  });

  void _openSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _CompanyBottomSheet(
        title: label,
        items: items,
        onSelect: (value) {
          controller.text = value;
          Get.back();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openSheet(context),
      child: AbsorbPointer(
        child: TextFormField(
          controller: controller,
          readOnly: true,
          style: TextStyle(
            fontSize: Dimensions.f(14),
            color: AppColors.labelColor,
          ),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              fontSize: Dimensions.f(14),
              color: AppColors.greyColor,
            ),
            suffixIcon: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.greyColor,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(
              horizontal: Dimensions.w(16),
              vertical: Dimensions.h(14),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.r(10)),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.r(10)),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.r(10)),
              borderSide: BorderSide(color: AppColors.primaryColor),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Bottom sheet content ──────────────────────────────────────────────────────
class _CompanyBottomSheet extends StatefulWidget {
  final String title;
  final List<String> items;
  final Function(String) onSelect;

  const _CompanyBottomSheet({
    required this.title,
    required this.items,
    required this.onSelect,
  });

  @override
  State<_CompanyBottomSheet> createState() => _CompanyBottomSheetState();
}

class _CompanyBottomSheetState extends State<_CompanyBottomSheet> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(Dimensions.r(20)),
        ),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Handle ───────────────────────────────────────────────────
          SizedBox(height: Dimensions.h(12)),
          Container(
            width: Dimensions.w(40),
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFDDDDDD),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: Dimensions.h(16)),

          // ── Title ────────────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w(16)),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: Dimensions.f(16),
                  fontWeight: FontWeight.w700,
                  color: AppColors.labelColor,
                ),
              ),
            ),
          ),

          SizedBox(height: Dimensions.h(12)),

          // ── List ─────────────────────────────────────────────────────
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 400,
            ),
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.w(16), vertical: Dimensions.h(4)),
              itemCount: widget.items.length,
              separatorBuilder: (_, __) =>
              const Divider(height: 1, color: Color(0xFFF0F0F0)),
              itemBuilder: (_, index) {
                final item = widget.items[index];
                return ListTile(
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: Dimensions.w(4)),
                  title: Text(
                    item,
                    style: TextStyle(
                      fontSize: Dimensions.f(14),
                      fontWeight: FontWeight.w500,
                      color: AppColors.labelColor,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios_rounded,
                      size: Dimensions.w(14),
                      color: const Color(0xFFCCCCCC)),
                  onTap: () => widget.onSelect(item),
                );
              },
            ),
          ),

          SizedBox(height: Dimensions.h(20)),
        ],
      ),
    );
  }
}