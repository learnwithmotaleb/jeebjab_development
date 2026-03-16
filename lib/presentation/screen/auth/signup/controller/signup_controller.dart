import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jeebjab/helper/local_db/role_selection_controller.dart';

import '../../../../../core/enums/app_role.dart';

class SignupController extends GetxController{
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();


  final FocusNode nameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode confirmPasswordFocus = FocusNode();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    nameFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();

    super.dispose();
  }

  bool validateForm() {
    final isValid = formKey.currentState?.validate() ?? false;
    if (isValid) {
      formKey.currentState?.save();
    }
    return isValid;
  }

  final role = RoleSelectionController();

  Future<void> selectCustomer() async {

    role.selectRole(AppRole.CUSTOMER).then((value){
      print("Set Successfully Role Customer");
    });
  }

  void selectDriver()async{
    role.selectRole(AppRole.DRIVER).then((value){
      print("Set Successfully Role Driver");
    });


  }

  void submit() {
    if (validateForm()) {
      // Form is valid → proceed to login
      print("Namer: ${nameController.text}");
      print("Email: ${emailController.text}");
      print("Password: ${passwordController.text}");
      print("Confirm Password: ${confirmPasswordController.text}");
    }
  }



}