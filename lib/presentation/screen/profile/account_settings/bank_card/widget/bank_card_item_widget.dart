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
    final isTablet = Dimensions.isTablet;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Dimensions.w(isTablet ? 24 : 18)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            const Color(0xFFF8F8F8),
          ],
        ),
        borderRadius: BorderRadius.circular(Dimensions.r(isTablet ? 20 : 14)),
        border: Border.all(
          color: const Color(0xFFEEEEEE),
          width: isTablet ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: Dimensions.r(8),
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Card Type Icon + Number ─────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Card Number
              Expanded(
                child: Text(
                  _formatCardNumber(card.cardNumber),
                  style: TextStyle(
                    fontSize: Dimensions.f(isTablet ? 22 : 18),
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                    color: AppColors.labelColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              // Card Type Icon
              _buildCardTypeIcon(isTablet),
            ],
          ),

          SizedBox(height: Dimensions.h(isTablet ? 20 : 14)),

          // ── Card Details Row ───────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Added Date
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.add_circle_outline,
                          size: Dimensions.w(isTablet ? 14 : 12),
                          color: AppColors.greyColor,
                        ),
                        SizedBox(width: Dimensions.w(4)),
                        Text(
                          'Added Date',
                          style: TextStyle(
                            fontSize: Dimensions.f(isTablet ? 13 : 11),
                            color: AppColors.greyColor,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: Dimensions.h(isTablet ? 4 : 2)),

                    Text(
                      card.addedDate,
                      style: TextStyle(
                        fontSize: Dimensions.f(isTablet ? 15 : 13),
                        fontWeight: FontWeight.w600,
                        color: AppColors.labelColor,
                      ),
                    ),
                  ],
                ),
              ),

              // ── Edit Card button ──────────────────────────────
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.w(isTablet ? 16 : 12),
                  vertical: Dimensions.h(isTablet ? 8 : 6),
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(Dimensions.r(isTablet ? 20 : 16)),
                ),
                child: GestureDetector(
                  onTap: onEdit,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.edit,
                        size: Dimensions.w(isTablet ? 18 : 14),
                        color: AppColors.primaryColor,
                      ),
                      SizedBox(width: Dimensions.w(4)),
                      Text(
                        'Edit',
                        style: TextStyle(
                          fontSize: Dimensions.f(isTablet ? 14 : 12),
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper: Format Card Number (show last 4 digits)
  String _formatCardNumber(String cardNumber) {
    if (cardNumber.isEmpty) return '****';
    if (cardNumber.length <= 4) return cardNumber;
    final last4 = cardNumber.substring(cardNumber.length - 4);
    return '**** **** **** $last4';
  }

  // Helper: Build Card Type Icon
  Widget _buildCardTypeIcon(bool isTablet) {
    // Detect card type from card number (simple logic)
    String cardType = _getCardType(card.cardNumber);

    Widget icon;
    switch (cardType) {
      case 'Visa':
        icon = Text(
          'VISA',
          style: TextStyle(
            fontSize: Dimensions.f(isTablet ? 18 : 14),
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
            letterSpacing: 1,
          ),
        );
        break;
      case 'Mastercard':
        icon = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: Dimensions.w(isTablet ? 20 : 16),
              height: Dimensions.w(isTablet ? 20 : 16),
              decoration: const BoxDecoration(
                color: Color(0xFFEB001B),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: Dimensions.w(4)),
            Container(
              width: Dimensions.w(isTablet ? 20 : 16),
              height: Dimensions.w(isTablet ? 20 : 16),
              decoration: const BoxDecoration(
                color: Color(0xFFF79E1B),
                shape: BoxShape.circle,
              ),
            ),
          ],
        );
        break;
      case 'Amex':
        icon = Text(
          'AMEX',
          style: TextStyle(
            fontSize: Dimensions.f(isTablet ? 16 : 12),
            fontWeight: FontWeight.bold,
            color: const Color(0xFF006FCF),
            letterSpacing: 1,
          ),
        );
        break;
      default:
        icon = Icon(
          Icons.credit_card,
          size: Dimensions.w(isTablet ? 28 : 24),
          color: AppColors.primaryColor.withOpacity(0.6),
        );
    }

    return icon;
  }

  // Helper: Detect card type from number
  String _getCardType(String cardNumber) {
    if (cardNumber.isEmpty) return 'Unknown';

    // Remove spaces
    String cleanNumber = cardNumber.replaceAll(' ', '');

    if (cleanNumber.startsWith('4')) {
      return 'Visa';
    } else if (cleanNumber.startsWith('5')) {
      return 'Mastercard';
    } else if (cleanNumber.startsWith('34') || cleanNumber.startsWith('37')) {
      return 'Amex';
    } else if (cleanNumber.startsWith('6')) {
      return 'Discover';
    }

    return 'Unknown';
  }
}