import 'package:get/get.dart';

import '../model/my_post_model.dart';

class MyPostController extends GetxController {
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

      // TODO: Replace with your real API call
      // final response = await ApiService.get('/my-posts');
      // final List data = response['data'];
      // allPosts.value = data.map((e) => PostModel.fromJson(e)).toList();

      // ── Dummy data (remove when API is ready) ─────────────────────────
      await Future.delayed(const Duration(seconds: 1)); // simulate network
      allPosts.value = _dummyPosts();

    } catch (e) {
      errorMessage.value = 'Failed to load posts. Please try again.';
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
        return 'Pending Post';
      case PostStatus.active:
        return 'Active Post';
      case PostStatus.completed:
        return 'Completed Post';
    }
  }

  // ── Notification Detail Arguments per Status ──────────────────────────────
  Map<String, dynamic> buildDetailArguments(PostModel post) {
    switch (post.status) {
      case PostStatus.pending:
        return {
          'itemType': post.title,
          'itemSubtype': post.category,
          'itemDate': post.date,
          'status': 'pending',
          'showAcceptButton': true,
        };
      case PostStatus.active:
        return {
          'itemType': post.title,
          'itemSubtype': post.category,
          'itemDate': post.date,
          'status': 'in_transit',
          'showAcceptButton': false,
        };
      case PostStatus.completed:
        return {
          'itemType': post.title,
          'itemSubtype': post.category,
          'itemDate': post.date,
          'status': 'delivered',
          'showAcceptButton': false,
        };
    }
  }

  // ── Dummy Posts (remove when API is ready) ────────────────────────────────
  List<PostModel> _dummyPosts() {
    return [
      PostModel(
        title: 'Move',
        category: 'Bike',
        date: '10 January',
        size: 'Medium Size',
        price: 120,
        status: PostStatus.pending,
        imageUrl:
        'https://images.unsplash.com/photo-1485965120184-e220f721d03e?w=200',
      ),
      PostModel(
        title: 'Recycling',
        category: 'Bike',
        date: '10 January',
        size: 'Medium Size',
        price: 260,
        status: PostStatus.pending,
        imageUrl:
        'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=200',
      ),
      PostModel(
        title: 'Furniture Delivery',
        category: 'Sofa',
        date: '12 January',
        size: 'Large Size',
        price: 450,
        status: PostStatus.active,
        imageUrl:
        'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=200',
      ),
      PostModel(
        title: 'Electronics Move',
        category: 'TV',
        date: '8 January',
        size: 'Small Size',
        price: 90,
        status: PostStatus.completed,
        imageUrl:
        'https://images.unsplash.com/photo-1593359677879-a4bb92f829d1?w=200',
      ),
    ];
  }
}