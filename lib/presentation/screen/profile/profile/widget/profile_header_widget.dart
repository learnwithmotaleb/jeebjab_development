import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/utils/app_text_style/app_text_style.dart';
import 'package:jeebjab/utils/assets_image/app_images.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final String name;
  final String email;
  final String? imageAsset;

  const ProfileHeaderWidget({
    super.key,
    required this.name,
    required this.email,
    this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: Dimensions.h(50),
        bottom: Dimensions.h(30),
        left: Dimensions.w(20),
        right: Dimensions.w(20),
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(Dimensions.r(30)),
          bottomRight: Radius.circular(Dimensions.r(30)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ── Title row with back button ───────────────────────────────
          // Row(
          //   children: [
          //     GestureDetector(
          //       onTap: () => Get.back(),
          //       child: const Icon(
          //         Icons.arrow_back_ios_new_rounded,
          //         color: AppColors.whiteColor,
          //         size: 20,
          //       ),
          //     ),
          //      Expanded(
          //       child: Text(
          //        AppStrings.profile.tr,
          //         textAlign: TextAlign.center,
          //         style: TextStyle(
          //           color: AppColors.whiteColor,
          //           fontSize: 18,
          //           fontWeight: FontWeight.w700,
          //         ),
          //       ),
          //     ),
          //     const SizedBox(width: 20),
          //   ],
          // ),

          SizedBox(height: Dimensions.h(20)),

          // ── Avatar ───────────────────────────────────────────────────
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: AppColors.whiteColor.withOpacity(0.4), width: 3),
            ),
            child: CircleAvatar(
              radius: Dimensions.w(38),
              backgroundImage: AssetImage(
                imageAsset ?? AppImages.profileImage,
              ),
            ),
          ),

          SizedBox(height: Dimensions.h(12)),

          // ── Name ─────────────────────────────────────────────────────
          Text(
            name,
            style: TextStyle(
              fontSize: Dimensions.f(18),
              fontWeight: FontWeight.w700,
              color: AppColors.whiteColor,
            ),
          ),

          SizedBox(height: Dimensions.h(4)),

          // ── Email ─────────────────────────────────────────────────────
          Text(
            email,
            style: TextStyle(
              fontSize: Dimensions.f(13),
              color: AppColors.whiteColor.withOpacity(0.85),
            ),
          ),
        ],
      ),
    );
  }
}