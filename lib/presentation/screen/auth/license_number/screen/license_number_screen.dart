import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:jeebjab/core/routes/route_path.dart';

import '../../../../../core/responsive_layout/dimensions.dart';
import '../../../../../core/responsive_layout/responsive_layout.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_text_style/app_text_style.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../../../../../widget/app_button.dart';
import '../../../../../widget/app_text_field.dart';
import '../../../../../widget/custom_appbar.dart';
import '../controller/license_number_controller.dart';

class LicenseNumberScreen extends StatefulWidget {
  const LicenseNumberScreen({super.key});

  @override
  State<LicenseNumberScreen> createState() => _LicenseNumberScreenState();
}

class _LicenseNumberScreenState extends State<LicenseNumberScreen> {
  LicenseNumberController controller = Get.put(LicenseNumberController());

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
              Text(
                AppStrings.yourLicenseNumber.tr,
                style: AppTextStyles.title
              ),

              Text(
                AppStrings.licenseNumberSubTitle.tr,
                style: AppTextStyles.body
              ),

              SizedBox(height: Dimensions.h(40)),

              AppTextField(
                controller: controller.licenseNumber,
                hint: AppStrings.enterLicenseNumber.tr,
              ),

              SizedBox(height: Dimensions.h(100)),

              AppButton(
                height: Dimensions.h(50),
                label: AppStrings.continueButton.tr,
                onPressed: () {
                  Get.toNamed(RoutePath.uploadDocument);
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