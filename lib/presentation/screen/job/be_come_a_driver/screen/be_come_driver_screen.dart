import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import 'package:jeebjab/widget/app_button.dart';
import 'package:jeebjab/widget/custom_appbar.dart';

import '../controller/be_come_driver_controller.dart';
import '../widget/driver_type_card.dart';

class BecomeDriverScreen extends StatefulWidget {
  const BecomeDriverScreen({super.key});

  @override
  State<BecomeDriverScreen> createState() => _BecomeDriverScreenState();
}

class _BecomeDriverScreenState extends State<BecomeDriverScreen> {
  final BecomeDriverController controller = Get.put(BecomeDriverController());

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
      appBar: CommonAppBar(title: AppStrings.becomeADriver.tr),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.w(20),
              vertical: Dimensions.h(20),
            ),
            child: DriverTypeCard(controller: controller),
          ),

          SizedBox(height: Dimensions.h(50)),

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.w(20),
            ),
            child: AppButton(
              label: AppStrings.continueButton.tr,
              onPressed: controller.onContinue,
              height: 65,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTablet() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.becomeADriver.tr),
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
                  AppStrings.becomeADriver.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor,
                  ),
                ),

                SizedBox(height: Dimensions.h(12)),

                // ── Subtitle ────────────────────────────────────────
                Text(
                  "Choose your preferred driver type and get started",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[600],
                  ),
                ),

                SizedBox(height: Dimensions.h(48)),

                // ── Driver Type Card ────────────────────────────────
                DriverTypeCard(controller: controller),

                SizedBox(height: Dimensions.h(60)),

                // ── Continue Button ────────────────────────────────
                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    label: AppStrings.continueButton.tr,
                    onPressed: controller.onContinue,
                    height: Dimensions.h(100),
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