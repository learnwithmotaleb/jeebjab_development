import 'package:flutter/material.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';

import '../controller/delivery_controller.dart';

class DeliveryImageCard extends StatelessWidget {
  final DeliveryProof delivery;

  const DeliveryImageCard({super.key, required this.delivery});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Image Container ───────────────────────────────────────────
        ClipRRect(
          borderRadius: BorderRadius.circular(Dimensions.r(20)),
          child: Stack(
            children: [
              // Product Image
              AspectRatio(
                aspectRatio: 1,
                child: Image.network(
                  delivery.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: const Color(0xFFE0E0E0),
                    child: const Icon(Icons.image_outlined, color: Colors.grey),
                  ),
                ),
              ),

              // ── Category Badge (Bottom Left) ────────────────────────
              Positioned(
                bottom: Dimensions.h(12),
                left: Dimensions.w(12),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.w(12),
                    vertical: Dimensions.h(6),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(Dimensions.r(6)),
                  ),
                  child: Text(
                    delivery.category,
                    style: TextStyle(
                      fontSize: Dimensions.f(12),
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              // ── Price Badge (Bottom Right) ──────────────────────────
              Positioned(
                bottom: Dimensions.h(12),
                right: Dimensions.w(12),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.w(12),
                    vertical: Dimensions.h(6),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(Dimensions.r(6)),
                  ),
                  child: Text(
                    '${delivery.currency} ${delivery.price}',
                    style: TextStyle(
                      fontSize: Dimensions.f(12),
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: Dimensions.h(12)),

        // ── Category Label ────────────────────────────────────────────
        Text(
          delivery.category,
          style: TextStyle(
            fontSize: Dimensions.f(12),
            fontWeight: FontWeight.w600,
            color: AppColors.greyColor,
          ),
        ),

        SizedBox(height: Dimensions.h(4)),

        // ── Title ─────────────────────────────────────────────────────
        Text(
          delivery.title,
          style: TextStyle(
            fontSize: Dimensions.f(18),
            fontWeight: FontWeight.w800,
            color: AppColors.labelColor,
          ),
        ),
      ],
    );
  }
}