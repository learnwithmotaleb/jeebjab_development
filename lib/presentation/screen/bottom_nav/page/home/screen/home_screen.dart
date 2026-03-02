import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/utils/app_text_style/app_text_style.dart';
import 'package:jeebjab/utils/assets_image/app_images.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import 'package:jeebjab/widget/app_button.dart';

import '../../../../../../core/responsive_layout/responsive_layout.dart';
import '../../../../../../global/language/controller/language_controller.dart';
import '../../../../../../utils/app_colors/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final lc = Get.find<LanguageController>(); // ← find, not put

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobile: _buildMobile());
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: Dimensions.h(30),
                horizontal: Dimensions.w(20),
              ),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Dimensions.w(30)),
                  bottomRight: Radius.circular(Dimensions.w(30)),
                ),
              ),
              child: Column(
                children: [
                  Image.asset(AppImages.appLogo, width: 80, height: 80),
                  SizedBox(height: Dimensions.h(15)),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: GestureDetector(
                      onTap: () => Get.toNamed(RoutePath.profile),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage(AppImages.profileImage),
                      ),
                    ),
                    title: Text(
                      "Rayyan Hassan",
                      style: AppTextStyles.title.copyWith(
                        fontSize: 18,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    subtitle: Text(
                      "rayyan6352@mail.com",
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.whiteColor.withOpacity(0.8),
                      ),
                    ),
                    trailing: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(1000),
                      ),
                      child: GestureDetector(
                        onTap: () => Get.toNamed(RoutePath.notification),
                        child: Icon(
                          Icons.notifications_on,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: Dimensions.h(20)),

            // Stats Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: _statCard(
                      value: "30 Sec",
                      label: AppStrings.averageResponse.tr,
                      borderRadius: BorderRadius.only(
                        topLeft: lc.isEnglish ? const Radius.circular(30) : Radius.zero,
                        bottomLeft: lc.isEnglish ? const Radius.circular(30) : Radius.zero,
                        topRight: lc.isEnglish ? Radius.zero : const Radius.circular(30),
                        bottomRight: lc.isEnglish ? Radius.zero : const Radius.circular(30),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: _statCard(
                      value: "1.3M",
                      label: AppStrings.deliveriesAndPickups.tr,
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: _statCard(
                      value: "720,000",
                      label: AppStrings.reduceCarRides.tr,
                      borderRadius: BorderRadius.only(
                        topRight: lc.isEnglish ? const Radius.circular(30) : Radius.zero,
                        bottomRight: lc.isEnglish ? const Radius.circular(30) : Radius.zero,
                        topLeft: lc.isEnglish ? Radius.zero : const Radius.circular(30),
                        bottomLeft: lc.isEnglish ? Radius.zero : const Radius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: Dimensions.h(20)),

            // Welcome Text
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.welcomeToJibJab.tr,
                    style: AppTextStyles.title.copyWith(
                      fontSize: 18,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: Dimensions.h(10)),
                  Text(
                    AppStrings.welcomeToJibJabSubTitle.tr,
                    style: AppTextStyles.body.copyWith(color: Colors.black87),
                  ),
                ],
              ),
            ),

            SizedBox(height: Dimensions.h(20)),

            // Banner Image
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 180,
                  margin: EdgeInsets.symmetric(horizontal: Dimensions.w(20)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.w(20)),
                    image: DecorationImage(
                      image: AssetImage(AppImages.homeImage1),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  left: Dimensions.w(30),
                  top: Dimensions.h(50),
                  child: Text(
                    AppStrings.lifeMakeEasier.tr,
                    style: AppTextStyles.title.copyWith(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: Dimensions.h(20)),

            // How it Works
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.howItWorks.tr,
                    style: AppTextStyles.title.copyWith(fontSize: 18),
                  ),
                  SizedBox(height: Dimensions.h(10)),
                  Text(
                    AppStrings.howItWorksSteps.tr,
                    style: AppTextStyles.body.copyWith(color: Colors.black87),
                  ),
                ],
              ),
            ),

            SizedBox(height: Dimensions.h(20)),

            // What's New
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w(20)),
              child: Text(
                AppStrings.whatsNew.tr,
                style: AppTextStyles.title.copyWith(
                  fontSize: 18,
                  color: AppColors.primaryColor,
                ),
              ),
            ),

            SizedBox(height: Dimensions.h(30)),

            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 180,
                  margin: EdgeInsets.symmetric(horizontal: Dimensions.w(20)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.w(20)),
                    image: DecorationImage(
                      image: AssetImage(AppImages.homeImage1),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  left: Dimensions.w(30),
                  top: Dimensions.h(50),
                  child: Text(
                    AppStrings.lifeMakeEasier.tr,
                    style: AppTextStyles.title.copyWith(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Dimensions.h(10)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w(20)),
              child: Text(AppStrings.promoText.tr),
            ),

            SizedBox(height: Dimensions.h(30)),

            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 180,
                  margin: EdgeInsets.symmetric(horizontal: Dimensions.w(20)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.w(20)),
                    image: DecorationImage(
                      image: AssetImage(AppImages.homeImage1),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  left: Dimensions.w(30),
                  top: Dimensions.h(50),
                  child: Text(
                    AppStrings.lifeMakeEasier.tr,
                    style: AppTextStyles.title.copyWith(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Dimensions.h(10)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w(20)),
              child: Text(AppStrings.promoText.tr),
            ),

            SizedBox(height: Dimensions.h(10)),
            Center(
              child: TextButton(
                onPressed: () => Get.toNamed(RoutePath.readMore),
                child: Text(
                  AppStrings.readMore.tr,
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            SizedBox(height: Dimensions.h(30)),
          ],
        ),
      ),
    );
  }

  Widget _statCard({
    required String value,
    required String label,
    required BorderRadius borderRadius,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: borderRadius,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  size: 12,
                  color: Color(0xFF1CBCB4),
                ),
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    height: 1.3,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}