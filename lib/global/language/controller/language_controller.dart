import 'dart:ui';
import 'package:get/get.dart';
import '../../../helper/local_db/local_db.dart';
import '../../../utils/app_const/app_const.dart';

class LanguageController extends GetxController {

  // Reactive Locale
  Rx<Locale> currentLocale = const Locale("en", "US").obs;

  @override
  void onInit() {
    super.onInit();
    loadLanguage();
  }

  /// Load saved language from SharedPrefs
  void loadLanguage() {
    final isEnglish = SharePrefsHelper.getBool(AppConstants.languageKey) ?? true;

    currentLocale.value = isEnglish ? const Locale("en", "US") : const Locale("ar", "SA");

    // Update app locale
    Get.updateLocale(currentLocale.value);
  }

  /// Switch language dynamically
  Future<void> switchLanguage(bool englishSelected) async {
    currentLocale.value = englishSelected ? const Locale("en", "US") : const Locale("ar", "SA");

    // Update app locale immediately
    Get.updateLocale(currentLocale.value);

    // Save choice in SharedPrefs
    await SharePrefsHelper.setBool(AppConstants.languageKey, englishSelected);
  }

  /// Convenience getter
  bool get isEnglish => currentLocale.value.languageCode == "en";
}