import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../core/routes/route_path.dart';
import '../../../../../../../service/api_service.dart';
import '../../../../../../../service/api_url.dart';
import '../../../../../job/job_post/model/job_post_model.dart';
import '../../task/model/DriverTaskModel.dart';
import '../model/driver_home_model.dart';

class DriverHomeController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  final RxBool isLoading = false.obs;

  // ── Header (from GET /driver/home) ───────────────────────────────────
  final RxString name = ''.obs;
  final RxDouble rating = 0.0.obs;
  final RxInt completedJobs = 0.obs;
  final RxDouble totalEarn = 0.0.obs;

  // ── Avatar (GET /driver/home doesn't return one — kept from the
  // profile endpoint so the header still shows a picture) ────────────────
  final RxString avatarUrl = ''.obs; // empty = show placeholder asset

  // ── Extra dashboard fields (not shown in the UI yet, but real data) ────
  final RxString approvalStatus = ''.obs;
  final RxBool isAvailable = false.obs;
  final RxInt activeTasks = 0.obs;
  final RxInt pendingRequests = 0.obs;
  final RxInt totalDeliveries = 0.obs;

  // ── Activity Summary Period Selection — drives the `filter` query
  // param (weekly/monthly) that scopes completedTasks/totalEarnings.
  // Defaults to weekly, matching the API's own default.
  final RxString activityPeriod = 'Weekly'.obs;
  final List<String> periodOptions = ['Weekly', 'Monthly'];

  // ── Current Tasks (from GET /driver/home) ────────────────────────────
  final RxList<Task> currentTasks = <Task>[].obs;

  // ── Recent Jobs (from GET /driver/home) ──────────────────────────────
  final RxList<PostItem> recentJobs = <PostItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadHomeData();
  }

  Future<void> loadHomeData() async {
    isLoading.value = true;
    await Future.wait([_loadDashboard(), _loadAvatar()]);
    isLoading.value = false;
  }

  Future<void> _loadDashboard() async {
    try {
      final filter = activityPeriod.value.toLowerCase(); // weekly | monthly
      final url = Uri.parse(
        ApiUrl.getDriverHome(),
      ).replace(queryParameters: {'filter': filter}).toString();

      debugPrint('DriverHome: fetching $url');

      final response = await _apiClient.get(url: url, isToken: true);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final home = DriverHomeModel.fromJson(response.body);

        debugPrint(
          'DriverHome: filter=$filter completedTasks=${home.stats.completedTasks} '
          'totalEarnings=${home.stats.totalEarnings}',
        );

        approvalStatus.value = home.approvalStatus;
        isAvailable.value = home.isAvailable;

        activeTasks.value = home.stats.activeTasks;
        completedJobs.value = home.stats.completedTasks;
        pendingRequests.value = home.stats.pendingRequests;
        totalEarn.value = home.stats.totalEarnings;
        totalDeliveries.value = home.stats.totalDeliveries;

        name.value = home.user.name;
        rating.value = home.user.rating;

        currentTasks.assignAll(home.currentTasks.map(_toTask));
        recentJobs.assignAll(home.recentJobs.map(_toPostItem));
      } else {
        debugPrint(
          'DriverHome: request failed (${response.statusCode}) ${response.body}',
        );
      }
    } catch (e) {
      debugPrint('Error loading driver home dashboard: $e');
    }
  }

  // ── Adapters — the dashboard's lightweight task/job summaries are
  // reused as the same Task/PostItem models the existing cards already
  // render, just with the fields this endpoint doesn't provide left null
  // (both cards already guard those with isNotEmpty/null checks).
  Task _toTask(DriverHomeTaskItem item) => Task(
    id: item.id,
    title: item.title,
    price: item.price,
    photos: item.photos,
    pickup: item.pickupAddressText != null
        ? Pickup(address: Address(text: item.pickupAddressText))
        : null,
  );

  PostItem _toPostItem(DriverHomeTaskItem item) => PostItem(
    sId: item.id,
    title: item.title,
    price: item.price,
    photo: item.photos.isNotEmpty ? item.photos.first : null,
  );

  /// Avatar isn't part of the dashboard payload — pulled separately from
  /// the driver profile so the header still has a picture.
  Future<void> _loadAvatar() async {
    try {
      final response = await _apiClient.get(
        url: ApiUrl.getDriverProfile,
        isToken: true,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final avatar = response.body['data']?['avatar']?.toString();
        if (avatar != null && avatar.isNotEmpty) {
          avatarUrl.value = ApiUrl.buildImageUrl(avatar);
        }
      }
    } catch (e) {
      debugPrint('Error loading driver avatar for home: $e');
    }
  }

  // ── Change Activity Period ──────────────────────────────────────────────
  Future<void> setActivityPeriod(String period) async {
    if (activityPeriod.value == period) return;
    activityPeriod.value = period;
    isLoading.value = true;
    await _loadDashboard();
    isLoading.value = false;
  }

  // ── Task actions — real tasks only have active/completed at the API
  // level (no in-transit step), so both actions just open Task Details,
  // which already implements the documented completion flow.
  void onPickUpTap(Task task) {
    Get.toNamed(RoutePath.taskDetailsScreen, arguments: {'id': task.id});
  }

  void onOpenMap(Task task) {
    Get.toNamed(RoutePath.taskDetailsScreen, arguments: {'id': task.id});
  }

  void onRecentJobTap(PostItem job) {
    Get.toNamed(RoutePath.postDetails, arguments: {'id': job.sId});
  }
}
