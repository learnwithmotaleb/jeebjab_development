import 'package:flutter/material.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';

import '../controller/bank_card_controller.dart';

class BankCardItemWidget extends StatelessWidget {
  final BankCardModel card;
  final VoidCallback onEdit;

  const BankCardItemWidget({
    super.key,
    required this.card,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Dimensions.w(18)),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(Dimensions.r(14)),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Card Number ─────────────────────────────────────────────
          Text(
            card.cardNumber,
            style: TextStyle(
              fontSize: Dimensions.f(18),
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
              color: AppColors.labelColor,
            ),
          ),

          SizedBox(height: Dimensions.h(14)),

          // ── Added Date + Edit Button ─────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Added Date',
                    style: TextStyle(
                      fontSize: Dimensions.f(11),
                      color: AppColors.greyColor,
                    ),
                  ),
                  SizedBox(height: Dimensions.h(2)),
                  Text(
                    card.addedDate,
                    style: TextStyle(
                      fontSize: Dimensions.f(13),
                      fontWeight: FontWeight.w600,
                      color: AppColors.labelColor,
                    ),
                  ),
                ],
              ),

              // ── Edit Card button ──────────────────────────────────────
              GestureDetector(
                onTap: onEdit,
                child: Text(
                  'Edit Card',
                  style: TextStyle(
                    fontSize: Dimensions.f(13),
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}