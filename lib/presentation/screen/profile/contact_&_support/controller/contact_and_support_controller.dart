import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jeebjab/service/api_service.dart';
import 'package:jeebjab/service/api_url.dart';
import 'package:jeebjab/widget/show_snackbar.dart';
import '../../../../../utils/static_strings/static_strings.dart';

class ContactAndSupportController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final ApiClient _apiClient = ApiClient();

  final RxBool isLoading = false.obs;

  /// POST contact support message
  Future<void> submitContactSupport() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    final body = {
      "name": nameController.text.trim(),
      "email": emailController.text.trim(),
      "message": descriptionController.text.trim(),
    };

    final response = await _apiClient.post(
      url: ApiUrl.postContactSupport,
      body: body,
      isToken: true,
    );

    isLoading.value = false;

    if (response.statusCode == 200 || response.statusCode == 201) {
      _clearFields();
      ShowAppSnackBar.success(
        AppStrings.thankYouSendMessageRequest,
        title: AppStrings.appName,
      );
    } else {
      final msg = response.body?['message'] ?? 'Something went wrong';
      ShowAppSnackBar.fail(
        msg.toString(),
        title: AppStrings.appName,
      );
    }
  }

  void _clearFields() {
    nameController.clear();
    emailController.clear();
    descriptionController.clear();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
