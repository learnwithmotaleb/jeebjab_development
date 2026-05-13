import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/helper/tost_message/show_snackbar.dart';

class AddCardController extends GetxController {
  // ── Text Controllers ──────────────────────────────────────────────────────
  final TextEditingController cardHolderNameController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expireController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  // ── Reactive display values ───────────────────────────────────────────────
  final RxString cardDisplay = '4084  4084  4084  4084'.obs;
  final RxBool isValid = false.obs;

  @override
  void onInit() {
    super.onInit();
    cardNumberController.addListener(_validateForm);
    expireController.addListener(_validateForm);
    cvvController.addListener(_validateForm);
  }

  void _validateForm() {
    final cardRaw = cardNumberController.text.replaceAll(' ', '');
    isValid.value = cardRaw.length == 16 &&
        expireController.text.length == 5 &&
        cvvController.text.length == 3;
  }

  void onAddCard() {
    if (!isValid.value) {
      if (cardNumberController.text.replaceAll(' ', '').length < 16) {
        AppSnackBar.fail("Please enter a valid 16-digit card number.", title: "Required");
      } else if (expireController.text.length < 5) {
        AppSnackBar.fail("Please enter a valid expiry date (MM/YY).", title: "Required");
      } else if (cvvController.text.length < 3) {
        AppSnackBar.fail("Please enter a valid 3-digit CVV.", title: "Required");
      }
      return;
    }

    Get.toNamed(RoutePath.overview);
  }

  void onSaveAndPublish() {
    if (!isValid.value) {
      AppSnackBar.fail("Please enter valid card details.", title: "Required");
      return;
    }
    Get.back(result: true);
  }

  @override
  void onClose() {
    cardNumberController.dispose();
    expireController.dispose();
    cvvController.dispose();
    super.onClose();
  }
}

// ── Card Number Formatter (4 groups of 4) ────────────────────────────────────
class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');
    final limited = digitsOnly.length > 16
        ? digitsOnly.substring(0, 16)
        : digitsOnly;
    final buffer = StringBuffer();
    for (int i = 0; i < limited.length; i++) {
      if (i > 0 && i % 4 == 0) buffer.write('  ');
      buffer.write(limited[i]);
    }
    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

// ── Expiry Formatter MM/YY ────────────────────────────────────────────────────
class ExpiryInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');
    final limited =
    digitsOnly.length > 4 ? digitsOnly.substring(0, 4) : digitsOnly;
    final buffer = StringBuffer();
    for (int i = 0; i < limited.length; i++) {
      if (i == 2) buffer.write('/');
      buffer.write(limited[i]);
    }
    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}