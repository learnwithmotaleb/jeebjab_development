import 'package:get/get.dart';
import 'package:jeebjab/core/enums/app_role.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/helper/local_db/local_db.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    // Wait for splash animation or duration
    await Future.delayed(const Duration(seconds: 3));

    // Check if token exists
    String? token = SharePrefsHelper.getToken();

    if (token != null && token.isNotEmpty) {
      // User is logged in, check role
      AppRole? role = SharePrefsHelper.getRole();

      if (role == AppRole.DRIVER) {
        Get.offAllNamed(RoutePath.driverBottomNav);
      } else {
        Get.offAllNamed(RoutePath.bottomNav);
      }
    } else {
      // No token, go to welcome or login
      Get.offAllNamed(RoutePath.login);
    }
  }
}