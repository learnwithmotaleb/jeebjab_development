import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/utils/app_text_style/app_text_style.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import 'package:jeebjab/widget/custom_appbar.dart';

import '../../../../../core/responsive_layout/responsive_layout.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../widget/app_button.dart';
import '../widget/selectable_button.dart';

class ChooseVehicleTypeScreen extends StatefulWidget {
  const ChooseVehicleTypeScreen({super.key});

  @override
  State<ChooseVehicleTypeScreen> createState() =>
      _ChooseVehicleTypeScreenState();
}

class _ChooseVehicleTypeScreenState extends State<ChooseVehicleTypeScreen> {
  int selectedIndex = 0;

  final List<String> options = [
    AppStrings.car,
    AppStrings.van,
    AppStrings.pickup,
    AppStrings.truck,
  ];

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
                AppStrings.chooseYourVehicleType.tr,
                style: AppTextStyles.title,
              ),

              Text(
                AppStrings.selectAVehicleToContinue.tr,
                style: AppTextStyles.body.copyWith(

                ),
              ),

              SizedBox(height: Dimensions.h(40)),

              ...List.generate(options.length, (index) {
                final isSelected = selectedIndex == index;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: AppButton(
                    height: Dimensions.h(50),
                    label: options[index].tr,
                    onPressed: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    borderSideColor: isSelected
                        ? AppColors.whiteColor.withOpacity(0.5)
                        : AppColors.whiteColor.withOpacity(0.5),
                    borderRadius: 20,
                    backgroundColor:
                    isSelected ? AppColors.primaryColor : Colors.white,
                    textColor:
                    isSelected ? AppColors.whiteColor : AppColors.blackColor,
                  ),
                );
              }),

              SizedBox(height: Dimensions.h(70)),

              AppButton(
                height: Dimensions.h(50),
                label: AppStrings.continueButton.tr,
                onPressed: selectedIndex == -1
                    ? () {}
                    : () {
                  print("Selected: ${options[selectedIndex]}");
                  Get.toNamed(RoutePath.vehicleInformation);
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