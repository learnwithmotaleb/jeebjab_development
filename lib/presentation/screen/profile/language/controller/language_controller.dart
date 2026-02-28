import 'package:get/get.dart';
import '../../../../../global/language/controller/language_controller.dart';

class ProfileLanguageController extends GetxController {
  static ProfileLanguageController get to => Get.find();

  // Mirrors the global controller's current selection
  final RxString selectedLanguage = 'en'.obs;

  final LanguageController _languageController = Get.find<LanguageController>();

  @override
  void onInit() {
    super.onInit();
    // Load whatever language is currently active
    selectedLanguage.value =
    _languageController.isEnglish ? 'en' : 'ar';
  }

  /// Called from UI when user taps a language row
  void changeLanguage(String value) {
    selectedLanguage.value = value;
  }

  /// Called when user presses "Change Language" button
  Future<void> applyLanguage() async {
    await _languageController.switchLanguage(selectedLanguage.value == 'en');
  }
}