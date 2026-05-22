
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/enums/post_category_type.dart';
import 'package:jeebjab/service/api_service.dart';
import 'package:jeebjab/service/api_url.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';

import '../model/job_post_model.dart';

// ── Category chip model (UI only) ────────────────────────────────────────────

class JobPostCategory {
  final PostCategoryType type;
  final IconData icon;

  const JobPostCategory({required this.type, required this.icon});

  /// Display label shown in UI / filter chip tooltip
  String get label => type.displayName;

  /// Value sent to the API as the `type` query param
  String get apiValue => type.apiValue;
}

// ── Controller ────────────────────────────────────────────────────────────────

class JobPostController extends GetxController {
  final ApiClient _api = ApiClient();

  // ── Category filter chips ────────────────────────────────────────────────
  final List<JobPostCategory> categories = const [
    JobPostCategory(
      type: PostCategoryType.move,
      icon: Icons.inventory_2_outlined,
    ),
    JobPostCategory(
      type: PostCategoryType.recycling,
      icon: Icons.recycling_outlined,
    ),
    JobPostCategory(
      type: PostCategoryType.buyForMe,
      icon: Icons.shopping_cart_outlined,
    ),
    JobPostCategory(
      type: PostCategoryType.giveAway,
      icon: Icons.card_giftcard_outlined,
    ),
  ];

  /// Active type filters — empty means "all types"
  final RxSet<PostCategoryType> selectedCategories =
      <PostCategoryType>{}.obs;

  // ── Sort ─────────────────────────────────────────────────────────────────
  final RxString selectedSort = AppStrings.nearest.obs;
  final List<String> sortOptions = [AppStrings.nearest, AppStrings.newest];
  final RxBool showDropdown = false.obs;

  // ── Post list ─────────────────────────────────────────────────────────────
  final RxList<PostItem> posts = <PostItem>[].obs;

  // ── Loading states ────────────────────────────────────────────────────────
  final RxBool isLoading = false.obs;
  final RxBool isLoadingMore = false.obs;
  final RxBool hasMore = true.obs;
  final RxString errorMessage = ''.obs;

  // ── Pagination state ──────────────────────────────────────────────────────
  int _currentPage = 1;
  static const int _pageSize = 10;

  // ── Filter state ────────────────────────────────────────────────────────
  // Sort (already exists as selectedSort)
  final RxString selectedTime = 'Regular'.obs;
  final RxString selectedPickup = AppStrings.insideHouseApartment.tr.obs;
  final RxBool pickupNoMeet = false.obs;
  final RxBool pickupCanHelp = false.obs;
  final RxString selectedDropoff = AppStrings.inside.tr.obs;
  final RxBool dropoffNoMeet = false.obs;
  final RxBool dropoffCanHelp = false.obs;
  final RxBool delivery = true.obs;
  final RxBool recycling = true.obs;
  final RxBool buyForMe = false.obs;
  final RxBool giveAway = false.obs;
  final RxDouble distance = 90.0.obs;

  // ─────────────────────────────────────────────────────────────────────────
  @override
  void onInit() {
    super.onInit();
    fetchPosts(reset: true);
  }

  // ── Fetch posts ───────────────────────────────────────────────────────────

