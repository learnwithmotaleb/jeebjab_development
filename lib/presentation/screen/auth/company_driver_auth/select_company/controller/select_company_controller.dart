import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/widget/show_snackbar.dart';

import '../../../../../../service/api_service.dart';
import '../../../../../../service/api_url.dart';
import '../model/company_model.dart';

class SelectCompanyController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController selectCompanyController = TextEditingController();
  final TextEditingController idController = TextEditingController();

  final ApiClient apiClient = ApiClient();

  RxBool isLoading = false.obs;
  RxList<CompanyModel> companies = <CompanyModel>[].obs;
  Rxn<CompanyModel> selectedCompany = Rxn<CompanyModel>();

  // Names shown in the bottom sheet picker
  List<String> get companyList => companies.map((e) => e.name).toList();

  @override
  void onInit() {
    super.onInit();
    fetchCompanies();
  }

  Future<void> fetchCompanies() async {
    isLoading.value = true;
    try {
      final response = await apiClient.get(url: ApiUrl.getCompanyPublicList());

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> data = response.body['data'] ?? [];
        companies.value = data
            .map((e) => CompanyModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        ShowAppSnackBar.fail(
          response.body['message'] ?? "Failed to load companies.",
          title: "Error",
        );
      }
    } catch (e) {
      ShowAppSnackBar.fail(
        "An unexpected error occurred while loading companies.",
        title: "Error",
      );
    } finally {
      isLoading.value = false;
    }
  }

  void selectCompanyByName(String name) {
    final company = companies.firstWhereOrNull((e) => e.name == name);
    selectedCompany.value = company;
    selectCompanyController.text = name;
    // Auto-fill the ID box with the selected company's real _id.
    idController.text = company?.id ?? '';
  }

  @override
  void onClose() {
    selectCompanyController.dispose();
    idController.dispose();
    super.onClose();
  }
}
