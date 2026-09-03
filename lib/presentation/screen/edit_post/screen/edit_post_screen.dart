import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';
import 'package:jeebjab/service/api_url.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import 'package:jeebjab/widget/app_button.dart';
import 'package:jeebjab/widget/custom_appbar.dart';

import '../controller/edit_post_controller.dart';

class EditPostScreen extends StatefulWidget {
  const EditPostScreen({super.key});

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  final EditPostController controller = Get.put(EditPostController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobile: _buildBody(), tablet: _buildBody(isTablet: true));
  }

  Widget _buildBody({bool isTablet = false}) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.editPost.tr),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(Dimensions.w(24)),
              child: Text(
                controller.errorMessage.value,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: Dimensions.f(14), color: Colors.grey[700]),
              ),
            ),
          );
        }

        final content = SingleChildScrollView(
          padding: EdgeInsets.all(Dimensions.w(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPhotosSection(),
              SizedBox(height: Dimensions.h(20)),
              _buildLabel(AppStrings.titleOfService.tr),
              _buildTextField(controller.titleController),
              SizedBox(height: Dimensions.h(16)),
              _buildLabel(AppStrings.descriptionOfService.tr),
              _buildTextField(controller.descriptionController, maxLines: 4),
              SizedBox(height: Dimensions.h(16)),
              _buildLabel(AppStrings.size.tr),
              _buildSizeDropdown(),
              SizedBox(height: Dimensions.h(16)),
              _buildLabel(AppStrings.price.tr),
              _buildTextField(
                controller.priceController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
              SizedBox(height: Dimensions.h(28)),
              Obx(
                () => AppButton(
                  label: AppStrings.updatePost.tr,
                  isLoading: controller.isSaving.value,
                  onPressed: controller.save,
                  height: Dimensions.h(52),
                ),
              ),
              SizedBox(height: Dimensions.h(16)),
            ],
          ),
        );

        return isTablet
            ? Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: content,
                ),
              )
            : content;
      }),
    );
  }

  Widget _buildLabel(String text) => Padding(
    padding: EdgeInsets.only(bottom: Dimensions.h(6)),
    child: Text(
      text,
      style: TextStyle(
        fontSize: Dimensions.f(13),
        fontWeight: FontWeight.w600,
        color: AppColors.labelColor,
      ),
    ),
  );

  Widget _buildTextField(
    TextEditingController textController, {
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: textController,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: TextStyle(fontSize: Dimensions.f(14)),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.textFieldBackgroundColor,
        contentPadding: EdgeInsets.symmetric(
          horizontal: Dimensions.w(14),
          vertical: Dimensions.h(12),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.r(10)),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildSizeDropdown() {
    return Obx(
      () => Container(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.w(14)),
        decoration: BoxDecoration(
          color: AppColors.textFieldBackgroundColor,
          borderRadius: BorderRadius.circular(Dimensions.r(10)),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: controller.size.value,
            isExpanded: true,
            items: controller.sizeOptions
                .map(
                  (s) => DropdownMenuItem(
                    value: s,
                    child: Text(
                      s.split('_').map((w) => w[0].toUpperCase() + w.substring(1)).join(' '),
                      style: TextStyle(fontSize: Dimensions.f(14)),
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) controller.size.value = value;
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPhotosSection() {
    return Obx(
      () => Wrap(
        spacing: Dimensions.w(10),
        runSpacing: Dimensions.h(10),
        children: [
          ...controller.existingPhotos.map(
            (path) => _photoThumb(
              image: Image.network(
                ApiUrl.buildImageUrl(path),
                width: Dimensions.w(80),
                height: Dimensions.w(80),
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: Dimensions.w(80),
                  height: Dimensions.w(80),
                  color: Colors.grey[200],
                  child: const Icon(Icons.broken_image, color: Colors.grey),
                ),
              ),
              onRemove: () => controller.removeExistingPhoto(path),
            ),
          ),
          ...controller.newPhotos.map(
            (file) => _photoThumb(
              image: Image.file(
                file,
                width: Dimensions.w(80),
                height: Dimensions.w(80),
                fit: BoxFit.cover,
              ),
              onRemove: () => controller.removeNewPhoto(file),
            ),
          ),
          if (controller.totalPhotoCount < EditPostController.maxPhotos)
            GestureDetector(
              onTap: controller.pickImage,
              child: Container(
                width: Dimensions.w(80),
                height: Dimensions.w(80),
                decoration: BoxDecoration(
                  color: AppColors.textFieldBackgroundColor,
                  borderRadius: BorderRadius.circular(Dimensions.r(10)),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Icon(Icons.add_a_photo_outlined, color: Colors.grey[600]),
              ),
            ),
        ],
      ),
    );
  }

  Widget _photoThumb({required Widget image, required VoidCallback onRemove}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(borderRadius: BorderRadius.circular(Dimensions.r(10)), child: image),
        Positioned(
          top: -6,
          right: -6,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(color: Colors.black87, shape: BoxShape.circle),
              child: const Icon(Icons.close_rounded, size: 14, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
