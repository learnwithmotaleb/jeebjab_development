import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  final SelectCompanyController controller = Get.put(SelectCompanyController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobile: _buildMobile());
  }

  Widget _buildMobile() {
    return Scaffold(
      appBar: CommonAppBar(title: ''),
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.w(16),
            vertical: Dimensions.h(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Title ───────────────────────────────────────────────
              Text(
                AppStrings.selectCompany.tr,
                style: AppTextStyles.title.copyWith(
                ),
              ),

              Text(
                AppStrings.enterYourInformation.tr,
                style: AppTextStyles.body.copyWith(
                ),
              ),

              SizedBox(height: Dimensions.h(30)),

              // ── Company selector → opens bottom sheet ────────────────
              BottomSheetTextField(
                controller: controller.selectCompanyController,
                label: AppStrings.selectYourCompany.tr,
                items: controller.companyList, // ✅ from controller
              ),

              SizedBox(height: Dimensions.h(16)),

              // ── ID field ────────────────────────────────────────────
              AppTextField(
                controller: controller.idController,
                hint: AppStrings.id.tr,
                keyboardType: TextInputType.text,
                validator: AppValidators.required(),
                onTap: () {},
              ),

              SizedBox(height: Dimensions.h(50)),

              // ── Continue button ──────────────────────────────────────
              AppButton(
                label: AppStrings.continueButton.tr,
                height: Dimensions.h(50),
                borderRadius: Dimensions.r(16),
                onPressed: () => Get.toNamed(RoutePath.vehicleType),
              ),
            ],
          ),
        ),
      ),
    );
  }
}