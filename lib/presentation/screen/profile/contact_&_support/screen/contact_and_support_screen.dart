import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/presentation/screen/profile/contact_&_support/controller/contact_and_support_controller.dart';
import 'package:jeebjab/utils/app_text_style/app_text_style.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import 'package:jeebjab/widget/app_button.dart';
import 'package:jeebjab/widget/app_text_field.dart';
import 'package:jeebjab/widget/app_validation.dart';
import 'package:jeebjab/widget/custom_appbar.dart';

import '../../../../../core/responsive_layout/responsive_layout.dart';
import '../../../../../utils/app_colors/app_colors.dart';

class ContactAndSupportScreen extends StatefulWidget {
  const ContactAndSupportScreen({super.key});

  @override
  State<ContactAndSupportScreen> createState() => _ContactAndSupportScreenState();
}

class _ContactAndSupportScreenState extends State<ContactAndSupportScreen> {

  ContactAndSupportController controller = Get.put(ContactAndSupportController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobile(),
      tablet: _buildTablet(),
    );
  }

  /// Mobile Layout
  Widget _buildMobile() {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: CommonAppBar(title: AppStrings.contactAndSupport.tr),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                  children: [
                    SizedBox(height: Dimensions.h(10),),

                    AppTextField(
                      controller: controller.nameController,
                      hint: AppStrings.enterName.tr,
                      hintTextStyle: AppTextStyles.hint,
                      validator: AppValidators.required(message: 'Name is required'),
                    ),
                    SizedBox(height: Dimensions.h(16),),

                    AppTextField(
                      controller: controller.emailController,
                      hint: AppStrings.enterEmail.tr,
                      hintTextStyle: AppTextStyles.hint,
                      validator: AppValidators.combine([
                        AppValidators.required(message: 'Email is required'),
                        AppValidators.email(),
                      ]),
                    ),
                    SizedBox(height: Dimensions.h(16),),

                    AppTextField(
                      controller: controller.descriptionController,
                      hint: AppStrings.writeMessage.tr,
                      hintTextStyle: AppTextStyles.hint,
                      maxLines: 4,
                      validator: AppValidators.required(message: 'Message is required'),
                    ),

                    SizedBox(height: Dimensions.h(30),),
                    Obx(() => AppButton(
                      label: AppStrings.contact.tr,
                      onPressed: controller.isLoading.value
                          ? null
                          : () => controller.submitContactSupport(),
                      height: 65,
                      isLoading: controller.isLoading.value,
                    ))
                  ]
              ),
            ),
          ),
        )
    );
  }

  /// Tablet Layout
  Widget _buildTablet() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: AppStrings.contactAndSupport.tr),
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
                      Icons.mail_outline,
                      size: 50,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),

                SizedBox(height: Dimensions.h(40)),

                // ── Section Title ────────────────────────────────────
                Center(
                  child: Text(
                    AppStrings.contactAndSupport.tr,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.title.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: Dimensions.h(12)),

                // ── Section Subtitle ────────────────────────────────
                Center(
                  child: Text(
                    "We'd love to hear from you. Send us a message!",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body.copyWith(
                      fontSize: 15,
                      color: Colors.grey[600],
                    ),
                  ),
                ),

                SizedBox(height: Dimensions.h(40)),

                // ── Name Field ──────────────────────────────────────
                AppTextField(
                  controller: controller.nameController,
                  hint: AppStrings.enterName.tr,
                  hintTextStyle: AppTextStyles.hint,
                ),
                SizedBox(height: Dimensions.h(18)),

                // ── Email Field ─────────────────────────────────────
                AppTextField(
                  controller: controller.emailController,
                  hint: AppStrings.enterEmail.tr,
                  hintTextStyle: AppTextStyles.hint,
                ),
                SizedBox(height: Dimensions.h(18)),

                // ── Message Field ───────────────────────────────────
                AppTextField(
                  controller: controller.descriptionController,
                  hint: AppStrings.writeMessage.tr,
                  hintTextStyle: AppTextStyles.hint,
                  maxLines: 6,
                ),

                SizedBox(height: Dimensions.h(48)),

                // ── Contact Button ──────────────────────────────────
                Obx(() => AppButton(
                  label: AppStrings.contact.tr,
                  onPressed: controller.isLoading.value
                      ? null
                      : () => controller.submitContactSupport(),
                  height: Dimensions.h(100),
                  isLoading: controller.isLoading.value,
                  width: double.infinity,
                )),

                SizedBox(height: Dimensions.h(32)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}