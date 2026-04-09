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
  State<VehicleInformationScreen> createState() =>
      _VehicleInformationScreenState();
}

class _VehicleInformationScreenState extends State<VehicleInformationScreen> {
  VehicleInformationController controller =
  Get.put(VehicleInformationController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobile(),
      tablet: _buildTablet(),
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
                  AppStrings.yourVehicleInformation.tr,
                  style: AppTextStyles.title
              ),

              Text(
                  AppStrings.enterYourVehicleInformation.tr,
                  style: AppTextStyles.body
              ),

              SizedBox(height: Dimensions.h(40)),

              AppTextField(
                controller: controller.vehicleBrand,
                hint: AppStrings.vehicleBrand.tr,
              ),
              SizedBox(height: Dimensions.h(20)),

              AppTextField(
                controller: controller.vehicleModel,
                hint: AppStrings.vehicleModel.tr,
              ),

              SizedBox(height: Dimensions.h(100)),

              AppButton(
                height: Dimensions.h(50),
                label: AppStrings.continueButton.tr,
                onPressed: () {
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
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: ""),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.w(48),
          vertical: Dimensions.h(32),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 520),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Dimensions.h(20)),

                // ── Icon/Visual ──────────────────────────────────────
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(Dimensions.r(20)),
                    ),
                    child: Icon(
                      Icons.directions_car_outlined,
                      size: 50,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),

                SizedBox(height: Dimensions.h(40)),

                // ── Title ────────────────────────────────────────────
                Center(
                  child: Text(
                    AppStrings.yourVehicleInformation.tr,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.title.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: Dimensions.h(12)),

                // ── Subtitle ────────────────────────────────────────
                Center(
                  child: Text(
                    AppStrings.enterYourVehicleInformation.tr,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body.copyWith(
                      fontSize: 15,
                      color: Colors.grey[600],
                    ),
                  ),
                ),

                SizedBox(height: Dimensions.h(40)),

                // ── Vehicle Brand Field ─────────────────────────────
                AppTextField(
                  controller: controller.vehicleBrand,
                  hint: AppStrings.vehicleBrand.tr,
                ),

                SizedBox(height: Dimensions.h(20)),

                // ── Vehicle Model Field ─────────────────────────────
                AppTextField(
                  controller: controller.vehicleModel,
                  hint: AppStrings.vehicleModel.tr,
                ),

                SizedBox(height: Dimensions.h(60)),

                // ── Continue Button ──────────────────────────────────
                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    height: Dimensions.h(100),
                    label: AppStrings.continueButton.tr,
                    onPressed: () {
                      Get.toNamed(RoutePath.licenseNumber);
                    },
                  ),
                ),

                SizedBox(height: Dimensions.h(32)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}