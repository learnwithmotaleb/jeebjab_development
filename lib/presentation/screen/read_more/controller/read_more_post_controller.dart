import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../service/api_service.dart';
import '../../../../service/api_url.dart';
import '../../bottom_nav/page/home/model/home_model.dart';

class ReadMoreController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  final RxBool isLoading = false.obs;
  final RxList<WhatsNewItemModel> items = <WhatsNewItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;
    if (args is List<WhatsNewItemModel> && args.isNotEmpty) {
      // Reuse what Home already fetched — no need for a second call.
      items.value = args;
    } else {
      // Reached directly (e.g. deep link) without the list — fetch it.
      fetchWhatsNew();
    }
  }

  /// Also used as the pull-to-refresh callback, so refreshing here
  /// always re-fetches from the server even if we started out with
  /// Home's already-fetched list.
  Future<void> fetchWhatsNew() async {
    isLoading.value = true;
    try {
      final response = await _apiClient.get(
        url: ApiUrl.getUserHome,
        isToken: true,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        items.value = HomeModel.fromJson(response.body).whatsNew;
      }
    } catch (e) {
      debugPrint("Error fetching whatsNew: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
