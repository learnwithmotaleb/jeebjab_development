import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'app.dart';
import 'global/language/controller/language_controller.dart';
import 'helper/device_utils/device_utils.dart';
import 'helper/local_db/local_db.dart';
import 'helper/no_internet/controller/no_internet_controller.dart';
import 'helper/role_controller/role_controller.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  final LanguageController languageController = Get.put(LanguageController());
  await languageController.loadLanguage();

  DeviceUtils.lockDevicePortrait();

  Get.put(InternetController(), permanent: true);
  await SharePrefsHelper.init();


  runApp( MyApp());
}


