import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../helper/local_db/local_db.dart';
import '../model/notification_model.dart';
import '../../../../service/api_url.dart';
import '../../../../service/api_service.dart';
import '../../../../helper/tost_message/show_snackbar.dart';
import '../../../../core/routes/route_path.dart';
import '../../bottom_nav/page/my_post/model/my_post_model.dart';

class NotificationController extends GetxController {
  static NotificationController get to => Get.find();

  RxList<Map<String, dynamic>> localNotificationList =
      <Map<String, dynamic>>[].obs;
  RxBool isLoadingNotificationList = false.obs;
  RxInt unreadCount = 0.obs;

  int currentPage = 1;
  bool isMoreDataAvailable = true;
  bool isLoadMore = false;

  @override
  void onInit() {
    getNotificationRequest();
    fetchUnreadCount();
    super.onInit();
  }

  /// GET /notification/count — used for a badge indicator.
  Future<void> fetchUnreadCount() async {
    try {
      final response = await ApiClient().get(
        url: ApiUrl.unreadNotificationCount,
        isToken: true,
      );
      if (response.statusCode == 200) {
        unreadCount.value = (response.body['data']?['unreadCount'] ?? 0) as int;
      }
    } catch (e) {
      debugPrint('Error fetching unread notification count: $e');
    }
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

  /// Mark a notification as read — updates the in-memory/local list right
  /// away for a snappy UI, then syncs to the backend (PATCH /notification/:id/read).
  Future<void> markAsRead(String id) async {
    // Skip the round-trip if it's already read.
    final index = localNotificationList.indexWhere((e) => e['_id'] == id);
    if (index != -1 && localNotificationList[index]['isRead'] == true) return;

    _setLocalReadState(id, true);
    if (index != -1 && unreadCount.value > 0) unreadCount.value--;

    try {
      final response = await ApiClient().patch(
        url: ApiUrl.markNotificationAsRead(id),
        isToken: true,
      );
      if (response.statusCode != 200) {
        debugPrint('Failed to sync read status: ${response.body}');
      }
    } catch (e) {
      debugPrint('❌ Error marking notification as read: $e');
    }
  }

  /// Mark every notification as read (PATCH /notification/read-all).
  Future<void> markAllAsRead() async {
    if (unreadCount.value == 0 &&
        localNotificationList.every((e) => e['isRead'] == true)) {
      return;
    }
    try {
      final response = await ApiClient().patch(
        url: ApiUrl.markAllNotificationsAsRead,
        isToken: true,
      );
      if (response.statusCode == 200) {
        for (var i = 0; i < localNotificationList.length; i++) {
          localNotificationList[i] = {
            ...localNotificationList[i],
            'isRead': true,
          };
        }
        unreadCount.value = 0;

        final existingJson = SharePrefsHelper.getLocalNotifications();
        final list = existingJson
            .map((e) => jsonDecode(e) as Map<String, dynamic>)
            .toList();
        for (var i = 0; i < list.length; i++) {
          list[i]['isRead'] = true;
        }
        await SharePrefsHelper.saveLocalNotifications(
          list.map((e) => jsonEncode(e)).toList(),
        );

        AppSnackBar.success('All notifications marked as read.');
      } else {
        AppSnackBar.error(
          response.body['message'] ?? 'Failed to mark notifications as read',
        );
      }
    } catch (e) {
      debugPrint('❌ Error marking all notifications as read: $e');
      AppSnackBar.error('Error marking notifications as read');
    }
  }

  /// Update isRead for one notification in both the reactive list and
  /// SharedPreferences cache.
  void _setLocalReadState(String id, bool isRead) {
    final index = localNotificationList.indexWhere((e) => e['_id'] == id);
    if (index != -1) {
      localNotificationList[index] = {
        ...localNotificationList[index],
        'isRead': isRead,
      };
    }

    try {
      final existingJson = SharePrefsHelper.getLocalNotifications();
      final list = existingJson
          .map((e) => jsonDecode(e) as Map<String, dynamic>)
          .toList();
      final localIndex = list.indexWhere((e) => e['_id'] == id);
      if (localIndex != -1) {
        list[localIndex]['isRead'] = isRead;
        SharePrefsHelper.saveLocalNotifications(
          list.map((e) => jsonEncode(e)).toList(),
        );
      }
    } catch (e) {
      debugPrint('❌ Error updating local read state: $e');
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
        final index = localNotificationList.indexWhere((e) => e['_id'] == id);
        final wasUnread =
            index != -1 && localNotificationList[index]['isRead'] == false;
        if (wasUnread && unreadCount.value > 0) unreadCount.value--;

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
        unreadCount.value = 0;
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
        final serverUnread = model.data?.meta?.unreadCount;
        if (serverUnread != null) unreadCount.value = serverUnread.toInt();

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

  // ── Open the item a notification is about ────────────────────────────────
  //
  // STOPGAP: the backend notification payload carries no postId/status link
  // at all (confirmed live — only _id/toId/title/message/isRead/timestamps).
  // "New Job Request" messages are the one exception: they embed the job's
  // *title* in quotes, e.g. `soniaai wants to take your job "nice"`. This
  // extracts that title and matches it against the user's own posts to
  // resolve a real id, then opens Status Details with it.
  //
  // This is fragile by construction: if two of the user's posts share a
  // title, it opens the first match, which may be the wrong one; if the
  // title text ever changes shape server-side, extraction breaks silently.
  // It should be replaced the moment the backend adds a real postId field
  // to notifications.
  final RxBool isResolvingNotification = false.obs;

  Future<void> openRelatedItem(Map<String, dynamic> item) async {
    final title = (item['title'] ?? '').toString();
    final message = (item['message'] ?? '').toString();

    if (title != 'New Job Request') {
      AppSnackBar.info("This notification isn't linked to an item yet.");
      return;
    }

    final match = RegExp(r'"([^"]+)"').firstMatch(message);
    final jobTitle = match?.group(1)?.trim();
    if (jobTitle == null || jobTitle.isEmpty) {
      AppSnackBar.info("Couldn't work out which job this refers to.");
      return;
    }

    if (isResolvingNotification.value) return;
    isResolvingNotification.value = true;
    try {
      final responses = await Future.wait([
        ApiClient().get(url: ApiUrl.getPendingPosts, isToken: true),
        ApiClient().get(url: ApiUrl.getActivePosts, isToken: true),
        ApiClient().get(url: ApiUrl.getCompletedPosts, isToken: true),
      ]);

      PostModel? found;
      for (final response in responses) {
        if (response.statusCode != 200) continue;
        final List postsJson = response.body['data']['posts'] ?? [];
        for (final json in postsJson) {
          final post = PostModel.fromJson(json);
          if (post.title.trim().toLowerCase() == jobTitle.toLowerCase()) {
            found = post;
            break;
          }
        }
        if (found != null) break;
      }

      if (found != null) {
        Get.toNamed(
          RoutePath.statusDetails,
          arguments: {
            'id': found.id,
            'itemType': found.title,
            'itemSubtype': found.category,
            'itemDate': found.date,
            'status': found.status.value,
            'showAcceptButton': found.status == PostStatus.pending,
          },
        );
      } else {
        AppSnackBar.info('Could not find the related post "$jobTitle".');
      }
    } catch (e) {
      debugPrint('Error resolving notification target: $e');
      AppSnackBar.error('Could not open the related post.');
    } finally {
      isResolvingNotification.value = false;
    }
  }
}
