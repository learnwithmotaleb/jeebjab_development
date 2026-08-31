import '../local_db/local_db.dart';
import '../../service/api_service.dart';
import '../../service/api_url.dart';

/// After a successful login/registration, fetches the full profile once
/// and persists the fields later screens rely on to tell user-mode from
/// driver-mode — `authId.role` returned at login always stays "USER"
/// (becoming a driver is a separate approved request, not a role
/// change), so `activeMode` from GET /user/user-profile is the real
/// signal for which mode the app should present.
class SessionSyncHelper {
  SessionSyncHelper._();

  static Future<void> syncActiveMode(ApiClient apiClient) async {
    try {
      final response = await apiClient.get(
        url: ApiUrl.getUserProfile,
        isToken: true,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.body['data'];
        final mode = data?['activeMode']?.toString();
        if (mode != null && mode.isNotEmpty) {
          await SharePrefsHelper.saveActiveMode(mode);
        }
      }
    } catch (_) {
      // Non-fatal — screens fall back to the cached/default mode.
    }
  }
}
