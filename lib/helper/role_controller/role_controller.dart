
// lib/core/role_controller.dart
import 'package:shared_preferences/shared_preferences.dart';

enum AppRole {CUSTOMER,  DRIVER }

class RoleController {
  static const _key = 'role'; // "user" | "provider"

  /// Save role (user/provider)
  Future<void> setRole(AppRole role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, role.name);
  }

  /// Convenience
  Future<void> setCustomer() => setRole(AppRole.CUSTOMER);
  Future<void> setDriver() => setRole(AppRole.DRIVER);

  /// Read role (null if not set)
  Future<AppRole?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    final v = prefs.getString(_key);
    if (v == null) return null;
    return AppRole.values.firstWhere((e) => e.name == v, orElse: () => AppRole.CUSTOMER);
  }

  /// Helpers
  Future<bool> isCustomer() async => (await getRole()) == AppRole.CUSTOMER;
  Future<bool> isDriver() async => (await getRole()) == AppRole.DRIVER;

  /// Clear (optional)
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}

