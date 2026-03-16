import 'package:flutter/material.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';

class EditableInfoSection extends StatelessWidget {
  final String sectionTitle;
  final List<EditableInfoRow> rows;

  const EditableInfoSection({
    super.key,
    required this.sectionTitle,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Dimensions.w(16)),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(Dimensions.r(12)),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Section Label ──────────────────────────────────────────────
          Text(
            sectionTitle,
            style: TextStyle(
              fontSize: Dimensions.f(13),
              fontWeight: FontWeight.w500,
              color:AppColors.primaryColor,
            ),
          ),

          SizedBox(height: Dimensions.h(12)),

          // ── Field Rows ─────────────────────────────────────────────────
          ...rows.map(
                (row) => Padding(
              padding: EdgeInsets.only(bottom: Dimensions.h(10)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Label
                  SizedBox(
                    width: Dimensions.w(130),
                    child: Text(
                      row.label,
                      style: TextStyle(
                        fontSize: Dimensions.f(13),
                        fontWeight: FontWeight.w700,
                        color: AppColors.labelColor,
                      ),
                    ),
                  ),

                  // Input
                  Expanded(
                    child: Container(
                      height: Dimensions.h(36),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(Dimensions.r(6)),
                        border:
                        Border.all(color: const Color(0xFFE8E8E8)),
                      ),
                      child: TextField(
                        controller: row.controller,
                        keyboardType: row.keyboardType,
                        style: TextStyle(
                          fontSize: Dimensions.f(12),
                          color: AppColors.labelColor,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: Dimensions.w(10),
                            vertical: Dimensions.h(9),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EditableInfoRow {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;

  EditableInfoRow({
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.text,
  });
}