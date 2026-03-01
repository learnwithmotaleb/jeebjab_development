import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';

import '../../../../../../core/responsive_layout/dimensions.dart';
import '../../../../../../core/responsive_layout/responsive_layout.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_text_style/app_text_style.dart';
import '../../../../../../widget/app_button.dart';
import '../../../../../../widget/app_text_field.dart';
import '../../../../../../widget/app_validation.dart';
import '../../../../../../widget/bottom_sheet_textfield.dart';
import '../../../../../../widget/custom_appbar.dart';
import '../controller/select_company_controller.dart';

class SelectCompanyScreen extends StatefulWidget {
  const SelectCompanyScreen({super.key});

  @override
  State<SelectCompanyScreen> createState() => _SelectCompanyScreenState();
}

class _SelectCompanyScreenState extends State<SelectCompanyScreen> {
  final controller = Get.put(SelectCompanyController());

  final List<String> companyList = [
    "Google",
    "Microsoft",
    "Apple",
    "Amazon",
    "Tesla",
  ];

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobile(),
    );
  }

  Widget _buildMobile() {
    return Scaffold(
      appBar: CommonAppBar(title: ""),
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.selectCompany.tr,
                style: AppTextStyles.body.copyWith(
                  fontSize: 24,
                  color: AppColors.blackColor,
                ),
              ),

              Text(
                AppStrings.enterYourInformation.tr,
                style: AppTextStyles.body.copyWith(
                  fontSize: 16,
                  color: AppColors.blackColor,
                ),
              ),

              SizedBox(height: Dimensions.h(30)),

              BottomSheetTextField(
                controller: controller.selectCompanyController,
                label: AppStrings.selectYourCompany.tr,
                items: companyList,
              ),

              SizedBox(height: Dimensions.h(16)),

              AppTextField(
                controller: controller.idController,
                hint: AppStrings.id.tr,
                keyboardType: TextInputType.name,
                validator: AppValidators.required(),
                onTap: () {},
              ),

              SizedBox(height: Dimensions.h(50)),

              AppButton(
                label: AppStrings.continueButton.tr,
                height: Dimensions.h(55),
                borderRadius: Dimensions.r(16),
                onPressed: () {
                  Get.toNamed(RoutePath.vehicleType);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}