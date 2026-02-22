import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';

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
    return ResponsiveLayout(mobile: _buildMobile());
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: "Create Post"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 32),

          // ── Heading ────────────────────────────────────────────────────
          const Text(
            'What Do You Need Help With ?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A2E),
            ),
          ),

          const SizedBox(height: 24),

          // ── Category Cards ─────────────────────────────────────────────
          // ✅ Fix: Obx must directly read an Rx variable.
          // We read controller.selectedCategory.value here so GetX
          // registers it as a dependency and rebuilds on change.
          Expanded(
            child: Obx(() {
              final selected = controller.selectedCategory.value; // ← Rx read
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.categories.length,
                itemBuilder: (context, index) {
                  final category = controller.categories[index];
                  return CategoryCardWidget(
                    category: category,
                    isSelected: selected?.title == category.title, // ← direct compare
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
}