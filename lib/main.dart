import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:jeebjab/presentation/screen/job/delivery/controller/delivery_controller.dart';
import 'package:jeebjab/service/firebase_notification_service.dart';
import 'package:jeebjab/utils/device_preview/evice_preview_wrapper.dart';

import 'app.dart';
import 'core/device_utls/device_utils.dart';

import 'firebase_options.dart';
import 'global/language/controller/language_controller.dart';
import 'helper/local_db/local_db.dart';
import 'helper/no_internet/controller/no_internet_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize SharedPreferences first
  await SharePrefsHelper.init();
  // Initialize Push Notifications
  await FirebaseNotificationService().initialize();
  await FirebaseNotificationService().subscribeToDefaultTopics();

  // Print FCM Token explicitly
  final fcmToken = await FirebaseNotificationService().getFCMToken();
  debugPrint('📱 [FCM TOKEN] Current FCM Token: $fcmToken');
  
  // Initialize Google Sign-In (v7.x requirement)
  // NOTE: On Android, you MUST provide the serverClientId (Web Client ID) from Firebase Console.
  // Location: Firebase Console -> Project Settings -> General -> Web API Key/OAuth 2.0 Client IDs -> Web client
  await GoogleSignIn.instance.initialize(
    serverClientId: '27682003976-i01hmvr50dmefj44b4tgn4n3g5oo5ngg.apps.googleusercontent.com',
  );

  // Lock device orientation
  DeviceUtils.lockDevicePortrait();



  // Controllers
  Get.put(InternetController(), permanent: true);
  Get.put(LanguageController(), permanent: true);
  Get.put(DeliveryController(), permanent: true);



  runApp(
     MyApp()
  );
}

