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
                  style: AppTextStyles.title
              ),

              Text(
                  AppStrings.uploadDocumentSubTitle.tr,
                  style: AppTextStyles.body
              ),

              SizedBox(height: Dimensions.h(40)),

              UploadImageWidget(
                controller: controller,
                docType: 'driving_license',
                label: AppStrings.drivingLicense.tr,
              ),
              
              SizedBox(height: Dimensions.h(24)),

              UploadImageWidget(
                controller: controller,
                docType: 'vehicle_registration',
                label: AppStrings.vehicleRegistration.tr,
              ),

              SizedBox(height: Dimensions.h(80)),

              Obx(() => AppButton(
                height: Dimensions.h(50),
                label: AppStrings.continueButton.tr,
                isLoading: controller.isLoading.value,
                onPressed: () {
                  controller.submitBecomeDriver();
                },
              )),
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
            constraints: const BoxConstraints(maxWidth: 520),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                  child: const Icon(
                    Icons.upload_file_outlined,
                    size: 50,
                    color: AppColors.primaryColor,
                  ),
                ),

                SizedBox(height: Dimensions.h(40)),

                // ── Title ────────────────────────────────────────────
                Text(
                  AppStrings.uploadDocument.tr,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.title.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: Dimensions.h(12)),

                // ── Subtitle ────────────────────────────────────────
                Text(
                  AppStrings.uploadDocumentSubTitle.tr,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body.copyWith(
                    fontSize: 15,
                    color: Colors.grey[600],
                  ),
                ),

                SizedBox(height: Dimensions.h(40)),

                // ── Upload Image Widgets ─────────────────────────────
                UploadImageWidget(
                  controller: controller,
                  docType: 'driving_license',
                  label: AppStrings.drivingLicense.tr,
                ),
                
                SizedBox(height: Dimensions.h(24)),

                UploadImageWidget(
                  controller: controller,
                  docType: 'vehicle_registration',
                  label: AppStrings.vehicleRegistration.tr,
                ),

                SizedBox(height: Dimensions.h(60)),

                // ── Continue Button ──────────────────────────────────
                SizedBox(
                  width: double.infinity,
                  child: Obx(() => AppButton(
                    height: Dimensions.h(100),
                    label: AppStrings.continueButton.tr,
                    isLoading: controller.isLoading.value,
                    onPressed: () {
                      controller.submitBecomeDriver();
                    },
                  )),
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