import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';

import '../controller/be_come_driver_controller.dart';

class DriverTypeCard extends StatelessWidget {
  final BecomeDriverController controller;

  const DriverTypeCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final bool isTablet = Dimensions.isTablet;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isTablet ? 40 : Dimensions.w(24)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isTablet ? 40 : Dimensions.r(24)),
        gradient: const LinearGradient(
          colors: [
            Color(0xFFF3F3F3),
            Color(0xFF17C5B5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: isTablet ? 30 : Dimensions.h(16)),

          // ── Headline ──────────────────────────────────────────────────
          Text(
            AppStrings.startYourJourneyAsADriver.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isTablet ? 24 : Dimensions.f(18),
              fontWeight: FontWeight.w700,
              color: Colors.white,
              height: 1.4,
            ),
          ),

          SizedBox(height: isTablet ? 40 : Dimensions.h(30)),

          // ── Independent Driver ────────────────────────────────────────
          Obx(() {
            final isSelected =
                controller.selectedType.value == DriverType.independent;
            return _DriverButton(
              label: AppStrings.independentDriver.tr,
              isSelected: isSelected,
              onTap: () => controller.selectType(DriverType.independent),
            );
          }),

          SizedBox(height: isTablet ? 20 : Dimensions.h(12)),

          // ── Company Driver ────────────────────────────────────────────
          Obx(() {
            final isSelected =
                controller.selectedType.value == DriverType.company;
            return _DriverButton(
              label: AppStrings.companyDriver.tr,
              isSelected: isSelected,
              onTap: () => controller.selectType(DriverType.company),
            );
          }),

          SizedBox(height: Dimensions.h(8)),
        ],
      ),
    );
  }
}

// ── Single driver button ───────────────────────────────────────────────────────
class _DriverButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _DriverButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isTablet = Dimensions.isTablet;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        height: isTablet ? 100 : 55,
        padding: EdgeInsets.symmetric(
          vertical: isTablet ? 0 : Dimensions.h(15),
        ),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(Dimensions.r(30)),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.white.withOpacity(0.6),
            width: isSelected ? 2 : 1,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: isTablet ? 18 : Dimensions.f(15),
            fontWeight: FontWeight.w700,
            color: isSelected ? AppColors.primaryColor : Colors.white,
          ),
        ),
      ),
    );
  }
}