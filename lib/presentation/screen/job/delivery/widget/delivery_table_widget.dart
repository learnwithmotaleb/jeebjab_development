import 'package:flutter/material.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import '../controller/delivery_controller.dart';

class DeliveryTableWidget extends StatelessWidget {
  final DeliveryProof delivery;

  const DeliveryTableWidget({super.key, required this.delivery});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Section Title ─────────────────────────────────────────────
        Text(
          'Delivery Details',
          style: TextStyle(
            fontSize: Dimensions.f(18),
            fontWeight: FontWeight.w800,
            color: AppColors.blackColor,
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: Dimensions.h(16)),
        
        // ── Table Container ───────────────────────────────────────────
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.greyColor.withOpacity(0.2), width: 1.5),
            borderRadius: BorderRadius.circular(Dimensions.r(16)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              _buildTableRow('Title', delivery.title),
              _buildTableRow('Category', delivery.category),
              _buildTableRow('Price', '${delivery.currency} ${delivery.price}'),
              _buildTableRow('Size', delivery.size),
              _buildTableRow('Location', delivery.deliveryLocation),
              _buildTableRow('Time', delivery.deliveryTime),
              _buildTableRow('Published', delivery.publishedTime, isLast: true),
            ],
          ),
        ),
        
        SizedBox(height: Dimensions.h(24)),
        
        // ── Description Section ────────────────────────────────────────
        Text(
          'Description',
          style: TextStyle(
            fontSize: Dimensions.f(16),
            fontWeight: FontWeight.w700,
            color: AppColors.blackColor,
          ),
        ),
        SizedBox(height: Dimensions.h(10)),
        Container(
          padding: EdgeInsets.all(Dimensions.r(16)),
          decoration: BoxDecoration(
            color: AppColors.greyColor.withOpacity(0.05),
            borderRadius: BorderRadius.circular(Dimensions.r(12)),
            border: Border.all(color: AppColors.greyColor.withOpacity(0.1)),
          ),
          child: Text(
            delivery.description,
            style: TextStyle(
              fontSize: Dimensions.f(14),
              color: AppColors.blackColor.withOpacity(0.8),
              height: 1.6,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTableRow(String label, String value, {bool isLast = false}) {
    return Container(
      decoration: BoxDecoration(
        border: isLast ? null : Border(
          bottom: BorderSide(color: AppColors.greyColor.withOpacity(0.15), width: 1),
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Label Column ──
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: Dimensions.h(14),
                  horizontal: Dimensions.w(18),
                ),
                color: AppColors.greyColor.withOpacity(0.03),
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: Dimensions.f(13),
                    fontWeight: FontWeight.w600,
                    color: AppColors.labelColor,
                  ),
                ),
              ),
            ),
            
            // ── Vertical Divider ──
            Container(
              width: 1,
              color: AppColors.greyColor.withOpacity(0.15),
            ),
            
            // ── Value Column ──
            Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: Dimensions.h(14),
                  horizontal: Dimensions.w(18),
                ),
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: Dimensions.f(13),
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackColor.withOpacity(0.9),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
