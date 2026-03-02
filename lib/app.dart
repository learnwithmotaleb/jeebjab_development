import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import 'core/routes/route_path.dart';
import 'core/routes/routes.dart';
import 'core/theme/dark_theme.dart';
import 'core/theme/light_theme.dart';
import 'core/theme/theme_controller.dart';
import 'global/language/controller/language_controller.dart';
import 'global/language/languages.dart';
import 'helper/no_internet/screen/no_internet_screen.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key}) {
    Get.put(ThemeController(), permanent: true);
    // ← Remove: Get.put(LanguageController(), permanent: true);
    //   It's already created in main.dart, use Get.find() instead
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final lc = Get.find<LanguageController>(); // ← find, not put

    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: themeController.initialized
            ? themeController.mode.value
            : ThemeMode.system,
        translations: Language(),
        locale: lc.currentLocale.value,
        fallbackLocale: const Locale('en', 'US'),
        getPages: AppRouter.pages,
        initialRoute: RoutePath.splash,
        builder: (context, child) {
          return Directionality(
            textDirection: lc.isEnglish ? TextDirection.ltr : TextDirection.rtl,
            child: InternetWrapper(child: child ?? const SizedBox()),
          );
        },
      );
    });
  }
}