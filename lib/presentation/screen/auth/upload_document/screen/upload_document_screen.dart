import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../../../core/responsive_layout/dimensions.dart';
import '../../../../../core/responsive_layout/responsive_layout.dart';
import '../../../../../core/routes/route_path.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_text_style/app_text_style.dart';
import '../../../../../utils/static_strings/static_strings.dart';
import '../../../../../widget/app_button.dart';
import '../../../../../widget/app_confirmation_alert.dart';
import '../../../../../widget/app_text_field.dart';
import '../../../../../widget/confirmataion_alert.dart';
import '../../../../../widget/custom_appbar.dart';
import '../controller/upload_document_controller.dart';
import '../widget/upload_image_widget.dart';

class UploadDocumentScreen extends StatefulWidget {
  const UploadDocumentScreen({super.key});

  @override
  State<UploadDocumentScreen> createState() => _UploadDocumentScreenState();
}

class _UploadDocumentScreenState extends State<UploadDocumentScreen> {
  UploadDocumentController controller = Get.put(UploadDocumentController());

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
                AppStrings.uploadDocument.tr,
                style: AppTextStyles.body.copyWith(
                  fontSize: 24,
                  color: AppColors.blackColor,
                ),
              ),

              Text(
                AppStrings.uploadDocumentSubTitle.tr,
                style: AppTextStyles.title.copyWith(
                  fontSize: 16,
                  color: AppColors.blackColor,
                ),
              ),

              SizedBox(height: Dimensions.h(40)),

              UploadImageWidget(controller: controller),

              SizedBox(height: Dimensions.h(100)),

              AppButton(
                height: Dimensions.h(70),
                label: AppStrings.continueButton.tr,
                onPressed: () {
                  AppAlerts.confirm(
                    title: AppStrings.success.tr,
                    message: AppStrings.accountCreateSuccess.tr,
                    onConfirm: () {
                      Get.toNamed(RoutePath.login);
                    },
                  );
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