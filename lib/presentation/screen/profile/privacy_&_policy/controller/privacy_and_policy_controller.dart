import 'package:get/get.dart';
import 'package:jeebjab/service/api_service.dart';
import 'package:jeebjab/service/api_url.dart';

class PrivacyAndPolicyController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  /// Holds the full privacy policy content returned from the API
  final RxString privacyContent = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPrivacyPolicy();
  }

  Future<void> fetchPrivacyPolicy() async {
    isLoading.value = true;
    errorMessage.value = '';

    final response = await _apiClient.get(
      url: ApiUrl.getPrivacyAndPolicy,
      isToken: true,
    );

    isLoading.value = false;

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = response.body?['data'];
      // The API may return content in a field like 'content' or 'description'
      privacyContent.value =
          data?['content'] ?? data?['description'] ?? data?['text'] ?? '';
    } else {
      errorMessage.value =
          response.body?['message']?.toString() ??
          'Failed to load privacy policy.';
    }
  }
}
