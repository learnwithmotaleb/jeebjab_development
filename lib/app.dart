
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/routes/route_path.dart';
import 'core/routes/routes.dart';
import 'core/theme/light_theme.dart';
import 'core/theme/dark_theme.dart';
import 'core/theme/theme_controller.dart';
import 'global/language/controller/language_controller.dart';
import 'helper/no_internet/screen/no_internet_screen.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key}) {
    Get.put(ThemeController(), permanent: true);
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final LanguageController lc = Get.put(LanguageController());


    return Obx(() {
      final themeMode = themeController.initialized
          ? themeController.mode.value
          : ThemeMode.system;

      Locale locale = lc.isEnglish.value
          ? const Locale('en', 'US')
          : const Locale('el', 'GR');


      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: themeMode,
        translations: Language(),
        locale: locale,
        fallbackLocale:  Locale('el', 'GR'),
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

