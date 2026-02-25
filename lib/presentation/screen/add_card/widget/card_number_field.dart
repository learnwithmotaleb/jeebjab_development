import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/presentation/screen/add_card/controller/add_card_controller.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';

class CardNumberField extends StatelessWidget {
  final TextEditingController controller;

  const CardNumberField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Card Number',
          style: TextStyle(
            fontSize: Dimensions.f(13),
            fontWeight: FontWeight.w600,
            color: AppColors.labelColor,
          ),
        ),
        SizedBox(height: Dimensions.h(8)),
        Container(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(Dimensions.r(10)),
            border: Border.all(color: const Color(0xFFE8E8E8)),
          ),
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CardNumberInputFormatter(),
            ],
            style: TextStyle(
              fontSize: Dimensions.f(18),
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
              color: AppColors.labelColor,
            ),
            decoration: InputDecoration(
              hintText: '4084  4084  4084  4084',
              hintStyle: TextStyle(
                fontSize: Dimensions.f(18),
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
                color: const Color(0xFFCCCCCC),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: Dimensions.w(16),
                vertical: Dimensions.h(16),
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}