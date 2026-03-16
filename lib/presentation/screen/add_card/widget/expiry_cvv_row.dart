import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/presentation/screen/add_card/controller/add_card_controller.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';

class ExpiryCvvRow extends StatelessWidget {
  final TextEditingController expireController;
  final TextEditingController cvvController;

  const ExpiryCvvRow({
    super.key,
    required this.expireController,
    required this.cvvController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // ── Expiry ────────────────────────────────────────────────────
        Expanded(
          child: _CardSubField(
            label: 'Expire',
            controller: expireController,
            hint: 'MM/YY',
            keyboardType: TextInputType.number,
            formatters: [
              FilteringTextInputFormatter.digitsOnly,
              ExpiryInputFormatter(),
            ],
            maxLength: 5,
          ),
        ),

        SizedBox(width: Dimensions.w(16)),

        // ── CVV ───────────────────────────────────────────────────────
        Expanded(
          child: _CardSubField(
            label: 'CVV',
            controller: cvvController,
            hint: '• • •',
            keyboardType: TextInputType.number,
            obscureText: true,
            formatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(3),
            ],
            maxLength: 3,
          ),
        ),
      ],
    );
  }
}

class _CardSubField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;
  final bool obscureText;
  final List<TextInputFormatter> formatters;
  final int maxLength;

  const _CardSubField({
    required this.label,
    required this.controller,
    required this.hint,
    required this.keyboardType,
    this.obscureText = false,
    required this.formatters,
    required this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
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
            keyboardType: keyboardType,
            obscureText: obscureText,
            inputFormatters: formatters,
            style: TextStyle(
              fontSize: Dimensions.f(16),
              fontWeight: FontWeight.w600,
              letterSpacing: obscureText ? 4 : 1,
              color: AppColors.labelColor,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                fontSize: Dimensions.f(16),
                letterSpacing: obscureText ? 4 : 1,
                color: const Color(0xFFCCCCCC),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: Dimensions.w(16),
                vertical: Dimensions.h(16),
              ),
              border: InputBorder.none,
              counterText: '',
            ),
          ),
        ),
      ],
    );
  }
}