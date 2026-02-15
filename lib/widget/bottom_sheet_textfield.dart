import 'package:flutter/material.dart';
import '../presentation/screen/auth/company_driver_auth/select_company/widget/custom_bottom_selector.dart';

class BottomSheetTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final String? hint;
  final List<String> items;

  const BottomSheetTextField({
    Key? key,
    required this.controller,
    required this.label,
    required this.items, this.hint,
  }) : super(key: key);

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (_) {
        return CustomBottomSelector(
          title: label!,

          items: items,
          onSelect: (value) {
            controller.text = value;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: IconButton(
          icon: const Icon(Icons.arrow_drop_down),
          onPressed: () => _showBottomSheet(context),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
