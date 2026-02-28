import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app.dart';
import 'global/language/controller/language_controller.dart';
import 'helper/device_utils/device_utils.dart';
import 'helper/local_db/local_db.dart';
import 'helper/no_internet/controller/no_internet_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences first
  await SharePrefsHelper.init();

  // Lock device orientation
  DeviceUtils.lockDevicePortrait();


  Get.put(InternetController(), permanent: true);
  Get.put(LanguageController(), permanent: true); //

  runApp(MyApp());
}