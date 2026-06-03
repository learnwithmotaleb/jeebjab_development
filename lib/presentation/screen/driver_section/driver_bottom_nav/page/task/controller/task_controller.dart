import 'package:get/get.dart';
import '../../../../../../../core/routes/route_path.dart';
import '../../../../../../../service/api_service.dart';
import '../../../../../../../service/api_url.dart';
import '../model/DriverTaskModel.dart';

class TaskItem {
  final String title;
  final String subtitle;
  final String address;
  final double price;
  final String categoryIcon; // e.g., 'move', 'recycle', 'gift'

  TaskItem({
    required this.title,
    required this.subtitle,
    required this.address,
    required this.price,
    required this.categoryIcon,
  });
}

class TaskController extends GetxController {
  // Tab state
  final RxBool isActiveTab = true.obs;
  // Loading indicator
  final RxBool isLoading = true.obs;

  // Reactive task lists
  final RxList<TaskItem> activePosts = <TaskItem>[].obs;
  final RxList<TaskItem> completedPosts = <TaskItem>[].obs;

  // Current list getter used by UI
  RxList<TaskItem> get currentList =>
      isActiveTab.value ? activePosts : completedPosts;

  @override
  void onInit() {
    super.onInit();
    // Load tasks from API when controller is created
    fetchActiveTasks();
    fetchCompletedTasks();
  }

  void switchTab(bool active) => isActiveTab.value = active;

  // ---------------------------------------------------------------------
  // API fetching helpers
  // ---------------------------------------------------------------------
  Future<void> fetchActiveTasks() async {
    isLoading.value = true;
    final response = await ApiClient().get(
      url: ApiUrl.getActiveTasks,
      isToken: true,
    );
    if (response.statusCode == 200) {
      final model = DriverTaskModel.fromJson(response.body);
      final tasks = model.data?.tasks ?? [];
      activePosts.assignAll(
        tasks.map(
          (t) => TaskItem(
            title: t.title ?? '',
            subtitle: t.description ?? '',
            address: t.pickup?.address?.text ?? '',
            price: (t.price ?? 0).toDouble(),
            categoryIcon: t.type ?? '',
          ),
        ),
      );
    } else {
      // Handle error – keep list empty or show a toast as needed
    }
    isLoading.value = false;
  }

  Future<void> fetchCompletedTasks() async {
    isLoading.value = true;
    final response = await ApiClient().get(
      url: ApiUrl.getCompletedTasks,
      isToken: true,
    );
    if (response.statusCode == 200) {
      final model = DriverTaskModel.fromJson(response.body);
      final tasks = model.data?.tasks ?? [];
      completedPosts.assignAll(
        tasks.map(
          (t) => TaskItem(
            title: t.title ?? '',
            subtitle: t.description ?? '',
            address: t.pickup?.address?.text ?? '',
            price: (t.price ?? 0).toDouble(),
            categoryIcon: t.type ?? '',
          ),
        ),
      );
    } else {
      // Handle error – keep list empty or show a toast as needed
    }
    isLoading.value = false;
  }

  // ---------------------------------------------------------------------
  // UI callbacks
  // ---------------------------------------------------------------------
  void onPickedUp(TaskItem item) {
    // TODO: implement pick‑up logic (e.g., send status update to server)
  }

  void onOpenMap(TaskItem item) {
    Get.toNamed(RoutePath.postDetails, arguments: {'task': item});
  }
}
