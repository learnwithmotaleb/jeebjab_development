import 'package:flutter/material.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';

import '../controller/delivery_controller.dart';

class DeliveryInfoSection extends StatelessWidget {
  final DeliveryProof delivery;

  const DeliveryInfoSection({super.key, required this.delivery});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Description ────────────────────────────────────────────────
        Text(
          delivery.description,
          style: TextStyle(
            fontSize: Dimensions.f(13),
            color: AppColors.greyColor,
            height: 1.5,
          ),
        ),

        SizedBox(height: Dimensions.h(16)),

        // ── Published Time ─────────────────────────────────────────────
        Text(
          delivery.publishedTime,
          style: TextStyle(
            fontSize: Dimensions.f(11),
            color: AppColors.greyColor,
          ),
        ),

        SizedBox(height: Dimensions.h(20)),

        // ── Size Section ───────────────────────────────────────────────
        _InfoRow(
          label: 'Size',
          value: delivery.size,
        ),

        SizedBox(height: Dimensions.h(12)),

        // ── Delivery Location ──────────────────────────────────────────
        _InfoRow(
          label: 'Delivery Location',
          value: delivery.deliveryLocation,
          iconData: Icons.location_on_outlined,
        ),

        SizedBox(height: Dimensions.h(12)),

        // ── Delivery Time ─────────────────────────────────────────────
        _InfoRow(
          label: 'Delivery Time',
          value: delivery.deliveryTime,
          iconData: Icons.access_time_outlined,
        ),
      ],
    );
  }
}

// ── Helper Widget for Info Row ─────────────────────────────────────────
class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData? iconData;

  const _InfoRow({
    required this.label,
    required this.value,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Icon (optional) ────────────────────────────────────────────
        if (iconData != null)
          Icon(
            iconData,
            size: Dimensions.w(14),
            color: AppColors.greyColor,
          ),

        if (iconData != null) SizedBox(width: Dimensions.w(8)),

        // ── Label ──────────────────────────────────────────────────────
        SizedBox(
          width: Dimensions.w(120),
          child: Text(
            label,
            style: TextStyle(
              fontSize: Dimensions.f(12),
              fontWeight: FontWeight.w600,
              color: AppColors.labelColor,
            ),
          ),
        ),

        // ── Value ──────────────────────────────────────────────────────
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: Dimensions.f(12),
              fontWeight: FontWeight.w600,
              color: AppColors.labelColor,
            ),
          ),
        ),
      ],
    );
  }
}