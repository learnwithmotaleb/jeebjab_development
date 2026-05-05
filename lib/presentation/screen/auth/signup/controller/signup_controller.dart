import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/helper/local_db/role_selection_controller.dart';

import '../../../../../core/enums/app_role.dart';
import '../../../../../core/routes/route_path.dart';
import '../../../../../service/api_service.dart';
import '../../../../../service/api_url.dart';
import '../../../../../widget/app_validation.dart';

import '../../../../../helper/tost_message/show_snackbar.dart';

class SignupController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final emailError = RxnString();
  final passwordError = RxnString();
  final passwordStrength = 0.0.obs;
  var isLoading = false.obs;

  final ApiClient apiClient = ApiClient();
  final role = RoleSelectionController();

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
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();
    super.onClose();
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

  Future<void> selectCustomer() async {
    await role.selectRole(AppRole.CUSTOMER);
  }

  void selectDriver() async {
    await role.selectRole(AppRole.DRIVER);
  }

  Future<void> submit() async {
    if (!validateForm()) return;

    isLoading.value = true;

    try {
      final response = await apiClient.post(
        url: ApiUrl.register,
        body: {
          "name": nameController.text.trim(),
          "email": emailController.text.trim(),
          "password": passwordController.text,
          "confirmPassword": confirmPasswordController.text,
          "role": "USER",
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final message = response.body['message'] ?? "Account created successfully. Please check your email.";
        AppSnackBar.success(message, title: "Success");
        // Pass the email to the verification screen
        Get.toNamed(RoutePath.accountActiveVerification, arguments: emailController.text.trim());
      } else {
        final errorMessage = response.body['message'] ?? response.statusText ?? "Registration failed. Please try again.";
        AppSnackBar.fail(errorMessage, title: "Registration Failed");
      }
    } catch (e) {
      AppSnackBar.fail("An unexpected error occurred. Please try again.", title: "Error");
    } finally {
      isLoading.value = false;
    }
  }
}
