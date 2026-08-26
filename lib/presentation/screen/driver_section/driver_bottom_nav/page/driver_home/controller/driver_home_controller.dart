import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../core/routes/route_path.dart';
import '../../../../../../../service/api_service.dart';
import '../../../../../../../service/api_url.dart';
import '../../../../../profile/profile/model/user_model.dart';
import '../../../../../job/job_post/model/job_post_model.dart';
import '../../task/model/DriverTaskModel.dart';

class DriverHomeController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  final RxBool isLoading = false.obs;

  // ── Header (from GET /driver/profile) ───────────────────────────────────
  final RxString name = ''.obs;
  final RxString avatarUrl = ''.obs; // empty = show placeholder asset
  final RxDouble rating = 0.0.obs;
  final RxInt completedJobs = 0.obs;

  // No earnings/payout endpoint exists yet — kept at 0 until the backend
  // exposes one. Do not wire this to a guessed URL.
  final RxDouble totalEarn = 0.0.obs;

  // ── Activity Summary Period Selection ───────────────────────────────────
  final RxString activityPeriod = 'Weekly'.obs;
  final List<String> periodOptions = ['Weekly', 'Monthly'];

  // ── Current Tasks (GET /driver/tasks?status=active) ─────────────────────
  final RxList<Task> currentTasks = <Task>[].obs;

  // ── Recent Jobs (GET /post, same feed as the Jobs tab) ───────────────────
  final RxList<PostItem> recentJobs = <PostItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadHomeData();
  }

  Future<void> loadHomeData() async {
    isLoading.value = true;
    await Future.wait([
      _loadProfile(),
      _loadCurrentTasks(),
      _loadRecentJobs(),
    ]);
    isLoading.value = false;
  }

  Future<void> _loadProfile() async {
    try {
      final response = await _apiClient.get(
        url: ApiUrl.getDriverProfile,
        isToken: true,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final user = UserModel.fromJson(response.body);
        name.value = user.name;
        avatarUrl.value = user.avatarUrl ?? '';
        rating.value = user.driverProfile?.averageRating ?? 0.0;
        completedJobs.value = user.driverProfile?.totalDeliveries ?? 0;
      }
    } catch (e) {
      debugPrint('Error loading driver profile for home: $e');
    }
  }

  Future<void> _loadCurrentTasks() async {
    try {
      final response = await _apiClient.get(
        url: ApiUrl.getActiveTasks,
        isToken: true,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final model = DriverTaskModel.fromJson(response.body);
        // Home only has room for a couple — show the most recent ones.
        currentTasks.assignAll((model.data?.tasks ?? []).take(3));
      }
    } catch (e) {
      debugPrint('Error loading current tasks for home: $e');
    }
  }

  Future<void> _loadRecentJobs() async {
    try {
      final url = Uri.parse(ApiUrl.getJobPost)
          .replace(queryParameters: {'sort': 'nearest', 'limit': '4'})
          .toString();
      final response = await _apiClient.get(url: url, isToken: true);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final model = JobPostModel.fromJson(
          response.body is Map<String, dynamic>
              ? response.body as Map<String, dynamic>
              : {},
        );
        recentJobs.assignAll(model.data?.posts ?? []);
      }
    } catch (e) {
      debugPrint('Error loading recent jobs for home: $e');
    }
  }

  // ── Change Activity Period ──────────────────────────────────────────────
  void setActivityPeriod(String period) {
    activityPeriod.value = period;
    // TODO: Fetch stats for the selected period once a stats endpoint exists.
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
