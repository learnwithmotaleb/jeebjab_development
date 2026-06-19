import 'package:get/get.dart';
import 'package:jeebjab/service/api_service.dart';
import 'package:jeebjab/service/api_url.dart';

class TermsAndConditionController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  /// Holds the full terms & conditions content returned from the API
  final RxString termsContent = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTermsAndConditions();
  }

  Future<void> fetchTermsAndConditions() async {
    isLoading.value = true;
    errorMessage.value = '';

    final response = await _apiClient.get(
      url: ApiUrl.getTermAndConditions,
      isToken: true,
    );

    isLoading.value = false;

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = response.body?['data'];
      termsContent.value =
          data?['content'] ?? data?['description'] ?? data?['text'] ?? '';
    } else {
      errorMessage.value =
          response.body?['message']?.toString() ??
          'Failed to load terms and conditions.';
    }
  }
}