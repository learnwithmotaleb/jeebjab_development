import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/routes/route_path.dart';

class ResetPasswordController extends GetxController{
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

  void toggleNewPassword() => isNewPasswordHidden.value = !isNewPasswordHidden.value;
  void toggleConfirmPassword() => isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;

  /// ====================== CHANGE PASSWORD ======================
  Future<void> resetPassword() async {
    // newPasswordFocus.unfocus();
    // confirmPasswordFocus.unfocus();
    //
    // if (!(formKey.currentState?.validate() ?? false)) return;
    //
    // final newPassword = newPasswordController.text.trim();
    //
    // isLoading.value = true;
    //
    // try {
    //   // TODO: call API here
    //   await Future.delayed(const Duration(seconds: 2));
    //
    //   Get.snackbar("Success", "Password reset successful");
    // } catch (e) {
    //   Get.snackbar("Error", "Something went wrong");
    // } finally {
    //   isLoading.value = false;
    // }
    Get.toNamed(RoutePath.completeVarification);
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