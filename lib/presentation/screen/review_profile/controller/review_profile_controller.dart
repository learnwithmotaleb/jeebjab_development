import 'package:get/get.dart';

import '../../../../core/routes/route_path.dart';

class ReviewModel {
  final String username;
  final String timeAgo;
  final double rating;
  final String title;
  final String body;

  ReviewModel({
    required this.username,
    required this.timeAgo,
    required this.rating,
    required this.title,
    required this.body,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
    username: json['username'] ?? '',
    timeAgo: json['time_ago'] ?? '',
    rating: (json['rating'] ?? 0).toDouble(),
    title: json['title'] ?? '',
    body: json['body'] ?? '',
  );
}

class ReviewProfileController extends GetxController {
  // ── Profile Info ──────────────────────────────────────────────────────────
  RxString name = 'Rayyan Hassan'.obs;
  RxString phone = '+1564165654564'.obs;
  RxString profileImage =
      'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200'.obs;

  // ── Rating Summary ────────────────────────────────────────────────────────
  RxDouble overallRating = 4.5.obs;
  RxInt totalReviews = 120.obs;

  // ── Rating Breakdown (5→1 star counts) ───────────────────────────────────
  RxMap<int, int> ratingBreakdown = <int, int>{
    5: 80,
    4: 20,
    3: 12,
    2: 6,
    1: 2,
  }.obs;

  // ── Reviews List ──────────────────────────────────────────────────────────
  RxList<ReviewModel> reviews = <ReviewModel>[
    ReviewModel(
      username: 'Tiago_Felipe',
      timeAgo: '1 Day ago',
      rating: 5,
      title: 'There are many variations of passage',
      body:
      'The majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable.',
    ),
    ReviewModel(
      username: 'Sarah_K',
      timeAgo: '3 Days ago',
      rating: 4,
      title: 'Great experience overall',
      body:
      'Very professional and punctual. Would definitely recommend to others looking for reliable service.',
    ),
  ].obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadArguments();
  }

  void _loadArguments() {
    if (Get.arguments != null) {
      final args = Get.arguments as Map<String, dynamic>;
      name.value = args['name'] ?? 'Rayyan Hassan';
      phone.value = args['phone'] ?? '';
      profileImage.value = args['profileImage'] ?? profileImage.value;
      overallRating.value = (args['rating'] ?? 4.5).toDouble();
      totalReviews.value = args['totalReviews'] ?? 120;
    }
  }

  // Max count for progress bar normalization
  int get maxRatingCount =>
      ratingBreakdown.values.reduce((a, b) => a > b ? a : b);

  void onReadAllReviews() {
    Get.toNamed(RoutePath.reviewList);
  }
}