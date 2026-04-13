import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/presentation/screen/job/delivery/controller/delivery_controller.dart';
import 'package:jeebjab/utils/device_preview/evice_preview_wrapper.dart';

import 'app.dart';
import 'core/device_utls/device_utils.dart';

import 'global/language/controller/language_controller.dart';
import 'helper/local_db/local_db.dart';
import 'helper/no_internet/controller/no_internet_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences first
  await SharePrefsHelper.init();

  // Lock device orientation
  DeviceUtils.lockDevicePortrait();

  // Controllers
  Get.put(InternetController(), permanent: true);
  Get.put(LanguageController(), permanent: true);
  Get.put(DeliveryController(), permanent: true);

  runApp(MyApp());
}

