import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:jeebjab/widget/custom_appbar.dart';

import '../../../../../../core/responsive_layout/dimensions.dart';
import '../../../../../../core/responsive_layout/responsive_layout.dart';
import '../../../../../../core/routes/route_path.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_text_style/app_text_style.dart';
import '../../../../../../widget/app_button.dart';
import '../../../../../../widget/app_text_field.dart';
import '../../../../../../widget/app_validation.dart';
import '../controller/driver_signup_controller.dart';

class DriverSignupScreen extends StatefulWidget {
  const DriverSignupScreen({super.key});

  @override
  State<DriverSignupScreen> createState() => _DriverSignupScreenState();
}

class _DriverSignupScreenState extends State<DriverSignupScreen> {

  final controller = Get.put(DriverSignupController());


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
              Text("Fill the information",style: AppTextStyles.body.copyWith(
                fontSize: 24,
                color: AppColors.blackColor,
              ),),

              SizedBox(height: Dimensions.h(30)),




              AppTextField(
                controller: controller.nameController,
                focusNode: controller.nameFocus,
                hint: "Enter Your Name",
                keyboardType: TextInputType.name,
                validator: AppValidators.required(),
                onSubmitted: () {
                  controller.submit(); // ✅ submit form on Don

                },
                onTap: () {},
              ),
              SizedBox(height: Dimensions.h(16)),
              // Email Field
              AppTextField(
                controller: controller.emailController,
                focusNode: controller.emailFocus,
                hint: "Enter Email Address",
                keyboardType: TextInputType.emailAddress,
                validator: AppValidators.email(),
                onSubmitted: () {
                  controller.submit(); // ✅ submit form on Don

                },
                onTap: () {},
              ),
              SizedBox(height: Dimensions.h(16)),

              // Password Field
              AppTextField(
                controller: controller.passwordController,
                focusNode: controller.passwordFocus,
                hint: "Enter Password",
                obscure: true,
                validator: AppValidators.required(),
                onTap: () {},
              ),
              SizedBox(height: Dimensions.h(24)),


              // Password Field
              AppTextField(
                controller: controller.confirmPasswordController,
                focusNode: controller.confirmPasswordFocus,
                hint: "Confirm Password",
                obscure: true,
                validator: AppValidators.required(),
                onTap: () {},
              ),
              SizedBox(height: Dimensions.h(24)),

              // Sign In Button
              AppButton(
                label: "Create Account",
                height: Dimensions.h(55),
                borderRadius: Dimensions.r(16),
                onPressed: () {
                  //controller.submit();
                  Get.toNamed(RoutePath.driverVerification);
                },
              ),




            ],
          ),
        ),
      ),
    );
  }
}
