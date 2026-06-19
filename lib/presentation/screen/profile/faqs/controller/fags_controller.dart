import 'package:get/get.dart';
import 'package:jeebjab/service/api_service.dart';
import 'package:jeebjab/service/api_url.dart';

class FaqsController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  /// Holds the list of FAQs from the API
  final RxList<Map<String, dynamic>> faqsList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchFaqs();
  }

  Future<void> fetchFaqs() async {
    isLoading.value = true;
    errorMessage.value = '';

    final response = await _apiClient.get(url: ApiUrl.getFaq, isToken: true);

    isLoading.value = false;

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = response.body?['data'];

      // Handle both single object and list cases
      if (data is List) {
        faqsList.assignAll(
          data.map((item) => Map<String, dynamic>.from(item as Map)).toList(),
        );
      } else if (data is Map) {
        // If it's a single FAQ object
        faqsList.assignAll([Map<String, dynamic>.from(data)]);
      } else {
        errorMessage.value = 'Unexpected data format.';
      }
    } else {
      errorMessage.value =
          response.body?['message']?.toString() ?? 'Failed to load FAQs.';
    }
  }
}
