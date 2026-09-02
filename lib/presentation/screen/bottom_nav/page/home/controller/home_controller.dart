import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../service/api_service.dart';
import '../../../../../../service/api_url.dart';
import '../model/home_model.dart';

class HomeController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  final RxBool isLoading = false.obs;
  final Rxn<HomeModel> homeData = Rxn<HomeModel>();

  // GET /user/home doesn't return an avatar — pulled separately from the
  // real profile endpoint so the header still shows the account's actual
  // photo. Empty = no avatar set, show the placeholder asset.
  final RxString avatarUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchHome();
    _loadAvatar();
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

  Future<void> _loadAvatar() async {
    try {
      final response = await _apiClient.get(
        url: ApiUrl.getUserProfile,
        isToken: true,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final avatar = response.body['data']?['avatar']?.toString();
        if (avatar != null && avatar.isNotEmpty) {
          avatarUrl.value = ApiUrl.buildImageUrl(avatar);
        }
      }
    } catch (e) {
      debugPrint("Error loading user avatar for home: $e");
    }
  }
}
