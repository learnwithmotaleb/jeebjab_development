import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IWillPayController extends GetxController {
  final TextEditingController priceController = TextEditingController(text: '120');
  final RxInt price = 120.obs;

  // ── Suggested range from other users ────────────────────────────────────
  final int minSuggested = 60;
  final int maxSuggested = 100;

  @override
  void onInit() {
    super.onInit();
    priceController.addListener(() {
      final val = int.tryParse(priceController.text);
      if (val != null) price.value = val;
    });
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
    if (!isValid) return;
    // TODO: Navigate to next step with price
  }

  @override
  void onClose() {
    priceController.dispose();
    super.onClose();
  }
}