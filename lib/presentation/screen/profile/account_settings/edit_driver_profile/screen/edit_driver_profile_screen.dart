import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import 'package:jeebjab/widget/app_button.dart';
import 'package:jeebjab/widget/custom_appbar.dart';

import '../controller/edit_driver_profile_controller.dart';

import '../widget/document_upload_section_widget.dart';
import '../widget/editable_info_section_widget.dart';

class EditDriverProfileScreen extends StatefulWidget {
  const EditDriverProfileScreen({super.key});

  @override
  State<EditDriverProfileScreen> createState() =>
      _EditDriverProfileScreenState();
}

class _EditDriverProfileScreenState extends State<EditDriverProfileScreen> {
  final EditDriverProfileController controller = Get.put(
    EditDriverProfileController(),
  );

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobile: _buildMobile());
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.edit.tr),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
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
                    // ── Driver Information (editable, sent to the API) ──
                    EditableInfoSection(
                      sectionTitle: AppStrings.driverInformation.tr,
                      rows: [
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
                          label: "Vehicle Year",
                          controller: controller.vehicleYearController,
                          keyboardType: TextInputType.number,
                        ),
                        EditableInfoRow(
                          label: AppStrings.licenseNumber.tr,
                          controller: controller.licenseNumberController,
                        ),
                      ],
                    ),

                    SizedBox(height: Dimensions.h(16)),

                    // ── Documents (driving_license / vehicle_registration / insurance) ──
                    Obx(
                      () => DocumentUploadSection(
                        sectionTitle: "Documents",
                        rows: [
                          DocumentUploadRowData(
                            label: "Driving License",
                            pickedFile:
                                controller.documentFiles['driving_license'],
                            alreadyUploaded:
                                controller.alreadyUploaded['driving_license'] ??
                                false,
                            onPick: () =>
                                controller.pickDocument('driving_license'),
                            onRemove: () =>
                                controller.removeDocument('driving_license'),
                          ),
                          DocumentUploadRowData(
                            label: "Vehicle Registration",
                            pickedFile: controller
                                .documentFiles['vehicle_registration'],
                            alreadyUploaded:
                                controller
                                    .alreadyUploaded['vehicle_registration'] ??
                                false,
                            onPick: () =>
                                controller.pickDocument('vehicle_registration'),
                            onRemove: () => controller.removeDocument(
                              'vehicle_registration',
                            ),
                          ),
                          DocumentUploadRowData(
                            label: "Insurance",
                            pickedFile: controller.documentFiles['insurance'],
                            alreadyUploaded:
                                controller.alreadyUploaded['insurance'] ??
                                false,
                            onPick: () => controller.pickDocument('insurance'),
                            onRemove: () =>
                                controller.removeDocument('insurance'),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: Dimensions.h(16)),

                    // ── Contact (read-only — not part of this endpoint) ──
                    EditableInfoSection(
                      sectionTitle: "Contact",
                      rows: [
                        EditableInfoRow(
                          label: AppStrings.driverName.tr,
                          controller: controller.driverNameController,
                          readOnly: true,
                        ),
                        EditableInfoRow(
                          label: AppStrings.contactNumber.tr,
                          controller: controller.contactNumberController,
                          keyboardType: TextInputType.phone,
                          readOnly: true,
                        ),
                        EditableInfoRow(
                          label: AppStrings.contactEmail.tr,
                          controller: controller.contactEmailController,
                          keyboardType: TextInputType.emailAddress,
                          readOnly: true,
                        ),
                      ],
                    ),

                    SizedBox(height: Dimensions.h(16)),

                    // ── Bank Information (read-only — not part of this endpoint) ──
                    EditableInfoSection(
                      sectionTitle: AppStrings.bankInformation.tr,
                      rows: [
                        EditableInfoRow(
                          label: AppStrings.bankName.tr,
                          controller: controller.bankNameController,
                          readOnly: true,
                        ),
                        EditableInfoRow(
                          label: AppStrings.accountHolderName.tr,
                          controller: controller.accountHolderController,
                          readOnly: true,
                        ),
                        EditableInfoRow(
                          label: AppStrings.accountNumber.tr,
                          controller: controller.accountNumberController,
                          keyboardType: TextInputType.number,
                          readOnly: true,
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
              child: Obx(
                () => AppButton(
                  label: AppStrings.updateProfile.tr,
                  onPressed: controller.onUpdateProfile,
                  isLoading: controller.isUpdating.value,
                  height: 65,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
