import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/routes/route_path.dart';
import 'core/routes/routes.dart';
import 'core/theme/light_theme.dart';
import 'core/theme/dark_theme.dart';
import 'core/theme/theme_controller.dart';
import 'global/language/controller/language_controller.dart';
import 'global/language/languages.dart';
import 'helper/no_internet/screen/no_internet_screen.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key}) {
    // Permanent Controllers
    Get.put(ThemeController(), permanent: true);
    Get.put(LanguageController(), permanent: true);
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final lc = Get.find<LanguageController>();

    return Obx(() {
      // Reactive theme mode
      final themeMode = themeController.initialized
          ? themeController.mode.value
          : ThemeMode.system;

      // Reactive locale
      final locale = lc.currentLocale.value;

      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: themeMode,
        translations: Language(),     // <-- Must be Translations class
        locale: locale,               // <-- Reactive locale from controller
        fallbackLocale: const Locale('en', 'US'),
        getPages: AppRouter.pages,
        initialRoute: RoutePath.splash,
        builder: (context, child) {
          return InternetWrapper(
            child: child ?? const SizedBox(),
          );
        },
      );
    });
  }
}