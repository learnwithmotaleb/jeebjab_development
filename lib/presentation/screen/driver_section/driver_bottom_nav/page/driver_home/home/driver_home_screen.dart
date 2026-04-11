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
    return ResponsiveLayout(
      mobile: _buildMobile(),
      tablet: _buildTablet(),
    );
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => DriverHeaderWidget(
              name: 'Ziyn Ahmed',
              email: 'ziynahmed@email.com',
              completedJobs: controller.completedJobs.value,
              totalEarn: controller.totalEarn.value,
              onNotification: () => Get.toNamed(RoutePath.notification),
              controller: controller,
            )),
            SizedBox(height: Dimensions.h(20)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w(16)),
              child: _buildSectionHeader(AppStrings.currentTask.tr, f: 16),
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w(16)),
              child: _buildSectionHeader(AppStrings.recentJob.tr, f: 16),
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

  Widget _buildTablet() {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800), // Max width for tablet content
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Obx(() => DriverHeaderWidget(
                  name: 'Ziyn Ahmed',
                  email: 'ziynahmed@email.com',
                  completedJobs: controller.completedJobs.value,
                  totalEarn: controller.totalEarn.value,
                  onNotification: () => Get.toNamed(RoutePath.notification),
                  controller: controller,
                )),
                SizedBox(height: Dimensions.h(30)),

                // Current Tasks Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w(24)),
                  child: _buildSectionHeader(AppStrings.currentTask.tr, f: 20),
                ),
                SizedBox(height: Dimensions.h(20)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w(24)),
                  child: Obx(() => Column(
                    children: controller.currentTasks
                        .map((task) => Padding(
                      padding: EdgeInsets.only(bottom: Dimensions.h(12)),
                      child: CurrentTaskCard(
                        task: task,
                        onPickUp: () => controller.onPickUpTap(task),
                        onOpenMap: () => controller.onOpenMap(task),
                      ),
                    ))
                        .toList(),
                  )),
                ),
                SizedBox(height: Dimensions.h(20)),

                // Recent Jobs Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w(24)),
                  child: _buildSectionHeader(AppStrings.recentJob.tr, f: 20),
                ),
                SizedBox(height: Dimensions.h(20)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w(24)),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // Changed to 3 columns for tablet
                      crossAxisSpacing: Dimensions.w(20), // Increased spacing
                      mainAxisSpacing: Dimensions.h(20), // Increased spacing
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
                SizedBox(height: Dimensions.h(50)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, {double f = 16}) {
    return Text(
      title,
      style: TextStyle(
        fontSize: Dimensions.f(f),
        fontWeight: FontWeight.w800,
        color: const Color(0xFF1A1A2E),
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Dimensions.w(24)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.r(16)),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Center(
        child: Text(
          message,
          style: TextStyle(
            fontSize: Dimensions.f(14),
            color: Colors.grey[500],
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
