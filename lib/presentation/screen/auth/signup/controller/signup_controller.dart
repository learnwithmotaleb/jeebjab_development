import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jeebjab/helper/local_db/role_selection_controller.dart';

import '../../../../../core/enums/app_role.dart';
import '../../../../../core/routes/route_path.dart';
import '../../../../../widget/app_validation.dart';

class SignupController extends GetxController{
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final emailError = RxnString();
  final passwordError = RxnString();

  final passwordStrength = 0.0.obs;

  void checkStrength(String value) {
    int score = 0;

    if (value.length >= 6) score++;
    if (RegExp(r'[A-Z]').hasMatch(value)) score++;
    if (RegExp(r'[0-9]').hasMatch(value)) score++;
    if (RegExp(r'[!@#\$%^&*]').hasMatch(value)) score++;

    passwordStrength.value = score / 4;
  }


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

  void validateEmail(String value) {
    emailError.value = AppValidators.email()(value);
  }

  void validatePassword(String value) {
    passwordError.value = AppValidators.password()(value);
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
      Get.toNamed(RoutePath.customerVerification);
      print("Namer: ${nameController.text}");
      print("Email: ${emailController.text}");
      print("Password: ${passwordController.text}");
      print("Confirm Password: ${confirmPasswordController.text}");
    }
  }



}