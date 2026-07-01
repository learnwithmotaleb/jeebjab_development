import 'package:get/get.dart';

import '../../../../core/routes/route_path.dart';
import '../../../../helper/local_db/local_db.dart';
import '../../../../service/api_service.dart';
import '../../../../service/api_url.dart';
import '../model/ReviewProfileModel.dart';

class ReviewProfileController extends GetxController {
  // ── API Client ─────────────────────────────────────────────────────────────
  final ApiClient _apiClient = ApiClient();

  // ── Profile Info ──────────────────────────────────────────────────────────
  RxString name = ''.obs;
  RxString phone = ''.obs;
  RxString profileImage = ''.obs;

  // ── Rating Summary ────────────────────────────────────────────────────────
  RxDouble overallRating = 0.0.obs;
  RxInt totalReviews = 0.obs;

  // ── Rating Breakdown (5→1 star counts) ───────────────────────────────────
  RxMap<int, int> ratingBreakdown = <int, int>{
    5: 0,
    4: 0,
    3: 0,
    2: 0,
    1: 0,
  }.obs;

  // ── Reviews List ──────────────────────────────────────────────────────────
  RxList<Reviews> reviews = <Reviews>[].obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadArguments();
    _fetchReviewProfile();
  }

  void _loadArguments() {
    if (Get.arguments != null) {
      final args = Get.arguments as Map<String, dynamic>;
      name.value = args['name'] ?? '';
      phone.value = args['phone'] ?? '';
      profileImage.value = args['profileImage'] ?? '';
      overallRating.value = (args['rating'] ?? 0.0).toDouble();
      totalReviews.value = args['totalReviews'] ?? 0;
    }
  }

  // ── Fetch Review Profile from API ──────────────────────────────────────────
  Future<void> _fetchReviewProfile() async {
    try {
      isLoading.value = true;

      String? userId = SharePrefsHelper.getUserId();
      if (userId == null || userId.isEmpty) {
        isLoading.value = false;
        return;
      }

      final response = await _apiClient.get(
        url: ApiUrl.reviewProfile(userId),
        isToken: true,
      );

      if (response.statusCode == 200) {
        final model = ReviewProfileModel.fromJson(response.body);

        if (model.data != null) {
          // ── Update Stats ─────────────────────────────────────────────
          if (model.data!.stats != null) {
            overallRating.value =
                (model.data!.stats!.averageRating ?? 0).toDouble();
            totalReviews.value =
                (model.data!.stats!.totalReviews ?? 0).toInt();

            // ── Update Rating Breakdown ────────────────────────────────
            if (model.data!.stats!.ratingBreakdown != null) {
              ratingBreakdown.value =
                  model.data!.stats!.ratingBreakdown!.toMap();
            }
          }

          // ── Update Reviews List ──────────────────────────────────────
          if (model.data!.reviews != null) {
            reviews.value = model.data!.reviews!;
          }
        }
      }
    } catch (e) {
      print("Error fetching review profile: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Max count for progress bar normalization
  int get maxRatingCount {
    if (ratingBreakdown.values.isEmpty) return 1;
    final max = ratingBreakdown.values.reduce((a, b) => a > b ? a : b);
    return max > 0 ? max : 1;
  }

  void onReadAllReviews() {
    Get.toNamed(RoutePath.reviewList);
  }

  // ── Helper: format createdAt to "time ago" string ──────────────────────────
  static String formatTimeAgo(String? isoString) {
    if (isoString == null || isoString.isEmpty) return '';
    try {
      final date = DateTime.parse(isoString);
      final now = DateTime.now();
      final diff = now.difference(date);

      if (diff.inDays > 365) {
        final years = (diff.inDays / 365).floor();
        return '$years ${years == 1 ? 'Year' : 'Years'} ago';
      } else if (diff.inDays > 30) {
        final months = (diff.inDays / 30).floor();
        return '$months ${months == 1 ? 'Month' : 'Months'} ago';
      } else if (diff.inDays > 0) {
        return '${diff.inDays} ${diff.inDays == 1 ? 'Day' : 'Days'} ago';
      } else if (diff.inHours > 0) {
        return '${diff.inHours} ${diff.inHours == 1 ? 'Hour' : 'Hours'} ago';
      } else if (diff.inMinutes > 0) {
        return '${diff.inMinutes} ${diff.inMinutes == 1 ? 'Min' : 'Mins'} ago';
      } else {
        return 'Just now';
      }
    } catch (_) {
      return '';
    }
  }
}