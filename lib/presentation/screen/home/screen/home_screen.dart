import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/utils/app_text_style/app_text_style.dart';
import 'package:jeebjab/utils/assets_image/app_images.dart';

import '../../../../core/responsive_layout/responsive_layout.dart';
import '../../../../utils/app_colors/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobile(),
    );
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
                padding: EdgeInsets.symmetric(vertical: Dimensions.h(30), horizontal: Dimensions.w(20)),
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
                      title: Text("Rayyan Hassan", style: AppTextStyles.title.copyWith(fontSize: 18, color: AppColors.whiteColor)),
                      subtitle: Text("rayyan6352@mail.com", style: AppTextStyles.body.copyWith(color: AppColors.whiteColor.withOpacity(0.8))),
                      trailing: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(1000),
                        ),
                        child: Icon(Icons.notifications_on, color: AppColors.primaryColor),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: Dimensions.h(20)),

              // Stats Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _statCard("30 Sec", "Average Response"),
                    _statCard("1.3M", "Deliveries & Pickups"),
                    _statCard("720,000", "Reduce Car Rides"),
                  ],
                ),
              ),

              SizedBox(height: Dimensions.h(20)),

              // Welcome Text
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome to JibJab", style: AppTextStyles.title.copyWith(fontSize: 18, color: AppColors.primaryColor)),
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
                        image: AssetImage(AppImages.profileImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    left: Dimensions.w(30),
                    top: Dimensions.h(50),
                    child: Text(
                      "Life Make Easier\nEverything You Need, All In One App.",
                      style: AppTextStyles.title.copyWith(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
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
                    Text("How it works:", style: AppTextStyles.title.copyWith(fontSize: 18)),
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
                child: Text("What's New", style: AppTextStyles.title.copyWith(fontSize: 18, color: AppColors.primaryColor)),
              ),

              SizedBox(height: Dimensions.h(30)),
            ],
          ),
        )
    );
    }

  Widget _statCard(String value, String label) {
    return Expanded(
      child: Container(
        width: Dimensions.w(140),
        padding: EdgeInsets.all(Dimensions.w(12)),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(Dimensions.w(15)),
        ),
        child: Column(
          children: [
            Text(value, style: AppTextStyles.title.copyWith(fontSize: 16, color: AppColors.whiteColor)),
            SizedBox(height: Dimensions.h(5)),
            Text(label, style: AppTextStyles.body.copyWith(fontSize: 12, color: Colors.black87), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }


}
