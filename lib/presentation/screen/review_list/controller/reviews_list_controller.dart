import 'package:get/get.dart';
import 'package:jeebjab/helper/local_db/local_db.dart';
import 'package:jeebjab/presentation/screen/review_list/model/ReviewModel.dart';
import 'package:jeebjab/service/api_service.dart';
import 'package:jeebjab/service/api_url.dart';

class ReviewsListController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<Reviews> reviews = <Reviews>[].obs;
  final ApiClient _apiClient = ApiClient();

  @override
  void onInit() {
    super.onInit();
    _loadReviews();
  }

  Future<void> _loadReviews() async {
    try {
      isLoading.value = true;
      String? userId = SharePrefsHelper.getUserId();
      if (userId == null) {
        isLoading.value = false;
        return;
      }
      
      final response = await _apiClient.get(url: ApiUrl.userGetReview(userId), isToken: true);
      
      if (response.statusCode == 200) {
        final reviewModel = ReviewModel.fromJson(response.body);
        if (reviewModel.data?.reviews != null) {
          reviews.value = reviewModel.data!.reviews!;
        }
      }
    } catch (e) {
      print("Error loading reviews: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshReviews() async {
    await _loadReviews();
  }
}