  Future<void> fetchPosts({bool reset = false}) async {
    if (reset) {
      _currentPage = 1;
      hasMore.value = true;
      errorMessage.value = '';
      posts.clear();
      isLoading.value = true;
    } else {
      if (!hasMore.value || isLoadingMore.value) return;
      isLoadingMore.value = true;
    }

    final url = _buildUrl();
    debugPrint('📡 Fetching job posts → $url');

    try {
      final response = await _api.get(url: url, isToken: true);

      if (response.statusCode == 200 && response.body != null) {
        final model = JobPostModel.fromJson(
          response.body is Map<String, dynamic>
              ? response.body as Map<String, dynamic>
              : {},
        );

        debugPrint(
          '✅ Job Posts fetched | message: ${model.message} '
          '| page: $_currentPage | count: ${model.data?.posts?.length ?? 0}',
        );

        final newPosts = model.data?.posts ?? [];
        posts.addAll(newPosts);

        final meta = model.data?.meta;
        if (meta != null) {
          final totalPages = meta.totalPage ?? 1;
          hasMore.value = _currentPage < totalPages;
          debugPrint(
            '📄 Pagination → page $_currentPage/$totalPages | '
            'total: ${meta.total} posts | hasMore: ${hasMore.value}',
          );
          _currentPage++;
        } else {
          hasMore.value = false;
        }
      } else {
        final msg = response.statusText ?? 'Unknown error';
        debugPrint('❌ Failed to fetch job posts [${response.statusCode}]: $msg');
        errorMessage.value = msg;
      }
    } catch (e) {
      debugPrint('❌ fetchPosts exception: $e');
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  // ── Load next page (called from scroll listener) ──────────────────────────

  void loadMore() {
    if (!hasMore.value || isLoadingMore.value || isLoading.value) return;
    fetchPosts();
  }

  // ── Refresh ───────────────────────────────────────────────────────────────

  @override
  Future<void> refresh() => fetchPosts(reset: true);

  // ── Fetch & console-log full details for a single post ───────────────────

  Future<void> fetchPostDetails(String id) async {
    if (id.isEmpty) return;
    final url = ApiUrl.getJobPostDetails(id);
    debugPrint('🔍 Fetching post details → $url');

    try {
      final response = await _api.get(url: url, isToken: true);
      debugPrint(
        '📦 Post Details [${response.statusCode}]:\n${response.bodyString}',
      );
    } catch (e) {
      debugPrint('❌ fetchPostDetails exception: $e');
    }
  }

  // ── Category toggle ───────────────────────────────────────────────────────

  void selectCategory(PostCategoryType type) {
    if (selectedCategories.contains(type)) {
      selectedCategories.remove(type);
    } else {
      selectedCategories.add(type);
    }
    fetchPosts(reset: true);
  }

  // ── Sort selection ────────────────────────────────────────────────────────

  void selectSort(String sort) {
    selectedSort.value = sort;
    showDropdown.value = false;
    fetchPosts(reset: true);
  }

  void toggleDropdown() => showDropdown.value = !showDropdown.value;

  // ── URL builder ───────────────────────────────────────────────────────────

  String _buildUrl() {
    final params = <String, String>{
      'page': '$_currentPage',
      'limit': '$_pageSize',
    };

    // Type filter — only applied when at least one category is selected
    if (selectedCategories.isNotEmpty) {
      params['type'] =
          selectedCategories.map((t) => t.apiValue).join(',');
    }

    // Sort
    params['sortBy'] =
        selectedSort.value == AppStrings.newest ? 'newest' : 'nearest';

    // Additional filters
    params['time'] = selectedTime.value.toLowerCase();
    params['pickupPlacement'] = _mapPlacement(selectedPickup.value);
    params['pickupNoMeet'] = pickupNoMeet.value.toString();
    params['pickupCanHelp'] = pickupCanHelp.value.toString();
    params['dropoffPlacement'] = _mapPlacement(selectedDropoff.value);
    params['dropoffNoMeet'] = dropoffNoMeet.value.toString();
    params['dropoffCanHelp'] = dropoffCanHelp.value.toString();
    if (delivery.value) params['delivery'] = 'true';
    if (recycling.value) params['recycling'] = 'true';
    if (buyForMe.value) params['buyForMe'] = 'true';
    if (giveAway.value) params['giveAway'] = 'true';
    if (distance.value != 90.0) {
      params['distance'] = distance.value.toInt().toString();
    }

    return Uri.parse(ApiUrl.getJobPost)
        .replace(queryParameters: params)
        .toString();
  }

  // Helper to map UI placement text to API value
  String _mapPlacement(String label) {
    final lower = label.toLowerCase();
    if (lower.contains('inside')) return 'inside';
    if (lower.contains('outside')) return 'outside';
    return '';
  }

  // Apply filters from drawer UI
  void applyFilters({
    required String sort,
    required String time,
    required String pickupPlacement,
    required bool pickupNoMeet,
    required bool pickupCanHelp,
    required String dropoffPlacement,
    required bool dropoffNoMeet,
    required bool dropoffCanHelp,
    required bool delivery,
    required bool recycling,
    required bool buyForMe,
    required bool giveAway,
    required double distance,
  }) {
    selectedSort.value = sort;
    selectedTime.value = time;
    selectedPickup.value = pickupPlacement;
    this.pickupNoMeet.value = pickupNoMeet;
    this.pickupCanHelp.value = pickupCanHelp;
    selectedDropoff.value = dropoffPlacement;
    this.dropoffNoMeet.value = dropoffNoMeet;
    this.dropoffCanHelp.value = dropoffCanHelp;
    this.delivery.value = delivery;
    this.recycling.value = recycling;
    this.buyForMe.value = buyForMe;
    this.giveAway.value = giveAway;
    this.distance.value = distance;
    fetchPosts(reset: true);
  }
}