import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jeebjab/presentation/screen/job/delivery/controller/delivery_controller.dart';
import 'package:jeebjab/service/firebase_notification_service.dart';
import 'package:jeebjab/service/google_map_services.dart';
import 'package:jeebjab/service/socket_service.dart';
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
    await SocketApi.init();

    await FirebaseNotificationService().initialize();

    String? fcmToken = await FirebaseNotificationService().getFCMToken();
    if (fcmToken != null) {
      await SharePrefsHelper.saveFcmToken(fcmToken);
      debugPrint("FCM token explicitly saved in main.dart: $fcmToken");
    }

    await GoogleSignIn.instance.initialize(
      serverClientId:
          '642681024764-iibeam5g8vtduael2uisiu14uf7qi25s.apps.googleusercontent.com',
    );

    DeviceUtils.lockDevicePortrait();
  } catch (e) {
    debugPrint('Startup Error: $e');
  }

  // ── Request location permission (geolocator built-in dialog) ──
  await _requestLocationPermission();

  // MUST be outside try-catch
  Get.put(InternetController(), permanent: true);
  Get.put(LanguageController(), permanent: true);
  Get.put(DeliveryController(), permanent: true);
  // Location permission is already granted above before this runs
  Get.put(GoogleMapServices(), permanent: true);
  runApp(MyApp());

  Future.delayed(const Duration(seconds: 5), () async {
    try {
      await FirebaseNotificationService().subscribeToDefaultTopics();
    } catch (e) {
      debugPrint('Topic subscription skipped: $e');
    }
  });
}

/// Requests location permission using geolocator's native dialog.
/// Notification permission is handled internally by the notification package.
Future<void> _requestLocationPermission() async {
  LocationPermission permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }

  if (permission == LocationPermission.deniedForever) {
    // Opens device App Settings so user can enable manually
    await Geolocator.openAppSettings();
  }
}
