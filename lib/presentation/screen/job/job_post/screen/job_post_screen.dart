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
      // endDrawer: const JobPostDrawer(),
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
        // ── Hamburger menu ───────────────────────────────────────────
        actions: [
          Padding(
            padding: EdgeInsets.only(right: Dimensions.w(16),left: Dimensions.w(16) ),
            child: GestureDetector(
              //onTap: () => _scaffoldKey.currentState?.openEndDrawer(),
              onTap: (){

                setState(() {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>JobPostDrawer()));

                });
              },
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
            // ── Filter Row ──────────────────────────────────────────────
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.w(16),
                vertical: Dimensions.h(12),
              ),
              child: Obx(() => Row(
                children: [
                  // ── Category toggles ───────────────────────────
                  Expanded(
                    child: CategoryToggleRow(
                      categories: controller.categories,
                      selectedCategories: controller.selectedCategories.toSet(),
                      onSelect: controller.selectCategory,
                    ),
                  ),

                  // ── Sort dropdown ──────────────────────────────
                  SortDropdown(
                    selected: controller.selectedSort.value,
                    options: controller.sortOptions,
                    onSelect: controller.selectSort,
                  ),
                ],
              )),
            ),

            // ── Posts Grid ──────────────────────────────────────────────
            Expanded(
              child: Obx(() => GridView.builder(
                padding: EdgeInsets.all(Dimensions.w(16)),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: Dimensions.w(12),
                  mainAxisSpacing: Dimensions.h(12),
                  childAspectRatio: 0.78,
                ),
                itemCount: controller.posts.length,
                itemBuilder: (context, index) {
                  return JobPostCard(
                    post: controller.posts[index],
                    onTap: () {

                      Get.toNamed(RoutePath.categoryStatus);

                    },
                  );
                },
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuLine() => Container(
    width: Dimensions.w(22),
    height: 2,
    decoration: BoxDecoration(
      color: AppColors.labelColor,
      borderRadius: BorderRadius.circular(2),
    ),
  );
}