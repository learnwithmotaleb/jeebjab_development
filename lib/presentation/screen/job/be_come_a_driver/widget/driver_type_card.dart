import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';

import '../controller/be_come_driver_controller.dart';

class DriverTypeCard extends StatelessWidget {
  final BecomeDriverController controller;

  const DriverTypeCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Dimensions.w(24)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.r(24)),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF8EECD8),
            Color(0xFF17C5B5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: Dimensions.h(16)),

          // ── Headline ──────────────────────────────────────────────────
          Text(
            'Start Your Journey as a\nDriver and Unlock Flexible\nIncome',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Dimensions.f(18),
              fontWeight: FontWeight.w700,
              color: Colors.white,
              height: 1.5,
            ),
          ),

          SizedBox(height: Dimensions.h(30)),

          // ── Independent Driver ────────────────────────────────────────
          Obx(() {
            final isSelected =
                controller.selectedType.value == DriverType.independent;
            return _DriverButton(
              label: 'Independent Driver',
              isSelected: isSelected,
              onTap: () => controller.selectType(DriverType.independent),
            );
          }),

          SizedBox(height: Dimensions.h(12)),

          // ── Company Driver ────────────────────────────────────────────
          Obx(() {
            final isSelected =
                controller.selectedType.value == DriverType.company;
            return _DriverButton(
              label: 'Company Driver',
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
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: Dimensions.h(15)),
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
            fontSize: Dimensions.f(15),
            fontWeight: FontWeight.w700,
            color: isSelected ? AppColors.primaryColor : Colors.white,
          ),
        ),
      ),
    );
  }
}