import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../service/api_service.dart';
import '../../../../../../service/api_url.dart';
import '../model/home_model.dart';

class HomeController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  final RxBool isLoading = false.obs;
  final Rxn<HomeModel> homeData = Rxn<HomeModel>();

  @override
  void onInit() {
    super.onInit();
    fetchHome();
  }

  Future<void> fetchHome() async {
    // Only show the full-screen spinner on the very first load — a
    // pull-to-refresh already has its own indicator.
    if (homeData.value == null) isLoading.value = true;
    try {
      final response = await _apiClient.get(
        url: ApiUrl.getUserHome,
        isToken: true,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        homeData.value = HomeModel.fromJson(response.body);
      }
    } catch (e) {
      debugPrint("Error fetching home: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
