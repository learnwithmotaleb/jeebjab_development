import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';
import 'package:jeebjab/widget/custom_appbar.dart';

import '../../../../core/responsive_layout/dimensions.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/app_text_style/app_text_style.dart';
import '../../../../utils/assets_image/app_images.dart';
import '../../../../utils/static_strings/static_strings.dart';

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
        appBar: CommonAppBar(title: AppStrings.whatsNew.tr,titleColor: AppColors.primaryColor,),
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
                      left: 0,
                      right: 0,
                      bottom: 0,
                      top: 0,
                      child: Center(
                        child: Text(
                          AppStrings.lifeMakeEasier.tr,
                          style: AppTextStyles.title.copyWith(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: Dimensions.h(10)),

                // How it Works
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Dimensions.h(20)),
                      Text(
                        AppStrings.howItWorksSteps.tr,
                        textAlign: TextAlign.center,
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
                    left: 0,
                      right: 0,
                      bottom: 0,
                      top: 0,
                      child: Center(
                        child: Text(
                          AppStrings.lifeMakeEasier.tr,
                          style: AppTextStyles.title.copyWith(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.h(10)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w(20)),

                  child: Text(AppStrings.promoText.tr,textAlign: TextAlign.center,),
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
                      left: 0,
                      right: 0,
                      bottom: 0,
                      top: 0,
                      child: Center(
                        child: Text(
                            AppStrings.lifeMakeEasier.tr,
                          style: AppTextStyles.title.copyWith(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.h(16)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w(20)),

                  child: Text(AppStrings.promoText.tr,textAlign: TextAlign.center,),
                ),

                SizedBox(height: Dimensions.h(16)),

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
                      left: 0,
                      right: 0,
                      bottom: 0,
                      top: 0,
                      child: Center(
                        child: Text(
                          AppStrings.lifeMakeEasier.tr,
                          style: AppTextStyles.title.copyWith(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.h(16)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w(20)),

                  child: Text(AppStrings.promoText.tr,textAlign: TextAlign.center,),
                ),
                SizedBox(height: Dimensions.h(16)),

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
                      left: 0,
                      right: 0,
                      bottom: 0,
                      top: 0,
                      child: Center(
                        child: Text(
                          AppStrings.lifeMakeEasier.tr,
                          style: AppTextStyles.title.copyWith(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.h(16)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w(20)),

                  child: Text(AppStrings.promoText.tr,textAlign: TextAlign.center,),
                ),


                SizedBox(height: Dimensions.h(40)),

              ]
          ),
        )
    );
  }
}
