import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import 'package:jeebjab/widget/app_button.dart';
import 'package:jeebjab/widget/custom_appbar.dart';

import '../controller/edit_profile_controller.dart';
import '../widget/avater_picker_widget.dart';
import '../widget/profile_text_field_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final EditProfileController controller = Get.put(EditProfileController());

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
      appBar: CommonAppBar(title: AppStrings.editProfile.tr),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Dimensions.h(24)),

                  // ── Avatar centered ──────────────────────────────────
                  Center(
                    child: Obx(
                          () => AvatarPickerWidget(
                        pickedImage: controller.pickedImage.value,
                        onTap: controller.pickImage,
                      ),
                    ),
                  ),

                  SizedBox(height: Dimensions.h(32)),

                  // ── Name ─────────────────────────────────────────────
                  ProfileTextField(
                    label: AppStrings.name.tr,
                    controller: controller.nameController,
                  ),

                  SizedBox(height: Dimensions.h(16)),

                  // ── Gender (tap to show bottom sheet) ────────────────
                  ProfileTextField(
                    label: AppStrings.gender.tr,
                    controller: controller.genderController,
                    readOnly: true,
                    onTap: () => _showGenderPicker(context),
                    suffixIcon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.greyColor,
                      size: Dimensions.w(20),
                    ),
                  ),

                  SizedBox(height: Dimensions.h(16)),

                  // ── Date of Birth ─────────────────────────────────────
                  ProfileTextField(
                    label: AppStrings.dateOfBirth.tr,
                    controller: controller.dobController,
                    readOnly: true,
                    onTap: () => controller.pickDate(context),
                    suffixIcon: Icon(
                      Icons.calendar_today_outlined,
                      color: AppColors.greyColor,
                      size: Dimensions.w(18),
                    ),
                  ),

                  SizedBox(height: Dimensions.h(32)),
                ],
              ),
            ),
          ),

          // ── Update Profile Button pinned bottom ───────────────────────
          Padding(
            padding: EdgeInsets.fromLTRB(
              Dimensions.w(16),
              Dimensions.h(8),
              Dimensions.w(16),
              Dimensions.h(24),
            ),
            child: AppButton(
              label: AppStrings.updateProfile.tr,
              onPressed: controller.onUpdateProfile,
              height: 65,
            ),
          ),
          SizedBox(height: Dimensions.h(24)),
        ],
      ),
    );
  }

  Widget _buildTablet() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.editProfile.tr),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.w(48),
                vertical: Dimensions.h(32),
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 520),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Dimensions.h(20)),

                      // ── Icon/Visual ──────────────────────────────────
                      Center(
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(Dimensions.r(20)),
                          ),
                          child: Icon(
                            Icons.person_outline,
                            size: 50,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),

                      SizedBox(height: Dimensions.h(40)),

                      // ── Title ────────────────────────────────────────
                      Center(
                        child: Text(
                          AppStrings.editProfile.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blackColor,
                          ),
                        ),
                      ),

                      SizedBox(height: Dimensions.h(12)),

                      // ── Subtitle ────────────────────────────────────
                      Center(
                        child: Text(
                          "Update your profile information",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),

                      SizedBox(height: Dimensions.h(40)),

                      // ── Avatar centered ──────────────────────────────
                      Center(
                        child: Obx(
                              () => AvatarPickerWidget(
                            pickedImage: controller.pickedImage.value,
                            onTap: controller.pickImage,
                          ),
                        ),
                      ),

                      SizedBox(height: Dimensions.h(40)),

                      // ── Name ────────────────────────────────────────
                      ProfileTextField(
                        label: AppStrings.name.tr,
                        controller: controller.nameController,
                      ),

                      SizedBox(height: Dimensions.h(20)),

                      // ── Gender (tap to show bottom sheet) ────────────
                      ProfileTextField(
                        label: AppStrings.gender.tr,
                        controller: controller.genderController,
                        readOnly: true,
                        onTap: () => _showGenderPicker(context),
                        suffixIcon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: AppColors.greyColor,
                          size: Dimensions.w(20),
                        ),
                      ),

                      SizedBox(height: Dimensions.h(20)),

                      // ── Date of Birth ───────────────────────────────
                      ProfileTextField(
                        label: AppStrings.dateOfBirth.tr,
                        controller: controller.dobController,
                        readOnly: true,
                        onTap: () => controller.pickDate(context),
                        suffixIcon: Icon(
                          Icons.calendar_today_outlined,
                          color: AppColors.greyColor,
                          size: Dimensions.w(18),
                        ),
                      ),

                      SizedBox(height: Dimensions.h(40)),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ── Update Profile Button pinned bottom ──────────────────
          Padding(
            padding: EdgeInsets.fromLTRB(
              Dimensions.w(48),
              Dimensions.h(16),
              Dimensions.w(48),
              Dimensions.h(32),
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 520),
                child: SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    label: AppStrings.updateProfile.tr,
                    onPressed: controller.onUpdateProfile,
                    height: Dimensions.h(100),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: Dimensions.h(20)),
        ],
      ),
    );
  }

  // ── Gender picker bottom sheet ────────────────────────────────────────────
  void _showGenderPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(Dimensions.r(20)),
        ),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.all(Dimensions.w(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: Dimensions.w(40),
              height: Dimensions.h(4),
              decoration: BoxDecoration(
                color: const Color(0xFFDDDDDD),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: Dimensions.h(16)),
            ...controller.genders.map(
                  (g) => ListTile(
                title: Text(
                  g,
                  style: TextStyle(
                    fontSize: Dimensions.f(14),
                    fontWeight: FontWeight.w500,
                    color: AppColors.labelColor,
                  ),
                ),
                trailing: Obx(
                      () => controller.selectedGender.value == g
                      ? Icon(
                    Icons.check_rounded,
                    color: AppColors.primaryColor,
                    size: Dimensions.w(20),
                  )
                      : const SizedBox.shrink(),
                ),
                onTap: () {
                  controller.selectGender(g);
                  Get.back();
                },
              ),
            ),
            SizedBox(height: Dimensions.h(12)),
          ],
        ),
      ),
    );
  }
}