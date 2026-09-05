import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/helper/tost_message/show_snackbar.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';

class IWillPayController extends GetxController {
  // Currency is app-wide SAR (AppStrings.currency) — kept as a plain numeric
  // field with the currency shown via the field's suffix, not baked into the text.
  final TextEditingController priceController = TextEditingController(text: '120');
  final RxInt price = 120.obs;

  // ── Suggested range from other users ────────────────────────────────────
  final int minSuggested = 60;
  final int maxSuggested = 100;

  String get currency => AppStrings.currency;

  @override
  void onInit() {
    super.onInit();
    priceController.addListener(_handlePriceChange);
  }

  void _handlePriceChange() {
    String text = priceController.text;

    // Extract only digits
    String numeric = text.replaceAll(RegExp(r'[^0-9]'), '');

    if (numeric != text) {
      priceController.value = TextEditingValue(
        text: numeric,
        selection: TextSelection.collapsed(offset: numeric.length),
      );
    }
    price.value = int.tryParse(numeric) ?? 0;
  }

  void increment() {
    price.value++;
    priceController.text = price.value.toString();
    _moveCursorToEnd();
  }

  void decrement() {
    if (price.value > 1) {
      price.value--;
      priceController.text = price.value.toString();
      _moveCursorToEnd();
    }
  }

  void _moveCursorToEnd() {
    priceController.selection = TextSelection.fromPosition(
      TextPosition(offset: priceController.text.length),
    );
  }

  void onVoucherTap() {
    // TODO: Navigate to voucher / campaign screen
  }

  bool get isValid => price.value > 0;

  void onContinue() {
    if (!isValid) {
      AppSnackBar.fail("Please enter a valid price.", title: "Required");
      return;
    }
    
    final bool isEditMode = Get.arguments?['isEdit'] ?? false;
    
    if (isEditMode) {
      Get.back();
    } else {
      Get.toNamed(RoutePath.addCard);
    }
  }

  void onSaveAndPublish() {
    if (!isValid) {
      AppSnackBar.fail("Please enter a valid price.", title: "Required");
      return;
    }
    Get.back(result: true);
  }

  @override
  void onClose() {
    priceController.dispose();
    super.onClose();
  }
}
