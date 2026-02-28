import 'package:get/get.dart';

class TaskItem {
  final String title;
  final String subtitle;
  final String address;
  final double price;
  final String categoryIcon; // 'move', 'recycle', 'gift'

  TaskItem({
    required this.title,
    required this.subtitle,
    required this.address,
    required this.price,
    required this.categoryIcon,
  });
}

class TaskController extends GetxController {
  final RxBool isActiveTab = true.obs;

  // ── Active Posts ──────────────────────────────────────────────────────────
  final List<TaskItem> activePosts = [
    TaskItem(
      title: 'Dior Red Coat',
      subtitle: 'Cristian Dior',
      address: 'Level Shoes District, Dubai Mall',
      price: 148,
      categoryIcon: 'move',
    ),
    TaskItem(
      title: 'Ducati Bike',
      subtitle: 'Cristian Dior',
      address: 'Abu Dhabi - 2612, Level 2 - Door 6',
      price: 148,
      categoryIcon: 'move',
    ),
    TaskItem(
      title: 'Plastic & Papers',
      subtitle: 'Cristian Dior',
      address: 'Level Shoes District, Dubai Mall',
      price: 148,
      categoryIcon: 'recycle',
    ),
  ];

  // ── Completed Posts ───────────────────────────────────────────────────────
  final List<TaskItem> completedPosts = [
    TaskItem(
      title: 'Dior Red Coat',
      subtitle: 'Aqua Tower',
      address: 'Abu Dhabi - 2612, Level 2 - Door 6',
      price: 148,
      categoryIcon: 'move',
    ),
    TaskItem(
      title: 'Ducati Bike',
      subtitle: 'Cristian Dior',
      address: 'Abu Dhabi - 2612, Level 2 - Door 6',
      price: 148,
      categoryIcon: 'move',
    ),
    TaskItem(
      title: 'Plastic & Papers',
      subtitle: 'Cristian Dior',
      address: 'Level Shoes District, Dubai Mall',
      price: 148,
      categoryIcon: 'recycle',
    ),
  ];

  List<TaskItem> get currentList =>
      isActiveTab.value ? activePosts : completedPosts;

  void switchTab(bool active) => isActiveTab.value = active;

  void onPickedUp(TaskItem item) {
    // TODO: handle picked up
  }

  void onOpenMap(TaskItem item) {
    // TODO: open map
  }
}