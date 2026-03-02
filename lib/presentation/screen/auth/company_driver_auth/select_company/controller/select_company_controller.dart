import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectCompanyController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController selectCompanyController = TextEditingController();
  final TextEditingController idController = TextEditingController();

  // ── Company list — add/remove companies here ──────────────────────────────
  final List<String> companyList = [
    'Google',
    'Microsoft',
    'Apple',
    'Amazon',
    'Tesla',
    'Meta',
    'Netflix',
    'Uber',
    'Airbnb',
    'Spotify',
  ];

  @override
  void onClose() {
    selectCompanyController.dispose();
    idController.dispose();
    super.onClose();
  }
}