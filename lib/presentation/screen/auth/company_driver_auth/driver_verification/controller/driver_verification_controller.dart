import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jeebjab/widget/show_snackbar.dart';

import '../../../../../../core/routes/route_path.dart';


class DriverVerificationController extends GetxController{
  final otpController = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool isLoadingResend = false.obs;

  Future<void> emailVerifyProcess() async {
    // final otp = otpController.text.trim();
    // if (otp.length != 6) {
    //   ShowAppSnackBar.fail(title: "OTP verification","Please enter a valid 6-digit OTP");
    //   return;
    // }
    //
    // try {
    //   isLoading.value = true;
    //
    //   final api = ApiClient();


    //   final res = await api.post(
    //     url: ApiUrl.verifyOtp,
    //     isToken: false,
    //     body: {
    //       "email":Get.find<SignupController>().emailController.text,  // <-- Add email here
    //       "otp": otp,
    //     },
    //     isBasic: false,);
    //
    //   isLoading.value = false;
    //
    //   if (res.statusCode == 200 && res.body["success"] == true) {
    //     ShowAppSnackBar.success( title: "OTP verified",  res.body["message"] ?? "OTP verified successfully");
    //     // Get.toNamed(RoutePath.reset);
    //   } else {
    //     ShowAppSnackBar.fail(title: "OTP verification",res.body["message"] ?? "OTP verification failed");
    //   }
    // } catch (e) {
    //   isLoading.value = false;
    //   ShowAppSnackBar.fail(title: "OTP verified", "Error: $e");
    // }


    Get.toNamed(RoutePath.selectCompany);

  }

  resendOtpProcess() async {
    // return await AuthService.resendOtpService(
    //   isLoading: isLoadingResend,
    //   email: Get.find<ForgotController>().emailController.text,
    // );
  }

  @override
  void onClose() {
    // Dispose controllers & focus nodes to prevent memory leaks
    otpController.dispose();
    super.onClose();
  }



}