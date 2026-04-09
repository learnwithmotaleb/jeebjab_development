import 'package:flutter/material.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';

class RecentAddressCard extends StatelessWidget {
  final String address;
  final bool isSelected;
  final VoidCallback onTap;

  const RecentAddressCard({
    super.key,
    required this.address,
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
        padding: EdgeInsets.symmetric(
            horizontal: 16, 
            vertical: isTablet ? 18 : 14
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(isTablet ? 12 : 10),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryColor
                : const Color(0xFFE8E8E8),
            width: isSelected ? (isTablet ? 2 : 1.5) : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: isTablet ? 8 : 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          address,
          style: TextStyle(
            fontSize: isTablet ? 16 : 14,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF1A1A2E),
            height: 1.4,
          ),
        ),
      ),
    );
  }
}