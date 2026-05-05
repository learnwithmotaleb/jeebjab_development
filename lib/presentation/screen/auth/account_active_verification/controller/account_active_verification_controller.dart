import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/routes/route_path.dart';
import '../../../../../helper/local_db/local_db.dart';
import '../../../../../helper/tost_message/show_snackbar.dart';
import '../../../../../service/api_service.dart';
import '../../../../../service/api_url.dart';

class AccountActiveVerificationController extends GetxController {
  final otpController = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool isLoadingResend = false.obs;

  final role = SharePrefsHelper.getRole();
  final token = SharePrefsHelper.getToken();
  final ApiClient apiClient = ApiClient();

  late String email;

  @override
  void onInit() {
    super.onInit();
    // Retrieve email passed from forget password screen
    email = Get.arguments ?? "";
  }

  Future<void> emailVerifyProcess() async {
    if (otpController.text.length < 6) {
      AppSnackBar.fail("Please enter the 6-digit code.", title: "Invalid Code");
      return;
    }

    if (email.isEmpty) {
      AppSnackBar.fail("Email address is missing. Please go back and try again.", title: "Error");
      return;
    }

    isLoading.value = true;

    try {
      final response = await apiClient.post(
        url: ApiUrl.accountActive,
        body: {
          "activationCode": otpController.text,
          "email": email,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.body['data'];
        if (data != null) {
          final accessToken = data['accessToken'];
          final refreshToken = data['refreshToken'];
          if (accessToken != null) {
            await SharePrefsHelper.saveToken(accessToken);
          }
          if (refreshToken != null) {
            await SharePrefsHelper.saveRefreshToken(refreshToken);
          }
        }

        final message = response.body['message'] ?? "Activation code verified successfully.";
        AppSnackBar.success(message, title: "Success");

        // Navigate to login after successful activation
        Get.offAllNamed(RoutePath.login);
      } else {
        String errorMessage = response.body['message'] ?? response.statusText ?? "Invalid code. Please try again.";
        AppSnackBar.fail(errorMessage, title: "Verification Failed");
      }
    } catch (e) {
      AppSnackBar.fail("An unexpected error occurred. Please try again.", title: "Error");
    } finally {
      isLoading.value = false;
    }
  }

  resendOtpProcess() async {
    if (email.isEmpty) return;

    isLoadingResend.value = true;
    try {
      final response = await apiClient.post(
        url: ApiUrl.accountActiveCodeResend,
        body: {
          "email": email,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        AppSnackBar.success("Activation code resent to $email", title: "Success");
      } else {
        AppSnackBar.fail("Failed to resend code. Please try again.", title: "Error");
      }
    } catch (e) {
      AppSnackBar.fail("An unexpected error occurred. Please try again.", title: "Error");
    } finally {
      isLoadingResend.value = false;
    }
  }

  @override
  void onClose() {
    otpController.dispose();
    super.onClose();
  }
}