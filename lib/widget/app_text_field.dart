import 'package:flutter/material.dart';
import '../../utils/app_colors/app_colors.dart';
import '../utils/app_text_style/app_text_style.dart';
import '../../core/responsive_layout/dimensions.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final String? label;
  final String? hint;
  final TextStyle? hintTextStyle;
  final String? helper;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final int maxLines;
  final bool obscure;
  final double? radius;
  final Color? borderColor;
  final Widget? prefixIcon;
  final VoidCallback? onTap;
  final bool readOnly;
  final VoidCallback? onSubmitted;

  const AppTextField({
    super.key,
    required this.controller,
    this.focusNode,
    this.nextFocus,
    this.label,
    this.hint,
    this.helper,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.maxLines = 1,
    this.obscure = false,
    this.prefixIcon,
    this.radius,
    this.borderColor,
    this.onTap,
    this.readOnly = false,
    this.onSubmitted, this.hintTextStyle,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscure;
  }

  void _toggleObscure() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType,
      maxLines: _obscureText ? 1 : widget.maxLines,
      obscureText: _obscureText,
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      textInputAction:
      widget.nextFocus != null ? TextInputAction.next : TextInputAction.done,
      onFieldSubmitted: (_) {
        if (widget.nextFocus != null) {
          FocusScope.of(context).requestFocus(widget.nextFocus);
        } else {
          if (widget.onSubmitted != null) widget.onSubmitted!();
        }
      },
      decoration: InputDecoration(
        labelText: widget.label,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.obscure
            ? IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: AppColors.greyColor,
          ),
          onPressed: _toggleObscure,
        )
            : null,
        hintText: widget.hint,
        hintStyle: widget.hintTextStyle ??
            AppTextStyles.hint.copyWith(fontSize: Dimensions.f(14)),
        helperText: widget.helper,
        fillColor: AppColors.textFieldBackgroundColor,
        contentPadding: EdgeInsets.all(Dimensions.h(16)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius ?? Dimensions.r(16)),
          borderSide: BorderSide(
            color: widget.borderColor ?? AppColors.textFieldBackgroundColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius ?? Dimensions.r(16)),
          borderSide: BorderSide(
            color: widget.borderColor ?? AppColors.primaryColor,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius ?? Dimensions.r(16)),
          borderSide: BorderSide(
            color: widget.borderColor ?? AppColors.textFieldBackgroundColor,
          ),
        ),
      ),
      validator: widget.validator,
    );
  }
}
