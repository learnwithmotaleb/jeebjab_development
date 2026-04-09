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
      tablet: _buildTablet(),
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
  Widget _buildTablet() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(
        title: AppStrings.whatsNew.tr,
        titleColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w(48)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Dimensions.h(40)),

                  // ── Hero Banner ───────────────────────────────────────────
                  _buildTabletBanner(
                    image: AppImages.homeImage1,
                    text: AppStrings.lifeMakeEasier.tr,
                    height: 300,
                  ),

                  SizedBox(height: Dimensions.h(32)),

                  // ── How it Works Section ──────────────────────────────────
                  Text(
                    AppStrings.howItWorks.tr,
                    style: AppTextStyles.title.copyWith(
                      fontSize: 28,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: Dimensions.h(16)),
                  Text(
                    AppStrings.howItWorksSteps.tr,
                    style: AppTextStyles.body.copyWith(
                      fontSize: 18,
                      color: Colors.black87,
                      height: 1.6,
                    ),
                  ),

                  SizedBox(height: Dimensions.h(48)),

                  // ── Promo Grid ────────────────────────────────────────────
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 30,
                    crossAxisSpacing: 30,
                    childAspectRatio: 0.85,
                    children: [
                      _buildTabletPromoItem(
                        image: AppImages.homeImage1,
                        title: AppStrings.lifeMakeEasier.tr,
                        subtitle: AppStrings.promoText.tr,
                      ),
                      _buildTabletPromoItem(
                        image: AppImages.homeImage1,
                        title: AppStrings.lifeMakeEasier.tr,
                        subtitle: AppStrings.promoText.tr,
                      ),
                      _buildTabletPromoItem(
                        image: AppImages.homeImage1,
                        title: AppStrings.lifeMakeEasier.tr,
                        subtitle: AppStrings.promoText.tr,
                      ),
                      _buildTabletPromoItem(
                        image: AppImages.homeImage1,
                        title: AppStrings.lifeMakeEasier.tr,
                        subtitle: AppStrings.promoText.tr,
                      ),
                    ],
                  ),

                  SizedBox(height: Dimensions.h(60)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabletBanner({required String image, required String text, double height = 220}) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.w(24)),
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.w(24)),
              color: Colors.black.withOpacity(0.3),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.title.copyWith(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabletPromoItem({required String image, required String title, required String subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.w(20)),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.w(20)),
                color: Colors.black.withOpacity(0.2),
              ),
              child: Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.title.copyWith(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: Dimensions.h(16)),
        Text(
          subtitle,
          style: AppTextStyles.body.copyWith(
            fontSize: 16,
            color: Colors.black87,
            height: 1.5,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
