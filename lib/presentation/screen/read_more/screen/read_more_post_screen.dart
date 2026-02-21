import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';
import 'package:jeebjab/widget/custom_appbar.dart';

import '../../../../core/responsive_layout/dimensions.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/app_text_style/app_text_style.dart';
import '../../../../utils/assets_image/app_images.dart';

class ReadMoreScreen extends StatefulWidget {
  const ReadMoreScreen({super.key});

  @override
  State<ReadMoreScreen> createState() => _ReadMoreScreenState();
}

class _ReadMoreScreenState extends State<ReadMoreScreen> {
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
        appBar: CommonAppBar(title: "What’s New",titleColor: AppColors.primaryColor,),
        body: SingleChildScrollView(
          child: Column(
              children: [
                SizedBox(height: Dimensions.h(20)),

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
                        style: AppTextStyles.title.copyWith(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
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
                        style: AppTextStyles.title.copyWith(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.h(10)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w(20)),

                  child: Text("Use code DELIVERY20 to get 20% off your next delivery order. Whether it's food, "
                      "groceries, or a new gadget, we’ve got you covered"
                      "Valid till: January 31, 2026 Order now and save big!"),
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
                        style: AppTextStyles.title.copyWith(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.h(10)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w(20)),

                  child: Text("Use code DELIVERY20 to get 20% off your next delivery order. Whether it's food, "
                      "groceries, or a new gadget, we’ve got you covered"
                      "Valid till: January 31, 2026 Order now and save big!"),
                ),

                SizedBox(height: Dimensions.h(10)),

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
                        style: AppTextStyles.title.copyWith(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.h(10)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w(20)),

                  child: Text("Use code DELIVERY20 to get 20% off your next delivery order. Whether it's food, "
                      "groceries, or a new gadget, we’ve got you covered"
                      "Valid till: January 31, 2026 Order now and save big!"),
                ),
                SizedBox(height: Dimensions.h(10)),

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
                        style: AppTextStyles.title.copyWith(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.h(10)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w(20)),

                  child: Text("Use code DELIVERY20 to get 20% off your next delivery order. Whether it's food, "
                      "groceries, or a new gadget, we’ve got you covered"
                      "Valid till: January 31, 2026 Order now and save big!"),
                ),


                SizedBox(height: Dimensions.h(40)),

              ]
          ),
        )
    );
  }
}
