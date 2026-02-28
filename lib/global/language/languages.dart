import 'package:get/get.dart';
import 'eng/eng.dart';
import 'arabic/arabic.dart'; // Replace greek → arabic

class Language extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': english,
    'ar_SA': arabic,
  };
}