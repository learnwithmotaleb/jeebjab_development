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
            constraints: BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: Dimensions.h(20)),

                // ── Icon/Visual ──────────────────────────────────────
                Container(
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

                SizedBox(height: Dimensions.h(40)),

                // ── Title ────────────────────────────────────────────
                Text(
                  AppStrings.chooseYourVehicleType.tr,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.title.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: Dimensions.h(12)),

                // ── Subtitle ────────────────────────────────────────
                Text(
                  AppStrings.selectAVehicleToContinue.tr,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body.copyWith(
                    fontSize: 15,
                    color: Colors.grey[600],
                  ),
                ),

                SizedBox(height: Dimensions.h(40)),

                // ── Vehicle Options Grid (2 columns) ─────────────────
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2.5,
                    crossAxisSpacing: Dimensions.w(16),
                    mainAxisSpacing: Dimensions.h(16),
                  ),
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    final isSelected = selectedIndex == index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryColor
                              : AppColors.whiteColor,
                          border: Border.all(
                            color: AppColors.primaryColor.withOpacity(0.3),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(Dimensions.r(16)),
                        ),
                        child: Center(
                          child: Text(
                            options[index].tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? AppColors.whiteColor
                                  : AppColors.blackColor,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: Dimensions.h(48)),

                // ── Continue Button ──────────────────────────────────
                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    height: Dimensions.h(100),
                    label: AppStrings.continueButton.tr,
                    onPressed: selectedIndex == -1
                        ? () {}
                        : () {
                      print("Selected: ${options[selectedIndex]}");
                      Get.toNamed(RoutePath.vehicleInformation);
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