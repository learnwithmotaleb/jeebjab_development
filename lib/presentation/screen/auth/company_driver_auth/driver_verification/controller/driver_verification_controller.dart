import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jeebjab/widget/show_snackbar.dart';

import '../../../../../../core/routes/route_path.dart';
import '../../../../../../helper/local_db/local_db.dart';
import '../../../../../../service/api_service.dart';
import '../../../../../../service/api_url.dart';

class DriverVerificationController extends GetxController {
  final otpController = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool isLoadingResend = false.obs;

  final ApiClient apiClient = ApiClient();

  late String email;

  @override
  void onInit() {
    super.onInit();
    // Email passed from the driver signup screen
    email = Get.arguments ?? "";
  }

  Future<void> emailVerifyProcess() async {
    final otp = otpController.text.trim();
    if (otp.length != 6) {
      ShowAppSnackBar.fail(
        "Please enter a valid 6-digit OTP",
        title: "OTP verification",
      );
      return;
    }

    if (email.isEmpty) {
      ShowAppSnackBar.fail(
        "Email address is missing. Please go back and try again.",
        title: "Error",
      );
      return;
    }

    try {
      isLoading.value = true;

      final response = await apiClient.post(
        url: ApiUrl.accountActive,
        body: {"activationCode": otp, "email": email},
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

        ShowAppSnackBar.success(
          response.body["message"] ?? "OTP verified successfully",
          title: "OTP verified",
        );

        // Continue on to the driver's company selection step
        Get.toNamed(RoutePath.selectCompany);
      } else {
        ShowAppSnackBar.fail(
          response.body["message"] ?? "OTP verification failed",
          title: "OTP verification",
        );
      }
    } catch (e) {
      ShowAppSnackBar.fail("Error: $e", title: "OTP verification");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resendOtpProcess() async {
    if (email.isEmpty) return;

    isLoadingResend.value = true;
    try {
      final response = await apiClient.post(
        url: ApiUrl.accountActiveCodeResend,
        body: {"email": email},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ShowAppSnackBar.success(
          "Activation code resent to $email",
          title: "Success",
        );
      } else {
        ShowAppSnackBar.fail(
          response.body["message"] ??
              "Failed to resend code. Please try again.",
          title: "Error",
        );
      }
    } catch (e) {
      ShowAppSnackBar.fail(
        "An unexpected error occurred. Please try again.",
        title: "Error",
      );
    } finally {
      isLoadingResend.value = false;
    }
  }

  @override
  void onClose() {
    // Dispose controllers & focus nodes to prevent memory leaks
    otpController.dispose();
    super.onClose();
  }
}
