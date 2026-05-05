import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../service/api_service.dart';
import '../../../../../../service/api_url.dart';


import '../../../../../../helper/tost_message/show_snackbar.dart';

class ChangePasswordController extends GetxController {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController previousPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  var isLoading = false.obs;
  final ApiClient apiClient = ApiClient();

  bool validateForm() {
    final isValid = formKey.currentState?.validate() ?? false;
    if (isValid) formKey.currentState?.save();
    return isValid;
  }

  Future<void> submit() async {
    if (!validateForm()) return;

    isLoading.value = true;
    try {
      final response = await apiClient.patch(
        url: ApiUrl.changePassword,
        isToken: true,
        body: {
          "oldPassword": previousPassword.text,
          "newPassword": newPassword.text,
          "confirmPassword": confirmPassword.text,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final message = response.body['message'] ?? "Password changed successfully!";
        AppSnackBar.success(message, title: "Success");

        Get.close(2);
      } else {
        final errorMessage = response.body['message'] ?? response.statusText ?? "Failed to change password. Please try again.";
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
    previousPassword.dispose();
    newPassword.dispose();
    confirmPassword.dispose();
    super.onClose();
  }
}