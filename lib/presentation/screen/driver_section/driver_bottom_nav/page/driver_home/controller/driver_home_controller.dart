import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../core/routes/route_path.dart';

enum TaskStatus { pickUp, delivered }

class DriverTask {
  final String id;
  final String title;
  final String person;
  final String address;
  final double price;
  final String categoryIcon;
  final Rx<TaskStatus> status;

  DriverTask({
    required this.id,
    required this.title,
    required this.person,
    required this.address,
    required this.price,
    required this.categoryIcon,
    TaskStatus initialStatus = TaskStatus.pickUp,
  }) : status = initialStatus.obs;
}

class RecentJob {
  final String title;
  final String imageUrl;
  final double price;
  final String distance;
  final String categoryIcon;

  RecentJob({
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.distance,
    required this.categoryIcon,
  });
}

class DriverHomeController extends GetxController {
  // ── Stats ──────────────────────────────────────────────────────────────────
  final RxInt completedJobs = 23.obs;
  final RxDouble totalEarn = 2423.0.obs;

  // ── Current Tasks ──────────────────────────────────────────────────────────
  final RxList<DriverTask> currentTasks = <DriverTask>[
    DriverTask(
      id: '1',
      title: 'Dior Red Coat',
      person: 'Cristian Dior',
      address: 'Level Shoes District, Dubai Mall',
      price: 148,
      categoryIcon: 'move',
      initialStatus: TaskStatus.pickUp,
    ),
    DriverTask(
      id: '2',
      title: 'Ducati Bike',
      person: 'Cristian Dior',
      address: 'Abu Dhabi - 2612, Level 2 - Door 6',
      price: 148,
      categoryIcon: 'move',
      initialStatus: TaskStatus.delivered,
    ),
    DriverTask(
      id: '3',
      title: 'Plastic & Papers',
      person: 'Cristian Dior',
      address: 'Level Shoes District, Dubai Mall',
      price: 148,
      categoryIcon: 'recycle',
      initialStatus: TaskStatus.pickUp,
    ),
  ].obs;

  // ── Recent Jobs ────────────────────────────────────────────────────────────
  final List<RecentJob> recentJobs = [
    RecentJob(
      title: 'Ducati Bike',
      imageUrl:
      'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400',
      price: 120,
      distance: '3 KM',
      categoryIcon: 'move',
    ),
    RecentJob(
      title: 'Dior Red Coat',
      imageUrl:
      'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?w=400',
      price: 120,
      distance: '3 KM',
      categoryIcon: 'move',
    ),
    RecentJob(
      title: 'Bike',
      imageUrl:
      'https://images.unsplash.com/photo-1485965120184-e220f721d03e?w=400',
      price: 120,
      distance: '3 KM',
      categoryIcon: 'move',
    ),
    RecentJob(
      title: 'Plastic & Paper',
      imageUrl:
      'https://images.unsplash.com/photo-1532996122724-e3c354a0b15b?w=400',
      price: 120,
      distance: '3 KM',
      categoryIcon: 'recycle',
    ),
  ];

  // ── PickUp confirmation ────────────────────────────────────────────────────
  void onPickUpTap(DriverTask task) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Are You Sure',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A1A2E)),
              ),
              const SizedBox(height: 8),
              const Text(
                'Are You Sure, You Are Picked-Up ?',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        height: 46,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F0F0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'No',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1A1A2E)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                        task.status.value = TaskStatus.delivered;
                      },
                      child: Container(
                        height: 46,
                        decoration: BoxDecoration(
                          color: const Color(0xFF17C5B5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Yes',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

  void onOpenMap(DriverTask task) {
    // TODO: Get.toNamed(RoutePath.mapView, arguments: {'task': task});
    Get.toNamed(RoutePath.pickUpDetails, arguments: {'task': task});
  }

  void onRecentJobTap(RecentJob job) {
    // TODO: Get.toNamed(RoutePath.categoryStatus, arguments: {'title': job.title});
    Get.toNamed(RoutePath.pickUpDetails, arguments: {'task': job});

  }
}