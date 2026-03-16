import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';

import '../controller/driver_home_controller.dart';
import '../widget/current_task_card.dart';
import '../widget/driver_header_widget.dart';
import '../widget/recent_job_card.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  final DriverHomeController controller = Get.put(DriverHomeController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobile: _buildMobile());
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── 1. Header ──────────────────────────────────────────────
            Obx(() => DriverHeaderWidget(
              name: 'Ziyn Ahmed',
              email: 'ziynahmed@email.com',
              completedJobs: controller.completedJobs.value,
              totalEarn: controller.totalEarn.value,
              onNotification: () => Get.toNamed(RoutePath.notification),
            )),

            SizedBox(height: Dimensions.h(20)),

            // ── 2. Current Task section ────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w(16)),
              child: Text(
                AppStrings.currentTask.tr,
                style: TextStyle(
                  fontSize: Dimensions.f(16),
                  fontWeight: FontWeight.w700,
                  color: AppColors.labelColor,
                ),
              ),
            ),

            SizedBox(height: Dimensions.h(12)),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w(16)),
              child: Obx(() => Column(
                children: controller.currentTasks
                    .map((task) => CurrentTaskCard(
                  task: task,
                  onPickUp: () => controller.onPickUpTap(task),
                  onOpenMap: () => controller.onOpenMap(task),
                ))
                    .toList(),
              )),
            ),

            SizedBox(height: Dimensions.h(8)),

            // ── 3. Recent Job section ──────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w(16)),
              child: Text(
                AppStrings.recentJob.tr,
                style: TextStyle(
                  fontSize: Dimensions.f(16),
                  fontWeight: FontWeight.w700,
                  color: AppColors.labelColor,
                ),
              ),
            ),

            SizedBox(height: Dimensions.h(12)),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w(16)),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: Dimensions.w(12),
                  mainAxisSpacing: Dimensions.h(12),
                  childAspectRatio: 0.78,
                ),
                itemCount: controller.recentJobs.length,
                itemBuilder: (_, index) {
                  final job = controller.recentJobs[index];
                  return RecentJobCard(
                    job: job,
                    onTap: () => controller.onRecentJobTap(job),
                  );
                },
              ),
            ),

            SizedBox(height: Dimensions.h(30)),
          ],
        ),
      ),
    );
  }
}