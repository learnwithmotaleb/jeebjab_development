import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import 'package:jeebjab/widget/app_button.dart';
import 'package:jeebjab/widget/custom_appbar.dart';

import '../controller/edit_driver_profile_controller.dart';

import '../widget/editable_info_section_widget.dart';

class EditDriverProfileScreen extends StatefulWidget {
  const EditDriverProfileScreen({super.key});

  @override
  State<EditDriverProfileScreen> createState() =>
      _EditDriverProfileScreenState();
}

class _EditDriverProfileScreenState extends State<EditDriverProfileScreen> {
  final EditDriverProfileController controller =
  Get.put(EditDriverProfileController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobile: _buildMobile());
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.edit.tr),
      body: Column(
        children: [
          // ── Scrollable Content ──────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.w(10),
                vertical: Dimensions.h(10),
              ),
              child: Column(
                children: [
                  // ── Driver Information ──────────────────────────────
                  EditableInfoSection(
                    sectionTitle: AppStrings.driverInformation.tr,
                    rows: [
                      EditableInfoRow(
                        label: AppStrings.driverName.tr,

                        controller: controller.driverNameController,
                      ),
                      EditableInfoRow(
                        label: AppStrings.licenseNumber.tr,
                        controller: controller.licenseNumberController,
                        keyboardType: TextInputType.number,
                      ),
                      EditableInfoRow(
                        label: AppStrings.vehicleType.tr,
                        controller: controller.vehicleTypeController,
                      ),
                      EditableInfoRow(
                        label: AppStrings.brand.tr,
                        controller: controller.brandController,
                      ),
                      EditableInfoRow(
                        label: AppStrings.model.tr,
                        controller: controller.modelController,
                      ),
                      EditableInfoRow(
                        label: AppStrings.contactNumber.tr,
                        controller: controller.contactNumberController,
                        keyboardType: TextInputType.phone,
                      ),
                      EditableInfoRow(
                        label:AppStrings.contactEmail.tr,
                        controller: controller.contactEmailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ],
                  ),

                  SizedBox(height: Dimensions.h(16)),

                  // ── Bank Information ────────────────────────────────
                  EditableInfoSection(
                    sectionTitle: AppStrings.bankInformation.tr,
                    rows: [
                      EditableInfoRow(
                        label: AppStrings.bankName.tr,
                        controller: controller.bankNameController,
                      ),
                      EditableInfoRow(
                        label: AppStrings.accountHolderName.tr,
                        controller: controller.accountHolderController,
                      ),
                      EditableInfoRow(
                        label:AppStrings.accountNumber.tr,
                        controller: controller.accountNumberController,
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),

                  SizedBox(height: Dimensions.h(24)),
                ],
              ),
            ),
          ),

          // ── Update Profile Button pinned bottom ─────────────────────
          Padding(
            padding: EdgeInsets.fromLTRB(
              Dimensions.w(16),
              Dimensions.h(8),
              Dimensions.w(16),
              Dimensions.h(24),
            ),
            child: AppButton(label: AppStrings.updateProfile.tr,  onPressed: controller.onUpdateProfile,
            height: 65,)



          ),
        ],
      ),
    );
  }
}