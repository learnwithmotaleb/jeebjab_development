import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/presentation/screen/profile/contact_&_support/controller/contact_and_support_controller.dart';
import 'package:jeebjab/utils/app_text_style/app_text_style.dart';
import 'package:jeebjab/widget/app_button.dart';
import 'package:jeebjab/widget/app_text_field.dart';
import 'package:jeebjab/widget/custom_appbar.dart';
import 'package:jeebjab/widget/show_snackbar.dart';

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
    );
  }
  /// Mobile Layout
  Widget _buildMobile() {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: CommonAppBar(title: "Contact And Support"),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
                children: [
                  SizedBox(height: Dimensions.h(10),),


                  AppTextField(

                      controller: controller.nameController,
                    hint: "Enter Name",
                    hintTextStyle: AppTextStyles.hint,

                  ),
                  SizedBox(height: Dimensions.h(16),),

                  AppTextField(
                      controller: controller.emailController,
                    hint: "Enter E-mail",
                    hintTextStyle: AppTextStyles.hint,

                  ),
                  SizedBox(height: Dimensions.h(16),),

                  AppTextField(
                    controller: controller.descriptionController,
                    hint: "Write Message",
                    hintTextStyle: AppTextStyles.hint,
                  maxLines: 4,

                  ),


                  SizedBox(height: Dimensions.h(30),),
                  AppButton(label: "Contact", onPressed: (){
                    ShowAppSnackBar.success(
                      title: "Jeebjab",
                        "Thank you. Send Message Request");


                  },

                  height: 65,)



                ]
            ),
          ),
        )
    );
  }
}
