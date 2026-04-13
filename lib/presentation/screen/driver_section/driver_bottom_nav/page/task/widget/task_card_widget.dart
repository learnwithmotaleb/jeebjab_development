import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';

import '../controller/task_controller.dart';

class TaskCard extends StatelessWidget {
  final TaskItem item;
  final bool isActive;
  final VoidCallback onPickedUp;
  final VoidCallback onOpenMap;
  final EdgeInsetsGeometry? margin;

  const TaskCard({
    super.key,
    required this.item,
    required this.isActive,
    required this.onPickedUp,
    required this.onOpenMap,
    this.margin,
  });

  IconData get _categoryIcon {
    switch (item.categoryIcon) {
      case 'recycle':
        return Icons.recycling_outlined;
      case 'gift':
        return Icons.card_giftcard_outlined;
      default:
        return Icons.shopping_cart_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.zero,
      padding: EdgeInsets.all(Dimensions.w(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.r(12)),
        border: Border.all(color: const Color(0xFFEEEEEE)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Title row ─────────────────────────────────────────────────
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(_categoryIcon,
                    size: Dimensions.w(22), color: AppColors.labelColor),
                SizedBox(width: Dimensions.w(10)),
                Expanded(
                  child: Text(
                    item.title,
                    style: TextStyle(
                      fontSize: Dimensions.f(16),
                      fontWeight: FontWeight.w800,
                      color: AppColors.labelColor,
                    ),
                  ),
                ),
                // ── Price ─────────────────────────────────────────────────
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${AppStrings.aed.tr} ',
                        style: TextStyle(
                          fontSize: Dimensions.f(11),
                          fontWeight: FontWeight.w600,
                          color: AppColors.labelColor,
                        ),
                      ),
                      TextSpan(
                        text: item.price.toInt().toString(),
                        style: TextStyle(
                          fontSize: Dimensions.f(26),
                          fontWeight: FontWeight.w900,
                          color: AppColors.labelColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
        
            SizedBox(height: Dimensions.h(8)),
        
            // ── Subtitle (person name) ────────────────────────────────────
            Row(
              children: [
                Icon(Icons.person_outline_rounded,
                    size: Dimensions.w(15), color: AppColors.blackColor),
                SizedBox(width: Dimensions.w(6)),
                Text(
                  item.subtitle,
                  style: TextStyle(
                    fontSize: Dimensions.f(13),
                    color: AppColors.blackColor,
                  ),
                ),
              ],
            ),
        
            SizedBox(height: Dimensions.h(4)),
        
            // ── Address ───────────────────────────────────────────────────
            Row(
              children: [
                Icon(Icons.location_on_outlined,
                    size: Dimensions.w(15), color: AppColors.blackColor),
                SizedBox(width: Dimensions.w(6)),
                Expanded(
                  child: Text(
                    item.address,
                    style: TextStyle(
                      fontSize: Dimensions.f(13),
                      color: AppColors.blackColor,
                    ),
                  ),
                ),
              ],
            ),
        
            SizedBox(height: Dimensions.h(14)),
        
            // ── Action buttons ────────────────────────────────────────────
            if (isActive)
            // Active: Picked-Up (outlined) + Open Map (filled)
              Row(
                children: [
                  Expanded(
                    child: _OutlineButton(
                      label: AppStrings.pickedUp.tr,
                      onTap: onPickedUp,
                    ),
                  ),
                  SizedBox(width: Dimensions.w(10)),
                  Expanded(
                    child: _FilledButton(
                      label: AppStrings.openMap.tr,
                      onTap: onOpenMap,
                    ),
                  ),
                ],
              )
            else
            // Completed: Delivered (full width outlined teal)
              _DeliveredButton(),
          ],
        ),
      ),
    );
  }
}

// ── Outlined button (Picked-Up) ───────────────────────────────────────────────
class _OutlineButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _OutlineButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Dimensions.h(42),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.r(8)),
          border: Border.all(color: AppColors.primaryColor),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: Dimensions.f(14),
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}

// ── Filled button (Open Map) ──────────────────────────────────────────────────
class _FilledButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _FilledButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Dimensions.h(42),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(Dimensions.r(8)),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: Dimensions.f(14),
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

// ── Delivered button (full width outlined teal) ───────────────────────────────
class _DeliveredButton extends StatelessWidget {
  const _DeliveredButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Dimensions.h(42),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.r(8)),
        border: Border.all(color: AppColors.primaryColor),
      ),
      alignment: Alignment.center,
      child: Text(
        AppStrings.delivered.tr,
        style: TextStyle(
          fontSize: Dimensions.f(14),
          fontWeight: FontWeight.w600,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}