import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';

import '../../../../utils/app_colors/app_colors.dart';
import '../../../../widget/custom_appbar.dart';
import '../controller/create_post_controller.dart';
import '../widget/catagory_card_widget.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final CreatePostController controller = Get.put(CreatePostController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobile(),
      tablet: _buildTablet(),
    );
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(
        title: AppStrings.createPost.tr,
        showBack: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 32),

          // ── Heading ────────────────────────────────────────────────────
          Text(
            AppStrings.whatDoYouNeedHelpWith.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A2E),
            ),
          ),

          const SizedBox(height: 24),

          // ── Category Cards ─────────────────────────────────────────────
          Expanded(
            child: Obx(() {
              final selected = controller.selectedCategory.value;
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.categories.length,
                itemBuilder: (context, index) {
                  final category = controller.categories[index];
                  return CategoryCardWidget(
                    category: category,
                    isSelected: selected?.title == category.title,
                    onTap: () => controller.selectCategory(category),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildTablet() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(
        title: AppStrings.createPost.tr,
        showBack: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.w(48),
          vertical: Dimensions.h(40),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 900),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: Dimensions.h(20)),

                // ── Icon/Visual ──────────────────────────────────────
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(Dimensions.r(20)),
                  ),
                  child: Icon(
                    Icons.note_add_outlined,
                    size: 50,
                    color: AppColors.primaryColor,
                  ),
                ),

                SizedBox(height: Dimensions.h(40)),

                // ── Title ────────────────────────────────────────────
                Text(
                  AppStrings.createPost.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor,
                  ),
                ),

                SizedBox(height: Dimensions.h(12)),

                // ── Subtitle ────────────────────────────────────────
                Text(
                  AppStrings.whatDoYouNeedHelpWith.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[600],
                  ),
                ),

                SizedBox(height: Dimensions.h(48)),

                // ── Category Grid ───────────────────────────────────
                Obx(() {
                  final selected = controller.selectedCategory.value;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.8,
                      crossAxisSpacing: Dimensions.w(20),
                      mainAxisSpacing: Dimensions.h(20),
                    ),
                    itemCount: controller.categories.length,
                    itemBuilder: (context, index) {
                      final category = controller.categories[index];
                      return CategoryCardWidget(
                        category: category,
                        isSelected: selected?.title == category.title,
                        onTap: () => controller.selectCategory(category),
                      );
                    },
                  );
                }),

                SizedBox(height: Dimensions.h(40)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}