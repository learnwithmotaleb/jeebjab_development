import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
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
      appBar: CommonAppBar(title: "Edit"),
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
                    sectionTitle: 'Driver Information',
                    rows: [
                      EditableInfoRow(
                        label: 'Driver Name',
                        controller: controller.driverNameController,
                      ),
                      EditableInfoRow(
                        label: 'License Number',
                        controller: controller.licenseNumberController,
                        keyboardType: TextInputType.number,
                      ),
                      EditableInfoRow(
                        label: 'Vehicle Type',
                        controller: controller.vehicleTypeController,
                      ),
                      EditableInfoRow(
                        label: 'Brand',
                        controller: controller.brandController,
                      ),
                      EditableInfoRow(
                        label: 'Model',
                        controller: controller.modelController,
                      ),
                      EditableInfoRow(
                        label: 'Contact Number',
                        controller: controller.contactNumberController,
                        keyboardType: TextInputType.phone,
                      ),
                      EditableInfoRow(
                        label: 'Contact Email',
                        controller: controller.contactEmailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ],
                  ),

                  SizedBox(height: Dimensions.h(16)),

                  // ── Bank Information ────────────────────────────────
                  EditableInfoSection(
                    sectionTitle: 'Bank Information',
                    rows: [
                      EditableInfoRow(
                        label: 'Bank Name',
                        controller: controller.bankNameController,
                      ),
                      EditableInfoRow(
                        label: 'Account Holder Name',
                        controller: controller.accountHolderController,
                      ),
                      EditableInfoRow(
                        label: 'Account Number',
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
            child: AppButton(label: 'Update Profile',  onPressed: controller.onUpdateProfile,
            height: 65,)



          ),
        ],
      ),
    );
  }
}