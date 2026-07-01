import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../helper/local_db/local_db.dart';
import '../model/notification_model.dart';
import '../../../../service/api_url.dart';
import '../../../../service/api_service.dart';
import '../../../../helper/tost_message/show_snackbar.dart';

class NotificationController extends GetxController {
  static NotificationController get to => Get.find();

  RxList<Map<String, dynamic>> localNotificationList =
      <Map<String, dynamic>>[].obs;
  RxBool isLoadingNotificationList = false.obs;

  int currentPage = 1;
  bool isMoreDataAvailable = true;
  bool isLoadMore = false;

  @override
  void onInit() {
    getNotificationRequest();
    super.onInit();
  }

  /// Load all local notifications from SharedPreferences
  void loadLocalNotifications() {
    try {
      final existingJson = SharePrefsHelper.getLocalNotifications();
      final list = existingJson
          .map((e) => jsonDecode(e) as Map<String, dynamic>)
          .toList();

      // Sort by createdAt descending
      list.sort((a, b) {
        final dateA = a['createdAt'] ?? '';
        final dateB = b['createdAt'] ?? '';
        return dateB.compareTo(dateA);
      });

      localNotificationList.assignAll(list);
      debugPrint(
        '🔔 NotificationController: Loaded ${localNotificationList.length} local notifications',
      );
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
      final list = existingJson
          .map((e) => jsonDecode(e) as Map<String, dynamic>)
          .toList();

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
      final list = existingJson
          .map((e) => jsonDecode(e) as Map<String, dynamic>)
          .toList();

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
      final response = await ApiClient().delete(
        url: ApiUrl.deleteSingeNotification(id),
        isToken: true,
      );

      if (response.statusCode == 200) {
        // Remove from UI list
        localNotificationList.removeWhere((e) => e['_id'] == id);

        // Remove from local storage
        final existingJson = SharePrefsHelper.getLocalNotifications();
        final list = existingJson
            .map((e) => jsonDecode(e) as Map<String, dynamic>)
            .toList();
        list.removeWhere((e) => e['_id'] == id);
        final updatedJsonList = list.map((e) => jsonEncode(e)).toList();
        await SharePrefsHelper.saveLocalNotifications(updatedJsonList);

        AppSnackBar.success(
          'Notification deleted successfully.',
          title: 'Deleted',
        );
      } else {
        AppSnackBar.error(
          'Failed to delete notification: ${response.body['message'] ?? 'Error'}',
        );
      }
    } catch (e) {
      debugPrint('❌ Error deleting notification: $e');
      AppSnackBar.error('Error deleting notification');
    }
  }

  /// Clear all local notifications
  Future<void> clearAllLocalNotifications() async {
    try {
      final response = await ApiClient().delete(
        url: ApiUrl.deleteAllNotification,
        isToken: true,
      );

      if (response.statusCode == 200) {
        await SharePrefsHelper.clearLocalNotifications();
        localNotificationList.clear();
        AppSnackBar.success('All notifications cleared.', title: 'Cleared');
      } else {
        AppSnackBar.error(
          'Failed to clear notifications: ${response.body['message'] ?? 'Error'}',
        );
      }
    } catch (e) {
      debugPrint('❌ Error clearing local notifications: $e');
      AppSnackBar.error('Error clearing notifications');
    }
  }

  /// Fetch notifications from Server with pagination
  Future<void> getNotificationRequest({bool isLoadMore = false}) async {
    if (isLoadMore) {
      if (!isMoreDataAvailable || this.isLoadMore) return;
      this.isLoadMore = true;
      currentPage++;
    } else {
      isLoadingNotificationList.value = true;
      currentPage = 1;
      isMoreDataAvailable = true;
    }

    try {
      final response = await ApiClient().get(
        url: ApiUrl.notifications(page: currentPage, limit: 10),
        isToken: true,
      );
      if (response.statusCode == 200) {
        // Parse the response into model
        final model = NotificationsModel.fromJson(response.body);
        final remoteList =
            model.data?.notifications?.map((e) => e.toJson()).toList() ?? [];

        if (isLoadMore) {
          localNotificationList.addAll(remoteList);
        } else {
          localNotificationList.assignAll(remoteList);
        }

        final totalPage = model.data?.meta?.totalPage ?? 1;
        if (currentPage >= totalPage) {
          isMoreDataAvailable = false;
        }

        // Optionally save to local storage for offline use
        final encodedList = localNotificationList
            .map((e) => jsonEncode(e))
            .toList();
        await SharePrefsHelper.saveLocalNotifications(encodedList);
      } else {
        AppSnackBar.error(
          'Failed to load notifications: ${response.body['message'] ?? 'Error'}',
        );
      }
    } catch (e) {
      debugPrint('Error fetching notifications: $e');
      if (!isLoadMore) AppSnackBar.error('Error fetching notifications');
    } finally {
      if (isLoadMore) {
        this.isLoadMore = false;
      } else {
        isLoadingNotificationList.value = false;
      }
    }
  }
}
