import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jeebjab/utils/app_text_style/app_text_style.dart';
import 'package:jeebjab/utils/assets_image/app_images.dart';

import '../../../../core/enums/app_role.dart';
import '../../../../core/responsive_layout/dimensions.dart';
import '../../../../core/responsive_layout/responsive_layout.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../widget/app_button.dart';
import '../controller/select_role_controller.dart';

class SelectRoleScreen extends StatefulWidget {
  const SelectRoleScreen({super.key});

  @override
  State<SelectRoleScreen> createState() => _SelectRoleScreenState();
}

class _SelectRoleScreenState extends State<SelectRoleScreen> {



  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobile(),
    );
  }

  /// Mobile Layout
  Widget _buildMobile() {
    SelectRoleController controller = Get.put(SelectRoleController());

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
                child: Center(child: Image.asset(AppImages.appLogo))),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Choose your Role",style: AppTextStyles.title.copyWith(
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 24
                  ),),
                  Text("To Get started",style: AppTextStyles.title.copyWith(
                    color: AppColors.secondaryColor,

                  ),),

                  SizedBox(height: Dimensions.h(40),),


                  Obx(() => AppButton(
                    label: "Customer",
                    backgroundColor:
                    controller.selectedRole.value == AppRole.CUSTOMER
                        ? AppColors.secondaryColor
                        : AppColors.primaryColor,
                    textColor:
                    controller.selectedRole.value == AppRole.CUSTOMER
                        ? AppColors.primaryColor
                        : AppColors.whiteColor,
                    height: Dimensions.h(55),
                    borderSideColor: AppColors.whiteColor,
                    borderRadius: Dimensions.r(16),
                    onPressed: () => controller.selectRole(AppRole.CUSTOMER),
                  )),

                  SizedBox(height: Dimensions.h(20)),

                  Obx(() => AppButton(
                    label: "Driver",
                    backgroundColor:
                    controller.selectedRole.value == AppRole.DRIVER
                        ? AppColors.secondaryColor
                        : AppColors.primaryColor,
                    textColor:
                    controller.selectedRole.value == AppRole.DRIVER
                        ? AppColors.primaryColor
                        : AppColors.whiteColor,
                    height: Dimensions.h(55),
                    borderSideColor: AppColors.whiteColor,
                    borderRadius: Dimensions.r(16),
                    onPressed: () => controller.selectRole(AppRole.DRIVER),
                  )),
                ],


              ),
        
            )
          ],
        ),
      )
    );
  }
}
