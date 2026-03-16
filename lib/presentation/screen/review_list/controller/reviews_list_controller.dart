import 'package:get/get.dart';
import 'package:jeebjab/presentation/screen/review_profile/controller/review_profile_controller.dart';

class ReviewsListController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<ReviewModel> reviews = <ReviewModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadReviews();
  }

  void _loadReviews() {
    // TODO: Replace with real API call
    reviews.value = List.generate(
      8,
          (_) => ReviewModel(
        username: 'Tiago_Felipe',
        timeAgo: '1 Day ago',
        rating: 5,
        title: 'There are many variations of passage',
        body:
        'The majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable.',
      ),
    );
  }

  Future<void> refreshReviews() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    _loadReviews();
    isLoading.value = false;
  }
}