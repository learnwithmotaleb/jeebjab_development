import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/utils/assets_image/app_images.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import 'package:jeebjab/widget/app_button.dart';
import 'package:jeebjab/widget/custom_appbar.dart';

import '../controller/language_controller.dart';

class ProfileLanguageScreen extends StatefulWidget {
  const ProfileLanguageScreen({super.key});

  @override
  State<ProfileLanguageScreen> createState() => _ProfileLanguageScreenState();
}

class _ProfileLanguageScreenState extends State<ProfileLanguageScreen> {
  final ProfileLanguageController lsc = Get.put(ProfileLanguageController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobile: _buildMobile());
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.language.tr),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.w(16)),
        child: Column(
          children: [
            SizedBox(height: Dimensions.h(20)),

            // ── Arabic ─────────────────────────────────────────────
            _LanguageOptionRow(
              flag: AppImages.arabic,
              title: AppStrings.arabic.tr, // still uses the key — value is "Arabic"
              value: 'ar',               // ← fixed: was 'el'
              controller: lsc,
            ),

            SizedBox(height: Dimensions.h(12)),

            // ── English ────────────────────────────────────────────
            _LanguageOptionRow(
              flag: AppImages.english,
              title: AppStrings.english.tr,
              value: 'en',
              controller: lsc,
            ),

            SizedBox(height: Dimensions.h(300)),

            // ── Change Language Button ─────────────────────────────
            AppButton(
              label: 'Change Language',
              height: 65,
              onPressed: () async {
                await lsc.applyLanguage(); // ← saves + updates locale
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageOptionRow extends StatelessWidget {
  final String flag;
  final String title;
  final String value;
  final ProfileLanguageController controller;

  const _LanguageOptionRow({
    required this.flag,
    required this.title,
    required this.value,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelected = controller.selectedLanguage.value == value;
      return GestureDetector(
        onTap: () => controller.changeLanguage(value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.w(14),
            vertical: Dimensions.h(12),
          ),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(Dimensions.r(10)),
            border: Border.all(
              color: isSelected ? AppColors.primaryColor : const Color(0xFFE0E0E0),
            ),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: Dimensions.r(10),
                backgroundImage: AssetImage(flag),
                backgroundColor: const Color(0xFFF0F0F0),
              ),
              SizedBox(width: Dimensions.w(14)),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: Dimensions.f(15),
                    fontWeight: FontWeight.w500,
                    color: AppColors.labelColor,
                  ),
                ),
              ),
              Icon(
                isSelected
                    ? Icons.check_circle_outline_rounded
                    : Icons.radio_button_unchecked_rounded,
                size: Dimensions.w(22),
                color: isSelected ? AppColors.primaryColor : const Color(0xFFCCCCCC),
              ),
            ],
          ),
        ),
      );
    });
  }
}