import 'dart:ui';

import 'package:get/get.dart';

class ProfileLanguageController extends GetxController {
  static ProfileLanguageController get to => Get.find();

  // ── Selected language code ────────────────────────────────────────────────
  final RxString selectedLanguage = ''.obs;

  // ── Is English flag ───────────────────────────────────────────────────────
  final RxBool isEnglish = true.obs;

  @override
  void onInit() {
    super.onInit();
    // Default to English
    selectedLanguage.value = isEnglish.value ? 'en' : 'el';
  }

  // ── Switch app locale ─────────────────────────────────────────────────────
  void switchLanguage(bool toEnglish) {
    isEnglish.value = toEnglish;
    if (toEnglish) {
      Get.updateLocale(const Locale('en', 'US'));
    } else {
      Get.updateLocale(const Locale('el', 'GR')); // Greek / Arabic
    }
  }

  // ── Change language (called from UI) ──────────────────────────────────────
  void changeLanguage(String value) {
    selectedLanguage.value = value;
    switchLanguage(value == 'en');
  }
}