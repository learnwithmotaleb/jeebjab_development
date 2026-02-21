import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/utils/app_text_style/app_text_style.dart';
import 'package:jeebjab/utils/assets_image/app_images.dart';
import 'package:jeebjab/widget/app_button.dart';

import '../../../../../../core/responsive_layout/responsive_layout.dart';
import '../../../../../../utils/app_colors/app_colors.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobile: _buildMobile());
  }

  /// Mobile Layout
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
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage(AppImages.profileImage),
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
                        onTap: () {
                          Get.toNamed(RoutePath.notification);
                        },

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
                  // Left Container - Rounded on left side
                  Expanded(
                    child: _statCard(
                      value: "30 Sec",
                      label: "Average\nResponse",
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5), // Small gap between containers
                  // Center Container - No rounded corners
                  Expanded(
                    child: _statCard(
                      value: "1.3M",
                      label: "Deliveries\n& Pickups",
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  const SizedBox(width: 5), // Small gap between containers
                  // Right Container - Rounded on right side
                  Expanded(
                    child: _statCard(
                      value: "720,000",
                      label: "Reduce\nCar Rides",
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(30),
                        bottomRight: Radius.circular(30),
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
                    "Welcome to JibJab",
                    style: AppTextStyles.title.copyWith(
                      fontSize: 18,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: Dimensions.h(10)),
                  Text(
                    "JibJab is the easiest way to get help with everything you need to be moved, recycled, or delivered. Through the app, you instantly connect with other ID-verified JibJab members who are ready to help you.",
                    style: AppTextStyles.body.copyWith(color: Colors.black87),
                  ),
                ],
              ),
            ),

            SizedBox(height: Dimensions.h(20)),

            // Banner Image with overlay
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
                    "Life Make Easier\nEverything You Need, All In One App.",
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
                    "How it works:",
                    style: AppTextStyles.title.copyWith(fontSize: 18),
                  ),
                  SizedBox(height: Dimensions.h(10)),
                  Text(
                    "1. Take a photo of what you need help with.\n"
                    "2. Set the price you are willing to pay.\n"
                    "3. Select a Helper to do the job.\n\n"
                    "⚡ Quick and easy: Most users get a request to be helped within minutes, and are helped within a few hours.\n"
                    "💵 Simple and secure payments: Posting an ad is free and payments are securely made within the app after the task is completed.",
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
                "What's New",
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
                    "Life Make Easier\nEverything You Need, All In One App.",
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

              child: Text(
                "Use code DELIVERY20 to get 20% off your next delivery order. Whether it's food, "
                "groceries, or a new gadget, we’ve got you covered"
                "Valid till: January 31, 2026 Order now and save big!",
              ),
            ),

            SizedBox(height: Dimensions.h(30)),
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
                    "Life Make Easier\nEverything You Need, All In One App.",
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

              child: Text(
                "Use code DELIVERY20 to get 20% off your next delivery order. Whether it's food, "
                "groceries, or a new gadget, we’ve got you covered"
                "Valid till: January 31, 2026 Order now and save big!",
              ),
            ),

            SizedBox(height: Dimensions.h(10)),
            Center(
              child: TextButton(
                onPressed: () {
                  Get.toNamed(RoutePath.readMore);
                },
                child: Text(
                  "Read More",
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
        color: AppColors.primaryColor, // Teal color from the image
        borderRadius: borderRadius,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Value text
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),

          // Check icon and label
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Check icon
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
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

              // Label text
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
