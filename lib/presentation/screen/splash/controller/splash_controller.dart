import 'package:get/get.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/helper/local_db/local_db.dart';
import 'package:jeebjab/helper/auth/session_sync_helper.dart';
import 'package:jeebjab/service/api_service.dart';

class SplashController extends GetxController {
  final ApiClient _apiClient = ApiClient();

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
      // Logged in — route by the real activeMode ("user"/"driver"), not
      // the local `role` cache: authId.role always stays "USER" on the
      // backend (becoming a driver is a separate approved request, not
      // a role change), and `role` can also be left stale at "DRIVER"
      // locally from the driver-signup flow's local-only UI selection.
      // Refresh activeMode from the server before deciding.
      await SessionSyncHelper.syncActiveMode(_apiClient);

      if (SharePrefsHelper.isDriverMode) {
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
