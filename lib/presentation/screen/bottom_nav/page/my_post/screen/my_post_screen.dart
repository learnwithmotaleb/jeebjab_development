import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/presentation/screen/bottom_nav/page/my_post/controller/my_post_controller.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import 'package:jeebjab/widget/custom_appbar.dart';

import '../../../../../../utils/app_colors/app_colors.dart';
import '../model/my_post_model.dart';
import '../widget/my_post_card.dart';

class MyPostScreen extends StatefulWidget {
  const MyPostScreen({super.key});

  @override
  State<MyPostScreen> createState() => _MyPostScreenState();
}

class _MyPostScreenState extends State<MyPostScreen> {
  final MyPostController controller = Get.put(MyPostController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobile: _buildMobile());
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: CommonAppBar(title: AppStrings.myPost.tr),
      body: Column(
        children: [
          _buildTabBar(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                );
              }

              if (controller.errorMessage.value.isNotEmpty) {
                return _buildErrorState();
              }

              final posts = controller.filteredPosts;
              if (posts.isEmpty) return _buildEmptyState();

              return RefreshIndicator(
                color: AppColors.primaryColor,
                onRefresh: controller.refreshPosts,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return PostCard(
                      post: posts[index],
                      onTap: () => _handleCardTap(posts[index]),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  void _handleCardTap(PostModel post) {
    Get.toNamed(
      RoutePath.notificationDetails,
      arguments: controller.buildDetailArguments(post),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: AppColors.whiteColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Obx(
            () => Row(
          children: PostStatus.values.map((status) {
            final isSelected = controller.selectedTab.value == status;
            return Expanded(
              child: GestureDetector(
                onTap: () => controller.changeTab(status),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primaryColor
                        : AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primaryColor
                          : AppColors.greyColor.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      controller.tabLabel(status),
                      style: TextStyle(
                        color: isSelected
                            ? AppColors.whiteColor
                            : AppColors.blackColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_rounded,
            size: 64,
            color: AppColors.greyColor.withOpacity(0.4),
          ),
          const SizedBox(height: 16),
          Text(
            'No ${controller.tabLabel(controller.selectedTab.value)} yet',
            style: const TextStyle(
              color: AppColors.greyColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.wifi_off_rounded,
            size: 64,
            color: AppColors.greyColor.withOpacity(0.4),
          ),
          const SizedBox(height: 16),
          Text(
            controller.errorMessage.value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.greyColor,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: controller.refreshPosts,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(
                  horizontal: 32, vertical: 12),
            ),
            child: Text(
              AppStrings.tryAgain.tr,
              style: const TextStyle(
                color: AppColors.whiteColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}