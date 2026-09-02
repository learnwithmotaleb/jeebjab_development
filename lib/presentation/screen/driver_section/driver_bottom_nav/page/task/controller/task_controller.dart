import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/enums/task.dart';
import 'package:jeebjab/helper/tost_message/show_snackbar.dart';
import 'package:jeebjab/presentation/screen/job/delivery/controller/delivery_controller.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import 'package:jeebjab/widget/confirmataion_alert.dart';

import '../../../../../../../core/routes/route_path.dart';
import '../../../../../../../service/api_service.dart';
import '../../../../../../../service/api_url.dart';
import '../model/DriverTaskModel.dart';

class TaskItem {
  final String id;
  final String title;
  final String subtitle;
  final String address; // pickup address
  final double price;
  final String categoryIcon; // raw type e.g. 'move', 'recycling' — for icon
  final String category; // capitalized type — for display labels/badges
  final String size;
  final String description;
  final List<String> photos;
  final String dropoffAddress;
  final String createdAt;
  bool isPickedUp;

  TaskItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.address,
    required this.price,
    required this.categoryIcon,
    this.category = '',
    this.size = '',
    this.description = '',
    this.photos = const [],
    this.dropoffAddress = '',
    this.createdAt = '',
    this.isPickedUp = false,
  });
}

class TaskController extends GetxController {
  // Tab state
  final RxBool isActiveTab = true.obs;
  // Loading indicator
  final RxBool isLoading = true.obs;

  // Task id currently being PATCHed (picked_up) — drives the per-card
  // loading spinner in TaskCard.
  final RxString updatingTaskId = ''.obs;

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
      activePosts.assignAll(tasks.map(_toTaskItem));
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
      completedPosts.assignAll(tasks.map(_toTaskItem));
    } else {
      // Handle error – keep list empty or show a toast as needed
    }
    isLoading.value = false;
  }

  // GET /driver/tasks?status=active returns active + picked_up + in_transit
  // combined, so "already picked up" is anything past plain `active`.
  TaskItem _toTaskItem(Task t) {
    final status = t.status;
    final pastPickup = status == TaskStatus.pickedUp ||
        status == TaskStatus.inTransit ||
        status == TaskStatus.completed;

    return TaskItem(
      id: t.id ?? '',
      title: t.title ?? '',
      subtitle: t.description ?? '',
      address: t.pickup?.address?.text ?? '',
      price: (t.price ?? 0).toDouble(),
      categoryIcon: t.type ?? '',
      category: (t.type ?? '').capitalizeFirst ?? '',
      size: t.size ?? '',
      description: t.description ?? '',
      photos: (t.photos ?? []).map(ApiUrl.buildImageUrl).toList(),
      dropoffAddress: t.dropoff?.address?.text ?? '',
      createdAt: t.createdAt ?? '',
      isPickedUp: pastPickup,
    );
  }

  // ---------------------------------------------------------------------
  // UI callbacks
  // ---------------------------------------------------------------------

  /// Tap on the Picked-Up/Delivery button. Before pickup this marks the
  /// task as picked up (PATCH .../status); once already picked up, the
  /// same button reads "Delivery" and starts the proof-of-delivery flow.
  void onPickedUp(TaskItem item) {
    if (item.isPickedUp) {
      onStartDelivery(item);
      return;
    }

    AppAlerts.confirm(
      title: AppStrings.confirmPickedUpTitle.tr,
      message: AppStrings.confirmPickedUpMessage.tr,
      onConfirm: () => _updateStatus(item, 'picked_up'),
    );
  }

  Future<void> _updateStatus(TaskItem item, String status) async {
    updatingTaskId.value = item.id;
    try {
      final response = await ApiClient().patch(
        url: ApiUrl.updateTaskStatus(item.id),
        body: {'status': status},
        isToken: true,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        item.isPickedUp = true;
        activePosts.refresh();
        AppSnackBar.success(
          response.body['message'] ?? AppStrings.taskStatusUpdatedSuccessfully.tr,
          title: "Success",
        );
      } else {
        AppSnackBar.fail(
          response.body['message'] ?? AppStrings.failedToUpdateTaskStatus.tr,
        );
      }
    } catch (e) {
      debugPrint('Error updating task status: $e');
      AppSnackBar.fail(AppStrings.failedToUpdateTaskStatus.tr);
    } finally {
      updatingTaskId.value = '';
    }
  }

  /// "Deliver" tap — the actual PATCH to `completed` needs a proof photo
  /// plus the driver's live location, so it happens from [DeliveryScreen]
  /// once that's captured. Bind this task onto the (permanent, app-wide)
  /// DeliveryController first so the whole camera → upload chain knows
  /// which task it's completing.
  void onStartDelivery(TaskItem item) {
    AppAlerts.confirm(
      title: AppStrings.confirmDeliverTitle.tr,
      message: AppStrings.confirmDeliverMessage.tr,
      onConfirm: () {
        Get.find<DeliveryController>().bindTask(
          taskId: item.id,
          title: item.title,
          category: item.category,
          price: item.price,
          description: item.description,
          size: item.size,
          deliveryLocation: item.dropoffAddress.isNotEmpty
              ? item.dropoffAddress
              : item.address,
          publishedTime: item.createdAt.length >= 10
              ? item.createdAt.substring(0, 10)
              : item.createdAt,
          imageUrl: item.photos.isNotEmpty ? item.photos.first : null,
        );
        AppAlerts.proof();
      },
    );
  }

  void onOpenMap(TaskItem item) {
    // Navigate to task details screen with the task ID
    Get.toNamed(RoutePath.taskDetailsScreen, arguments: {'id': item.id});
  }
}
