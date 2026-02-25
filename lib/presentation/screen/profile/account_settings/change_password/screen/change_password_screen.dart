import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/presentation/screen/profile/account_settings/change_password/controller/change_password_controller.dart';
import 'package:jeebjab/utils/app_text_style/app_text_style.dart';
import 'package:jeebjab/widget/app_button.dart';
import 'package:jeebjab/widget/app_text_field.dart';
import 'package:jeebjab/widget/custom_appbar.dart';

import '../../../../../../core/responsive_layout/responsive_layout.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../widget/show_snackbar.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  ChangePasswordController controller = Get.put(ChangePasswordController());
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobile(),
    );
  }
  /// Mobile Layout
  Widget _buildMobile() {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: CommonAppBar(title: 'Change Password'),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
                children: [

                  SizedBox(height: Dimensions.h(20),),


                  AppTextField(
                    controller: controller.previousPassword,
                    hint: "Previous Password",
                    hintTextStyle: AppTextStyles.hint,


                  ),
                  SizedBox(height: Dimensions.h(12),),
                  AppTextField(controller: controller.newPassword,
                    hint: "New Password",
                    hintTextStyle: AppTextStyles.hint,
                  ),
                  SizedBox(height: Dimensions.h(12),),

                  AppTextField(controller: controller.confirmPassword,
                    hint: "Old Password",
                    hintTextStyle: AppTextStyles.hint,

                  ),

                  SizedBox(height: Dimensions.h(50),),

                  AppButton(
                      label: "Change Password",
                      onPressed: (){

                        ShowAppSnackBar.info("Password Change Successful",title: "JeebJab");
                      },
                    height: 65,

                  )








                ]
            ),
          ),
        )
    );
  }
}
