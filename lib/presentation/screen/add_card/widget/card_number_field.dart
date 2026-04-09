import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/presentation/screen/add_card/controller/add_card_controller.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';

class CardNumberField extends StatelessWidget {
  final TextEditingController controller;

  const CardNumberField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final bool isTablet = Dimensions.isTablet;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.cardNumber.tr,
          style: TextStyle(
            fontSize: isTablet ? 16 : Dimensions.f(13),
            fontWeight: FontWeight.w600,
            color: AppColors.labelColor,
          ),
        ),
        SizedBox(height: isTablet ? 12 : Dimensions.h(8)),
        Container(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(isTablet ? 15 : Dimensions.r(10)),
            border: Border.all(color: const Color(0xFFE8E8E8)),
            boxShadow: isTablet
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ]
                : null,
          ),
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CardNumberInputFormatter(),
            ],
            style: TextStyle(
              fontSize: isTablet ? 24 : Dimensions.f(18),
              fontWeight: FontWeight.w700,
              letterSpacing: isTablet ? 4 : 2,
              color: AppColors.labelColor,
            ),
            decoration: InputDecoration(
              hintText: '4084  4084  4084  4084',
              hintStyle: TextStyle(
                fontSize: isTablet ? 24 : Dimensions.f(18),
                fontWeight: FontWeight.w700,
                letterSpacing: isTablet ? 4 : 2,
                color: const Color(0xFFCCCCCC),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: isTablet ? 24 : Dimensions.w(16),
                vertical: isTablet ? 24 : Dimensions.h(16),
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}