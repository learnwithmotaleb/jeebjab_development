import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/routes/route_path.dart';

import '../../../../../service/api_service.dart';
import '../../../../../service/api_url.dart';

import '../../../../../helper/tost_message/show_snackbar.dart';

class ResetPasswordController extends GetxController {
  /// Text controllers
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  /// Focus nodes
  final newPasswordFocus = FocusNode();
  final confirmPasswordFocus = FocusNode();

  var isNewPasswordHidden = true.obs;
  var isConfirmPasswordHidden = true.obs;

  /// Loading state
  var isLoading = false.obs;

  /// Form key
  final formKey = GlobalKey<FormState>();

  final ApiClient apiClient = ApiClient();

  late String email;

  @override
  void onInit() {
    super.onInit();
    // Retrieve email passed from OTP verification screen
    final args = Get.arguments;
    if (args is Map) {
      email = args['email'] ?? "";
    } else {
      email = args?.toString() ?? "";
    }
  }

  void toggleNewPassword() => isNewPasswordHidden.value = !isNewPasswordHidden.value;
  void toggleConfirmPassword() => isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;

  /// ====================== RESET PASSWORD ======================
  Future<void> resetPassword() async {
    newPasswordFocus.unfocus();
    confirmPasswordFocus.unfocus();

    if (!(formKey.currentState?.validate() ?? false)) return;

    if (email.isEmpty) {
      AppSnackBar.fail("Email address is missing. Please go back and try again.", title: "Error");
      return;
    }

    isLoading.value = true;

    try {
      final response = await apiClient.post(
        url: ApiUrl.resetPassword,
        body: {
          "email": email,
          "newPassword": newPasswordController.text,
          "confirmPassword": confirmPasswordController.text,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final message = response.body['message'] ?? "Password has been reset successfully.";
        AppSnackBar.success(message, title: "Success");
        Get.toNamed(RoutePath.completeVarification);
      } else {
        final errorMessage = response.body['message'] ?? response.statusText ?? "Failed to reset password. Please try again.";
        AppSnackBar.fail(errorMessage, title: "Error");
      }
    } catch (e) {
      AppSnackBar.fail("An unexpected error occurred. Please try again.", title: "Error");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    newPasswordFocus.dispose();
    confirmPasswordFocus.dispose();
    super.onClose();
  }
}