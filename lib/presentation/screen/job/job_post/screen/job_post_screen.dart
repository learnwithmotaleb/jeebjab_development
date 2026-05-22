import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';

import '../controller/job_post_controller.dart';
import '../widget/catagory_toggle_row_widget.dart';
import '../widget/job_post_card_widget.dart';
import '../widget/job_post_drawer_widget.dart';
import '../widget/sort_dropdown_widget.dart';

class JobPostScreen extends StatefulWidget {
  const JobPostScreen({super.key});

  @override
  State<JobPostScreen> createState() => _JobPostScreenState();
}

class _JobPostScreenState extends State<JobPostScreen> {
  final JobPostController controller = Get.put(JobPostController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobile: _buildMobile());
  }

  Widget _buildMobile() {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF5F6FA),
      endDrawer: const JobPostDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppStrings.jobPost.tr,
          style: TextStyle(
            fontSize: Dimensions.f(17),
            fontWeight: FontWeight.w700,
            color: AppColors.labelColor,
          ),
        ),
        // ── Hamburger / filter menu ───────────────────────────────────────
        actions: [
          Padding(
            padding: EdgeInsets.only(
              right: Dimensions.w(16),
              left: Dimensions.w(16),
            ),
            child: GestureDetector(
              onTap: () => Get.toNamed(RoutePath.jobPostDrawer),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _menuLine(),
                  SizedBox(height: Dimensions.h(4)),
                  _menuLine(),
                  SizedBox(height: Dimensions.h(4)),
                  _menuLine(),
                ],
              ),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          if (controller.showDropdown.value) {
            controller.showDropdown.value = false;
          }
        },
        child: Column(
          children: [
            // ── Filter Row ────────────────────────────────────────────────
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.w(16),
                vertical: Dimensions.h(12),
              ),
              child: Obx(
                () => Row(
                  children: [
                    // ── Category toggles ─────────────────────────────────
                    Expanded(
                      child: CategoryToggleRow(
                        categories: controller.categories,
                        selectedCategories: controller.selectedCategories
                            .toSet(),
                        onSelect: controller.selectCategory,
                      ),
                    ),

                    // ── Sort dropdown ─────────────────────────────────────
                    SortDropdown(
                      selected: controller.selectedSort.value,
                      options: controller.sortOptions,
                      onSelect: controller.selectSort,
                    ),
                  ],
                ),
              ),
            ),

            // ── Posts Grid with pagination ────────────────────────────────
            Expanded(
              child: Obx(() {
                // ── Initial loading ──────────────────────────────────────
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  );
                }

                // ── Error with no data ────────────────────────────────────
                if (controller.errorMessage.value.isNotEmpty &&
                    controller.posts.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.cloud_off_outlined,
                          size: Dimensions.w(48),
                          color: AppColors.greyColor,
                        ),
                        SizedBox(height: Dimensions.h(12)),
                        Text(
                          controller.errorMessage.value,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: Dimensions.f(14),
                            color: AppColors.hintColor,
                          ),
                        ),
                        SizedBox(height: Dimensions.h(16)),
                        TextButton(
                          onPressed: controller.refresh,
                          child: Text(
                            AppStrings.tryAgain,
                            style: TextStyle(color: AppColors.primaryColor),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // ── Empty state ───────────────────────────────────────────
                if (controller.posts.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.work_off_outlined,
                          size: Dimensions.w(48),
                          color: AppColors.greyColor,
                        ),
                        SizedBox(height: Dimensions.h(12)),
                        Text(
                          'No posts found',
                          style: TextStyle(
                            fontSize: Dimensions.f(14),
                            color: AppColors.hintColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // ── Grid with scroll-based load-more ─────────────────────
                return RefreshIndicator(
                  color: AppColors.primaryColor,
                  onRefresh: controller.refresh,
                  child: CustomScrollView(
                    slivers: [
                      // ── Posts grid ───────────────────────────────────
                      SliverPadding(
                        padding: EdgeInsets.all(Dimensions.w(16)),
                        sliver: SliverGrid(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            // Trigger load-more when nearing the end
                            if (index >= controller.posts.length - 4) {
                              controller.loadMore();
                            }

                            final post = controller.posts[index];
                            return JobPostCard(
                              post: post,
                              onTap: () {
                                // Console-log full post details
                                controller.fetchPostDetails(post.sId ?? '');
                                Get.toNamed(
                                  RoutePath.categoryStatus,
                                  arguments: {'id': post.sId ?? ''},
                                );
                              },
                            );
                          }, childCount: controller.posts.length),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: Dimensions.w(12),
                                mainAxisSpacing: Dimensions.h(12),
                                childAspectRatio: 0.78,
                              ),
                        ),
                      ),

                      // ── Load-more spinner ────────────────────────────
                      if (controller.isLoadingMore.value)
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: Dimensions.h(20),
                            ),
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColor,
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                        ),

                      // ── End-of-list indicator ────────────────────────
                      if (!controller.hasMore.value &&
                          controller.posts.isNotEmpty)
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: Dimensions.h(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: Dimensions.w(40),
                                  height: 1,
                                  color: const Color(0xFFDDDDDD),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.w(8),
                                  ),
                                  child: Text(
                                    'No more posts',
                                    style: TextStyle(
                                      fontSize: Dimensions.f(12),
                                      color: AppColors.greyColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: Dimensions.w(40),
                                  height: 1,
                                  color: const Color(0xFFDDDDDD),
                                ),
                              ],
                            ),
                          ),
                        ),

                      // Bottom padding
                      SliverToBoxAdapter(
                        child: SizedBox(height: Dimensions.h(20)),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuLine() => Container(
    width: 22,
    height: 2,
    decoration: BoxDecoration(
      color: AppColors.labelColor,
      borderRadius: BorderRadius.circular(2),
    ),
  );
}
