import 'package:get/get.dart';
import 'package:jeebjab/service/api_service.dart';
import 'package:jeebjab/service/api_url.dart';

import '../../../../../../utils/static_strings/static_strings.dart';
import '../model/my_post_model.dart';

class MyPostController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  // ── State ─────────────────────────────────────────────────────────────────
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // ── Selected Tab ──────────────────────────────────────────────────────────
  final Rx<PostStatus> selectedTab = PostStatus.pending.obs;

  // ── All Posts ─────────────────────────────────────────────────────────────
  final RxList<PostModel> allPosts = <PostModel>[].obs;

  // ── Filtered Posts (reactive getter) ─────────────────────────────────────
  List<PostModel> get filteredPosts =>
      allPosts.where((p) => p.status == selectedTab.value).toList();

  // ── Count getters (useful for badges) ────────────────────────────────────
  int get pendingCount =>
      allPosts.where((p) => p.status == PostStatus.pending).length;
  int get activeCount =>
      allPosts.where((p) => p.status == PostStatus.active).length;
  int get completedCount =>
      allPosts.where((p) => p.status == PostStatus.completed).length;

  @override
  void onInit() {
    super.onInit();
    fetchMyPosts();
  }

  // ── Fetch from API ────────────────────────────────────────────────────────
  Future<void> fetchMyPosts() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Parallel fetch for all three statuses
      final responses = await Future.wait([
        _apiClient.get(url: ApiUrl.getPendingPosts, isToken: true),
        _apiClient.get(url: ApiUrl.getActivePosts, isToken: true),
        _apiClient.get(url: ApiUrl.getCompletedPosts, isToken: true),
      ]);

      final List<PostModel> combinedPosts = [];

      for (var response in responses) {
        if (response.statusCode == 200) {
          final List postsJson = response.body['data']['posts'] ?? [];
          combinedPosts.addAll(postsJson.map((e) => PostModel.fromJson(e)).toList());
        }
      }

      allPosts.assignAll(combinedPosts);

    } catch (e) {
      errorMessage.value = AppStrings.failedToLoadPosts.tr;
    } finally {
      isLoading.value = false;
    }
  }

  // ── Refresh ───────────────────────────────────────────────────────────────
  Future<void> refreshPosts() async {
    await fetchMyPosts();
  }

  // ── Change Tab ────────────────────────────────────────────────────────────
  void changeTab(PostStatus status) {
    selectedTab.value = status;
  }

  // ── Tab Label ─────────────────────────────────────────────────────────────
  String tabLabel(PostStatus status) {
    switch (status) {
      case PostStatus.pending:
        return AppStrings.pendingPost.tr;
      case PostStatus.active:
        return AppStrings.activePost.tr;
      case PostStatus.completed:
        return AppStrings.completedPost.tr;
    }
  }

  // ── Notification Detail Arguments per Status ──────────────────────────────
  Map<String, dynamic> buildDetailArguments(PostModel post) {
    switch (post.status) {
      case PostStatus.pending:
        return {
          'id': post.id,
          'itemType': post.title,
          'itemSubtype': post.category,
          'itemDate': post.date,
          'status': AppStrings.statusPending.tr,
          'showAcceptButton': true,
        };
      case PostStatus.active:
        return {
          'id': post.id,
          'itemType': post.title,
          'itemSubtype': post.category,
          'itemDate': post.date,
          'status': AppStrings.statusInTransit.tr,
          'showAcceptButton': false,
        };
      case PostStatus.completed:
        return {
          'id': post.id,
          'itemType': post.title,
          'itemSubtype': post.category,
          'itemDate': post.date,
          'status': AppStrings.statusDelivered.tr,
          'showAcceptButton': false,
        };
    }
  }
}