import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:jeebjab/core/routes/route_path.dart';

import '../../../../../core/enums/app_role.dart';
import '../../../../../helper/local_db/local_db.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();




  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  bool validateForm() {
    final isValid = formKey.currentState?.validate() ?? false;
    if (isValid) {
      formKey.currentState?.save();
    }
    return isValid;
  }

  void submit() {
    // if (validateForm()) {
    //   // Form is valid → proceed to login
    //   print("Email: ${emailController.text}");
    //   print("Password: ${passwordController.text}");
    // }

    final role = SharePrefsHelper.getRole();


    if (role == AppRole.CUSTOMER) {
      Get.offAllNamed(RoutePath.bottomNav);
    } else if (role == AppRole.DRIVER) {
      Get.offAllNamed(RoutePath.driverBottomNav);
    } else {
      Get.offAllNamed(RoutePath.signup);
    }
    // Get.toNamed(RoutePath.bottomNav);
  }
}
