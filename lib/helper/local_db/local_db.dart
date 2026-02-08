import 'package:flutter/material.dart';
import 'package:jeebjab/helper/local_db/shareprefs_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharePrefsHelper {
  static SharedPreferences? _prefs;

  // Initialize once in main()
  static Future init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // ----------------- General Setters -----------------

  static Future<void> setBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  static bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  static Future<void> setString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  static String? getString(String key) {
    return _prefs?.getString(key);
  }

  // ----------------- Theme Mode -----------------

  static const String _themeKey = 'theme_mode';

  static ThemeMode getThemeMode() {
    switch (_prefs?.getString(_themeKey)) {
      case 'light': return ThemeMode.light;
      case 'dark':  return ThemeMode.dark;
      default:      return ThemeMode.system;
    }
  }


  static Future<void> saveThemeMode(ThemeMode mode) async {
    final value = mode == ThemeMode.light
        ? 'light'
        : mode == ThemeMode.dark
        ? 'dark'
        : 'system';

    await _prefs?.setString(_themeKey, value);
  }

  // ----------------- Role -----------------

  static Future<void> saveRole(String value) async {
    await _prefs?.setString(SharePrefsKeys.role, value);
  }

  static String? getRole() {
    return _prefs?.getString(SharePrefsKeys.role);
  }

  // ----------------- Token -----------------

  static Future<void> saveToken(String token) async {
    await _prefs?.setString(SharePrefsKeys.token, token);
  }

  static String? getToken() {
    return _prefs?.getString(SharePrefsKeys.token);
  }

  // ----------------- User ID -----------------

  static Future<void> saveUserId(String id) async {
    await _prefs?.setString(SharePrefsKeys.userId, id);
  }

  static String? getUserId() {
    return _prefs?.getString(SharePrefsKeys.userId);
  }




  // ----------------- Profile ID -----------------

  static Future<void> saveProfileId(String profileId) async {
    await _prefs?.setString(SharePrefsKeys.profileId, profileId);
  }

  static String? getProfileId() {
    return _prefs?.getString(SharePrefsKeys.profileId);
  }

  // ----------------- Onboard Seen -----------------

  static Future<void> setOnboardSeen(bool value) async {
    await _prefs?.setBool(SharePrefsKeys.onboardSeen, value);
  }

  static bool getOnboardSeen() {
    return _prefs?.getBool(SharePrefsKeys.onboardSeen) ?? false;
  }



  // ----------------- Clear All -----------------
  static Future<void> clearAll() async {
    await _prefs?.clear();
  }
}
