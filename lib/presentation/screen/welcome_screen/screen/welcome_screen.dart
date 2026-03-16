import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:jeebjab/utils/assets_image/app_images.dart';

import '../../../../core/responsive_layout/dimensions.dart';
import '../../../../core/responsive_layout/responsive_layout.dart';
import '../../../../core/routes/route_path.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/app_text_style/app_text_style.dart';
import '../../../../utils/static_strings/static_strings.dart';
import '../../../../widget/app_button.dart';
import '../../../../widget/custom_appbar.dart';
import '../controller/welcome_controller.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  WelcomeController controller = Get.put(WelcomeController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobile(),
      tablet: _buildTablet(),
      desktop: _buildDesktop(),
    );
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: ""),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Image.asset(AppImages.welcomeImage),
              SizedBox(height: Dimensions.h(20)),


              Align(
                alignment: AlignmentGeometry.center,

                child: Text(
                  AppStrings.welcomeBack.tr,
                  style: AppTextStyles.title.copyWith(
                      fontWeight: FontWeight.normal,
                      color: AppColors.blackColor,
                      fontSize: 30
                  ),
                ),
              ),

              SizedBox(height: Dimensions.h(10)),

              Align(
                alignment: AlignmentGeometry.center,
                child: Text(
                  AppStrings.yourPasswordHasBeeChangedContinueToLogin.tr,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body,
                ),
              ),




              SizedBox(height:  Dimensions.h(100)),


              /// Continue Button
              AppButton(
                height: Dimensions.h(70),

                label: AppStrings.continueButton.tr,
                onPressed: (){

                  //Get.toNamed(RoutePath.uploadDocument);
                },




              ),
            ],
          ),
        ),
      ),
    );
  }




  Widget _buildTablet() {
    return Scaffold(body: Center(child: Text("Hello, Tablet, Login")));
  }

  Widget _buildDesktop() {
    return Scaffold(body: Center(child: Text("Hello, Desktop Login")));
  }
}
