import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';

import '../controller/driver_home_controller.dart';

class CurrentTaskCard extends StatelessWidget {
  final DriverTask task;
  final VoidCallback onPickUp;
  final VoidCallback onOpenMap;

  const CurrentTaskCard({
    super.key,
    required this.task,
    required this.onPickUp,
    required this.onOpenMap,
  });

  IconData get _icon {
    switch (task.categoryIcon) {
      case 'recycle':
        return Icons.recycling_outlined;
      default:
        return Icons.shopping_cart_outlined;
    }
  }

  String _getStatusLabel(TaskStatus status) {
    switch (status) {
      case TaskStatus.pickUp:
        return AppStrings.pickUp.tr;
      case TaskStatus.inTransit:
        return 'In Transit';
      case TaskStatus.delivered:
        return AppStrings.delivered.tr;
    }
  }

  Color _getStatusColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.pickUp:
        return AppColors.primaryColor;
      case TaskStatus.inTransit:
        return const Color(0xFFFFA500); // Orange
      case TaskStatus.delivered:
        return const Color(0xFF4CAF50); // Green
    }
  }

  // ── Show Confirmation Dialog ────────────────────────────────────────
  void _showConfirmationDialog(
      BuildContext context,
      String title,
      String message,
      VoidCallback onYes,
      ) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Title ──────────────────────────────────────────────
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              const SizedBox(height: 8),

              // ── Message ────────────────────────────────────────────
              Text(
                message,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),

              // ── Buttons ────────────────────────────────────────────
              Row(
                children: [
                  // No Button
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        height: 46,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F0F0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'No',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1A1A2E),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Yes Button
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                        onYes();
                      },
                      child: Container(
                        height: 46,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Yes',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = Dimensions.isTablet; // Add this line
    return Container(
      margin: EdgeInsets.only(bottom: Dimensions.h(12)),
      padding: EdgeInsets.all(Dimensions.w(14)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.r(12)),
        border: Border.all(color: const Color(0xFFEEEEEE)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Title + Price ──────────────────────────────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(_icon, size: Dimensions.w(20), color: AppColors.labelColor),
              SizedBox(width: Dimensions.w(8)),
              Expanded(
                child: Text(
                  task.title,
                  style: TextStyle(
                    fontSize: Dimensions.f(15),
                    fontWeight: FontWeight.w800,
                    color: AppColors.labelColor,
                  ),
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${AppStrings.aed.tr} ',
                      style: TextStyle(
                        fontSize: Dimensions.f(10),
                        fontWeight: FontWeight.w600,
                        color: AppColors.labelColor,
                      ),
                    ),
                    TextSpan(
                      text: task.price.toInt().toString(),
                      style: TextStyle(
                        fontSize: Dimensions.f(22),
                        fontWeight: FontWeight.w900,
                        color: AppColors.labelColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: Dimensions.h(6)),

          // ── Person ────────────────────────────────────────────────────
          Row(
            children: [
              Icon(Icons.person_outline_rounded,
                  size: Dimensions.w(14), color: AppColors.greyColor),
              SizedBox(width: Dimensions.w(5)),
              Text(
                task.person,
                style: TextStyle(
                    fontSize: Dimensions.f(12), color: AppColors.greyColor),
              ),
            ],
          ),

          SizedBox(height: Dimensions.h(3)),

          // ── Address ───────────────────────────────────────────────────
          Row(
            children: [
              Icon(Icons.location_on_outlined,
                  size: Dimensions.w(14), color: AppColors.greyColor),
              SizedBox(width: Dimensions.w(5)),
              Expanded(
                child: Text(
                  task.address,
                  style: TextStyle(
                      fontSize: Dimensions.f(12), color: AppColors.greyColor),
                ),
              ),
            ],
          ),

          SizedBox(height: Dimensions.h(12)),

          // ── Action buttons (reactive) ─────────────────────────────────
          Obx(() {
            final status = task.status.value;
            final isPickUp = status == TaskStatus.pickUp;
            final isInTransit = status == TaskStatus.inTransit;
            final isDelivered = status == TaskStatus.delivered;

            return Row(
              children: [
                // ── Status Change Button ──────────────────────────────
                Expanded(
                  child: GestureDetector(
                    onTap: isPickUp
                        ? () {
                      _showConfirmationDialog(
                        context,
                        'Are You Sure',
                        'Are You Sure, You Are Picked-Up ?',
                            () {
                          task.status.value = TaskStatus.inTransit;
                        },
                      );
                    }
                        : isInTransit
                        ? () {
                      _showConfirmationDialog(
                        context,
                        'Are You Sure',
                        'Are You Sure, You Will Mark as Delivered ?',
                            () {
                          task.status.value = TaskStatus.delivered;
                        },
                      );
                    }
                        : null,
                    child: Container(
                      height: isTablet ? Dimensions.h(100) : Dimensions.h(40),
                      decoration: BoxDecoration(
                        color: isDelivered ? Colors.white : Colors.white,
                        borderRadius: BorderRadius.circular(Dimensions.r(8)),
                        border: Border.all(
                          color: isPickUp
                              ? AppColors.primaryColor
                              : isInTransit
                              ? AppColors.primaryColor
                              : AppColors.primaryColor,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        isPickUp
                            ? AppStrings.pickUp.tr
                            : isInTransit
                            ? 'In Transit'
                            : AppStrings.delivered.tr,
                        style: TextStyle(
                          fontSize: isTablet ? Dimensions.f(18) : Dimensions.f(13),
                          fontWeight: FontWeight.w700,
                          color: isPickUp
                              ? AppColors.primaryColor
                              : isInTransit
                              ? AppColors.primaryColor
                              : AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: Dimensions.w(10)),

                // ── Open Map Button ────────────────────────────────────
                Expanded(
                  child: GestureDetector(
                    onTap: onOpenMap,
                    child: Container(
                      height: isTablet ? Dimensions.h(100) : Dimensions.h(40),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(Dimensions.r(8)),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        AppStrings.openMap.tr,
                        style: TextStyle(
                          fontSize: isTablet ? Dimensions.f(18) : Dimensions.f(13),
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}