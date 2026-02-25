import 'package:flutter/material.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';

class InfoSectionCard extends StatelessWidget {
  final String sectionTitle;
  final Map<String, String> data;

  const InfoSectionCard({
    super.key,
    required this.sectionTitle,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Dimensions.w(10)),
      decoration: BoxDecoration(
        color:AppColors.whiteColor,
        borderRadius: BorderRadius.circular(Dimensions.r(5)),

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Section Title ─────────────────────────────────────────────
          Text(
            sectionTitle,
            style: TextStyle(
              fontSize: Dimensions.f(16),
              fontWeight: FontWeight.normal,
              color: AppColors.primaryColor,
            ),
          ),

          SizedBox(height: Dimensions.h(5)),

          // ── Rows ──────────────────────────────────────────────────────
          ...data.entries.map(
                (entry) => Padding(
              padding: EdgeInsets.only(bottom: Dimensions.h(5)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Label
                  SizedBox(
                    width: Dimensions.w(140),
                    child: Text(
                      entry.key,
                      style: TextStyle(
                        fontSize: Dimensions.f(12),
                        fontWeight: FontWeight.w700,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ),
                  // Value
                  Expanded(
                    child: Text(
                      entry.value,
                      style: TextStyle(
                        fontSize: Dimensions.f(12),
                        fontWeight: FontWeight.w400,
                        color: AppColors.labelColor,
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