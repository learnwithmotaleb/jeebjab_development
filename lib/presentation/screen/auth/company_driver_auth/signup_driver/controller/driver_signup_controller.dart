import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jeebjab/widget/show_snackbar.dart';

import '../../../../../../core/routes/route_path.dart';
import '../../../../../../global/language/controller/language_controller.dart';
import '../../../../../../service/api_service.dart';
import '../../../../../../service/api_url.dart';

class DriverSignupController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final FocusNode nameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode confirmPasswordFocus = FocusNode();

  final ApiClient apiClient = ApiClient();
  RxBool isLoading = false.obs;

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

  bool validateForm() {
    final isValid = formKey.currentState?.validate() ?? false;
    if (isValid) {
      formKey.currentState?.save();
    }
    return isValid;
  }

  Future<void> submit() async {
    if (!validateForm()) return;

    isLoading.value = true;

    try {
      final languageController = Get.isRegistered<LanguageController>()
          ? Get.find<LanguageController>()
          : Get.put(LanguageController());
      final String languageCode = languageController.isEnglish ? "en" : "ar";

      final response = await apiClient.post(
        url: ApiUrl.register,
        body: {
          "name": nameController.text.trim(),
          "email": emailController.text.trim(),
          "password": passwordController.text,
          "confirmPassword": confirmPasswordController.text,
          "language": languageCode,
          // Registration always happens as USER. The driver upgrade
          // request is sent later (from Settings) via ApiUrl.becomeDriver.
          "role": "USER",
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final message =
            response.body['message'] ??
            "Account created successfully. Please check your email.";
        ShowAppSnackBar.success(message, title: "Success");

        // Pass the email to the OTP verification screen
        Get.toNamed(
          RoutePath.driverVerification,
          arguments: emailController.text.trim(),
        );
      } else {
        final errorMessage =
            response.body['message'] ??
            response.statusText ??
            "Registration failed. Please try again.";
        ShowAppSnackBar.fail(errorMessage, title: "Registration Failed");
      }
    } catch (e) {
      ShowAppSnackBar.fail(
        "An unexpected error occurred. Please try again.",
        title: "Error",
      );
    } finally {
      isLoading.value = false;
    }
  }
}
