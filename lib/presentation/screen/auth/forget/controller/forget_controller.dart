import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../service/api_service.dart';
import '../../../../../service/api_url.dart';
import '../../../../../core/routes/route_path.dart';

import '../../../../../helper/tost_message/show_snackbar.dart';

class ForgetController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  final ApiClient apiClient = ApiClient();
  var isLoading = false.obs;

  @override
  void onClose() {
    emailController.dispose();
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
      final response = await apiClient.post(
        url: ApiUrl.forgotPassword,
        body: {
          "email": emailController.text.trim(),
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        String successMessage = response.body['message'] ?? "OTP sent successfully to your email.";
        AppSnackBar.success(successMessage, title: "Success");

        // Pass the email to the verification screen so it can be used for OTP verification
        Get.toNamed(RoutePath.customerVerification, arguments: emailController.text.trim());
      } else {
        String errorMessage = response.body['message'] ?? response.statusText ?? "Failed to send OTP. Please try again.";
        AppSnackBar.fail(errorMessage, title: "Error");
      }
    } catch (e) {
      AppSnackBar.fail("An unexpected error occurred. Please try again.", title: "Error");
    } finally {
      isLoading.value = false;
    }
  }
}