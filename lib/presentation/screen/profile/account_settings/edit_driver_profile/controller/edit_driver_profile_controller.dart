import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/routes/route_path.dart';

class EditDriverProfileController extends GetxController {
  // ── Driver Info Fields ────────────────────────────────────────────────────
  final TextEditingController driverNameController =
  TextEditingController(text: 'Dianne Russell');
  final TextEditingController licenseNumberController =
  TextEditingController(text: '7725068610');
  final TextEditingController vehicleTypeController =
  TextEditingController(text: 'Truck');
  final TextEditingController brandController =
  TextEditingController(text: 'Man');
  final TextEditingController modelController =
  TextEditingController(text: 'CX-220');
  final TextEditingController contactNumberController =
  TextEditingController(text: '(307) 555-0133');
  final TextEditingController contactEmailController =
  TextEditingController(text: 'jackson.graham@example.com');

  // ── Bank Info Fields ──────────────────────────────────────────────────────
  final TextEditingController bankNameController =
  TextEditingController(text: 'Acme Co.');
  final TextEditingController accountHolderController =
  TextEditingController(text: 'Henry, Arthur');
  final TextEditingController accountNumberController =
  TextEditingController(text: '770 747 9047');

  bool get isValid =>
      driverNameController.text.trim().isNotEmpty &&
          licenseNumberController.text.trim().isNotEmpty;

  void onUpdateProfile() {
    // if (!isValid) return;
    // // TODO: Call API

  }

  @override
  void onClose() {
    driverNameController.dispose();
    licenseNumberController.dispose();
    vehicleTypeController.dispose();
    brandController.dispose();
    modelController.dispose();
    contactNumberController.dispose();
    contactEmailController.dispose();
    bankNameController.dispose();
    accountHolderController.dispose();
    accountNumberController.dispose();
    super.onClose();
  }
}