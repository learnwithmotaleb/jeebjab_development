import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LicenseNumberController extends GetxController {
  final licenseNumber = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    licenseNumber.dispose();
    super.onClose();
  }
}