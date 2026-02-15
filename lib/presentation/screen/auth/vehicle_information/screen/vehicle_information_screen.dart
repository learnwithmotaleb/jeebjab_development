import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/widget/app_text_field.dart';

import '../../../../../core/responsive_layout/dimensions.dart';
import '../../../../../core/responsive_layout/responsive_layout.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_text_style/app_text_style.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../../../../../widget/app_button.dart';
import '../../../../../widget/custom_appbar.dart';
import '../controller/vehicle_information_controller.dart';

class VehicleInformationScreen extends StatefulWidget {
  const VehicleInformationScreen({super.key});

  @override
  State<VehicleInformationScreen> createState() => _VehicleInformationScreenState();
}

class _VehicleInformationScreenState extends State<VehicleInformationScreen> {

  VehicleInformationController controller = Get.put(VehicleInformationController());

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

              Text("Your vehicle Information",style: AppTextStyles.body.copyWith(
                  fontSize: 24,
                  color: AppColors.blackColor,
              ),),


              Text("Enter your vehicle information",style: AppTextStyles.title.copyWith(
                  fontSize: 16,
                  color: AppColors.blackColor
              ),),

              SizedBox(height:  Dimensions.h(40)),

              AppTextField(controller: controller.vehicleBrand,
                hint: "Vehicle Brand",

              ),
              SizedBox(height:  Dimensions.h(20)),
              AppTextField(controller: controller.vehicleModel,
                hint: "Vehicle Model",),









              SizedBox(height:  Dimensions.h(100)),

              /// Continue Button
              AppButton(
                height: Dimensions.h(70),

                label: AppStrings.continueButton.tr,
                onPressed: (){

                  Get.toNamed(RoutePath.licenseNumber);
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
