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
    return ResponsiveLayout(
      mobile: _buildMobile(),
      tablet: _buildTablet(),
    );
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

  Widget _buildTablet() {
    return Scaffold(
      appBar: CommonAppBar(title: ''),
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.w(48),
          vertical: Dimensions.h(32),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 520),
            child: Column(
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
                      Icons.business_outlined,
                      size: 50,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),

                SizedBox(height: Dimensions.h(40)),

                // ── Title ────────────────────────────────────────────
                Center(
                  child: Text(
                    AppStrings.selectCompany.tr,
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
                    AppStrings.enterYourInformation.tr,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body.copyWith(
                      fontSize: 15,
                      color: Colors.grey[600],
                    ),
                  ),
                ),

                SizedBox(height: Dimensions.h(40)),

                // ── Company selector → opens bottom sheet ────────────
                BottomSheetTextField(
                  controller: controller.selectCompanyController,
                  label: AppStrings.selectYourCompany.tr,
                  items: controller.companyList, // ✅ from controller
                ),

                SizedBox(height: Dimensions.h(18)),

                // ── ID field ────────────────────────────────────────
                AppTextField(
                  controller: controller.idController,
                  hint: AppStrings.id.tr,
                  keyboardType: TextInputType.text,
                  validator: AppValidators.required(),
                  onTap: () {},
                ),

                SizedBox(height: Dimensions.h(60)),

                // ── Continue button ──────────────────────────────────
                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    label: AppStrings.continueButton.tr,
                    height: Dimensions.h(100),
                    borderRadius: Dimensions.r(16),
                    onPressed: () => Get.toNamed(RoutePath.vehicleType),
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