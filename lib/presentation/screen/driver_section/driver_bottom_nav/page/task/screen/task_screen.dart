import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/presentation/screen/driver_section/driver_bottom_nav/page/task/widget/task_card_widget.dart';
import 'package:jeebjab/presentation/screen/post_details/screen/post_details_screen.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import 'package:jeebjab/widget/custom_appbar.dart';

import '../../../../../../../widget/app_loading.dart';
import '../controller/task_controller.dart';
import 'package:get/get.dart';

import '../widget/task_tab_switcher_widget.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final TaskController controller = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobile: _buildMobile(), tablet: _buildTablet());
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.myTask.tr, showBack: false),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              Dimensions.w(16),
              Dimensions.h(16),
              Dimensions.w(16),
              0,
            ),
            child: Obx(
              () => TaskTabSwitcher(
                isActive: controller.isActiveTab.value,
                onActiveTab: () => controller.switchTab(true),
                onCompletedTab: () => controller.switchTab(false),
              ),
            ),
          ),
          SizedBox(height: Dimensions.h(16)),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                if (controller.isActiveTab.value) {
                  await controller.fetchActiveTasks();
                } else {
                  await controller.fetchCompletedTasks();
                }
              },
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const AppLoading(message: 'Loading tasks...');
                } else if (controller.currentList.isEmpty) {
                  return const Center(child: Text('No tasks available'));
                } else {
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.w(16)),
                    itemCount: controller.currentList.length,
                    itemBuilder: (context, index) {
                      final item = controller.currentList[index];
                      return TaskCard(
                        item: item,
                        isActive: controller.isActiveTab.value,
                        onPickedUp: () => controller.onPickedUp(item),
                        onOpenMap: () => controller.onOpenMap(item),
                        onTap: () => Get.toNamed(RoutePath.taskDetailsScreen, arguments: {
          'id': item.id,
          'itemType': item.title,
          'itemSubtype': item.subtitle,
          'price': item.price,
        }),
                        margin: EdgeInsets.only(bottom: Dimensions.h(16)),
                      );
                    },
                  );
                }
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTablet() {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F5F9),
      appBar: CommonAppBar(title: AppStrings.myTask.tr, showBack: false),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Dimensions.h(32)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w(24)),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        title: AppStrings.activePost.tr,
                        count: controller.activePosts.length,
                        icon: Icons.pending_actions_rounded,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    SizedBox(width: Dimensions.w(20)),
                    Expanded(
                      child: _buildStatCard(
                        title: AppStrings.completedPost.tr,
                        count: controller.completedPosts.length,
                        icon: Icons.task_alt_rounded,
                        color: AppColors.completeColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.h(32)),
              Center(
                child: SizedBox(
                  width: 500,
                  child: Obx(
                    () => TaskTabSwitcher(
                      isActive: controller.isActiveTab.value,
                      onActiveTab: () => controller.switchTab(true),
                      onCompletedTab: () => controller.switchTab(false),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.h(24)),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    if (controller.isActiveTab.value) {
                      await controller.fetchActiveTasks();
                    } else {
                      await controller.fetchCompletedTasks();
                    }
                  },
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return const AppLoading(message: 'Loading tasks...');
                    } else if (controller.currentList.isEmpty) {
                      return const Center(child: Text('No tasks available'));
                    } else {
                      return GridView.builder(
                        padding: EdgeInsets.fromLTRB(
                          Dimensions.w(24),
                          0,
                          Dimensions.w(24),
                          Dimensions.h(24),
                        ),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 550,
                          mainAxisExtent: Dimensions.h(200),
                          crossAxisSpacing: Dimensions.w(24),
                          mainAxisSpacing: Dimensions.h(24),
                        ),
                        itemCount: controller.currentList.length,
                        itemBuilder: (context, index) {
                          final item = controller.currentList[index];
                          return TaskCard(
                            item: item,
                            isActive: controller.isActiveTab.value,
                            onPickedUp: () => controller.onPickedUp(item),
                            onOpenMap: () => controller.onOpenMap(item),
                            margin: EdgeInsets.zero,
                          );
                        },
                      );
                    }
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required int count,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(Dimensions.w(20)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.r(16)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(Dimensions.w(12)),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: Dimensions.w(24)),
          ),
          SizedBox(width: Dimensions.w(16)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: Dimensions.f(14),
                  fontWeight: FontWeight.w600,
                  color: AppColors.greyColor,
                ),
              ),
              Text(
                count.toString(),
                style: TextStyle(
                  fontSize: Dimensions.f(24),
                  fontWeight: FontWeight.w800,
                  color: AppColors.labelColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
