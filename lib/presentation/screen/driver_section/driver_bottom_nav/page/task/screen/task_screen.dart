import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import 'package:jeebjab/widget/custom_appbar.dart';

import '../controller/task_controller.dart';
import '../widget/task_card_widget.dart';
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
    return ResponsiveLayout(mobile: _buildMobile());
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.myTask.tr),
      body: Column(
        children: [
          // ── Tab switcher ──────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.fromLTRB(
              Dimensions.w(16),
              Dimensions.h(16),
              Dimensions.w(16),
              0,
            ),
            child: Obx(() => TaskTabSwitcher(
              isActive: controller.isActiveTab.value,
              onActiveTab: () => controller.switchTab(true),
              onCompletedTab: () => controller.switchTab(false),
            )),
          ),

          SizedBox(height: Dimensions.h(16)),

          // ── Task list ─────────────────────────────────────────────────
          Expanded(
            child: Obx(() => ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w(16)),
              itemCount: controller.currentList.length,
              itemBuilder: (context, index) {
                final item = controller.currentList[index];
                return TaskCard(
                  item: item,
                  isActive: controller.isActiveTab.value,
                  onPickedUp: () => controller.onPickedUp(item),
                  onOpenMap: () => controller.onOpenMap(item),
                );
              },
            )),
          ),
        ],
      ),
    );
  }
}