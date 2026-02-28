import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jeebjab/widget/show_snackbar.dart';

import '../../../../../core/enums/app_role.dart';
import '../../../../../core/routes/route_path.dart';
import '../../../../../helper/local_db/local_db.dart';
import '../../../../../service/api_service.dart';
import '../../../../../service/api_url.dart';
import '../../signup/controller/signup_controller.dart';

class CustomerVerificationController extends GetxController{
  final otpController = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool isLoadingResend = false.obs;


  final role = SharePrefsHelper.getRole();
  final token = SharePrefsHelper.getToken();


  Future<void> emailVerifyProcess() async {



    // if (role == AppRole.CUSTOMER) {
    //   print("Customer");
    //   Get.toNamed(RoutePath.customerVerification);
    // } else if (role == AppRole.DRIVER) {
    //   print("Driver");
    //
    //   Get.toNamed(RoutePath.driverVerification);
    // } else {
    //   print("No role set");
    //
    //   Get.toNamed(RoutePath.reset);
    // }

    Get.toNamed(RoutePath.completeVarification);







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