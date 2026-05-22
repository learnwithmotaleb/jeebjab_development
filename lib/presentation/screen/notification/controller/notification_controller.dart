import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../helper/local_db/local_db.dart';
import '../../../../service/api_service.dart';
import '../../../../helper/tost_message/show_snackbar.dart';

class NotificationController extends GetxController {
  static NotificationController get to => Get.find();

  RxList<Map<String, dynamic>> localNotificationList = <Map<String, dynamic>>[].obs;
  RxBool isLoadingNotificationList = false.obs;

  @override
  void onInit() {
    loadLocalNotifications();
    super.onInit();
  }

  /// Load all local notifications from SharedPreferences
  void loadLocalNotifications() {
    try {
      final existingJson = SharePrefsHelper.getLocalNotifications();
      final list = existingJson.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();

      // Sort by createdAt descending
      list.sort((a, b) {
        final dateA = a['createdAt'] ?? '';
        final dateB = b['createdAt'] ?? '';
        return dateB.compareTo(dateA);
      });

      localNotificationList.assignAll(list);
      debugPrint('🔔 NotificationController: Loaded ${localNotificationList.length} local notifications');
    } catch (e) {
      debugPrint('❌ Error loading local notifications: $e');
    }
  }

  /// Add a notification locally (e.g. manually triggered or from push notification)
  Future<void> addNotificationLocally({
    required String id,
    required String title,
    required String body,
    String? type,
    String? subtitle,
    String? imagePath,
    Map<String, dynamic>? data,
  }) async {
    try {
      final notificationMap = {
        '_id': id,
        'title': title,
        'message': body,
        'createdAt': DateTime.now().toIso8601String(),
        'type': type ?? 'general',
        'subtitle': subtitle ?? 'General',
        'imagePath': imagePath ?? '',
        'isRead': false,
        'data': data ?? {},
      };

      final existingJson = SharePrefsHelper.getLocalNotifications();
      final list = existingJson.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();

      // Prevent duplicate ID
      list.removeWhere((e) => e['_id'] == id);
      list.insert(0, notificationMap);

      // Keep only last 100
      if (list.length > 100) {
        list.removeRange(100, list.length);
      }

      final updatedJsonList = list.map((e) => jsonEncode(e)).toList();
      await SharePrefsHelper.saveLocalNotifications(updatedJsonList);
      loadLocalNotifications();
    } catch (e) {
      debugPrint('❌ Error adding local notification: $e');
    }
  }

  /// Mark a notification as read
  Future<void> markAsRead(String id) async {
    try {
      final existingJson = SharePrefsHelper.getLocalNotifications();
      final list = existingJson.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();

      bool found = false;
      for (var i = 0; i < list.length; i++) {
        if (list[i]['_id'] == id) {
          list[i]['isRead'] = true;
          found = true;
          break;
        }
      }

      if (found) {
        final updatedJsonList = list.map((e) => jsonEncode(e)).toList();
        await SharePrefsHelper.saveLocalNotifications(updatedJsonList);
        loadLocalNotifications();
      }
    } catch (e) {
      debugPrint('❌ Error marking notification as read: $e');
    }
  }

  /// Delete a specific notification by ID
  Future<void> deleteNotification(String id) async {
    try {
      final existingJson = SharePrefsHelper.getLocalNotifications();
      final list = existingJson.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();

      list.removeWhere((e) => e['_id'] == id);

      final updatedJsonList = list.map((e) => jsonEncode(e)).toList();
      await SharePrefsHelper.saveLocalNotifications(updatedJsonList);
      loadLocalNotifications();
      AppSnackBar.success('Notification deleted successfully.', title: 'Deleted');
    } catch (e) {
      debugPrint('❌ Error deleting notification: $e');
    }
  }

  /// Clear all local notifications
  Future<void> clearAllLocalNotifications() async {
    try {
      await SharePrefsHelper.clearLocalNotifications();
      localNotificationList.clear();
      AppSnackBar.success('All notifications cleared.', title: 'Cleared');
    } catch (e) {
      debugPrint('❌ Error clearing local notifications: $e');
    }
  }

  /// Optional: Get notifications from Server (placeholder / fallback)
  Future<void> getNotificationRequest() async {
    // If backend doesn't have an endpoint, we catch gracefully and load local ones
    try {
      isLoadingNotificationList.value = true;
      // In a real application, you can query a backend endpoint like:
      // final response = await ApiClient().get(url: ApiUrl.notifications, isToken: true);
      // but since there's no configured server endpoint for notification lists,
      // we gracefully load local storage notifications and print a message.
      loadLocalNotifications();
      isLoadingNotificationList.value = false;
    } catch (e) {
      debugPrint('❌ Error getting notifications from server: $e');
      isLoadingNotificationList.value = false;
    }
  }
}
