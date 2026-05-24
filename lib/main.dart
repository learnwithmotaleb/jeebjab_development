import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jeebjab/presentation/screen/job/delivery/controller/delivery_controller.dart';
import 'package:jeebjab/service/firebase_notification_service.dart';

import 'app.dart';
import 'core/device_utls/device_utils.dart';
import 'firebase_options.dart';
import 'global/language/controller/language_controller.dart';
import 'helper/local_db/local_db.dart';
import 'helper/no_internet/controller/no_internet_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await SharePrefsHelper.init();

    await FirebaseNotificationService().initialize();

    await GoogleSignIn.instance.initialize(
      serverClientId:
      '27682003976-i01hmvr50dmefj44b4tgn4n3g5oo5ngg.apps.googleusercontent.com',
    );

    DeviceUtils.lockDevicePortrait();

  } catch (e) {
    debugPrint('Startup Error: $e');
  }

  // MUST be outside try-catch
  Get.put(InternetController(), permanent: true);
  Get.put(LanguageController(), permanent: true);
  Get.put(DeliveryController(), permanent: true);

  runApp(MyApp());

  Future.delayed(const Duration(seconds: 5), () async {
    try {
      await FirebaseNotificationService()
          .subscribeToDefaultTopics();
    } catch (e) {
      debugPrint('Topic subscription skipped: $e');
    }
  });
}