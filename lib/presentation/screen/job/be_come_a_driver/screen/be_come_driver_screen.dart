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
    return ResponsiveLayout(mobile: _buildMobile());
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: 'Become A Driver'),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.w(20),
              vertical: Dimensions.h(20),
            ),
            child: DriverTypeCard(controller: controller),
          ),

          SizedBox(height: Dimensions.h(20)),

          Obx(
            () => Padding(
              padding: EdgeInsets.fromLTRB(
                Dimensions.w(16),
                0,
                Dimensions.w(16),
                Dimensions.h(24),
              ),

              child: AppButton(
                label: AppStrings.continueButton.tr,
                onPressed: controller.onContinue,
                height: 65,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
