class HomeUserModel {
  final String name;
  final String? avatar;
  final double rating;

  HomeUserModel({required this.name, this.avatar, required this.rating});

  factory HomeUserModel.fromJson(Map<String, dynamic> json) => HomeUserModel(
    name: json['name']?.toString() ?? '',
    avatar: json['avatar']?.toString(),
    rating: (json['rating'] as num?)?.toDouble() ?? 0,
  );
}

class HomeStatsModel {
  final String averageResponse;
  final String totalDeliveries;
  final String reducedRides;

  HomeStatsModel({
    required this.averageResponse,
    required this.totalDeliveries,
    required this.reducedRides,
  });

  factory HomeStatsModel.fromJson(Map<String, dynamic> json) => HomeStatsModel(
    averageResponse: json['averageResponse']?.toString() ?? '',
    totalDeliveries: json['totalDeliveries']?.toString() ?? '',
    reducedRides: json['reducedRides']?.toString() ?? '',
  );
}

class WhatsNewItemModel {
  final String id;
  final String title;
  final String description;
  final String? image;

  WhatsNewItemModel({
    required this.id,
    required this.title,
    required this.description,
    this.image,
  });

  factory WhatsNewItemModel.fromJson(Map<String, dynamic> json) =>
      WhatsNewItemModel(
        id: json['id']?.toString() ?? '',
        title: json['title']?.toString() ?? '',
        description: json['description']?.toString() ?? '',
        image: json['image']?.toString(),
      );
}

class HomeModel {
  final HomeUserModel user;
  final HomeStatsModel stats;
  final List<WhatsNewItemModel> whatsNew;

  HomeModel({required this.user, required this.stats, required this.whatsNew});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    final d = json['data'] != null
        ? json['data'] as Map<String, dynamic>
        : json;

    return HomeModel(
      user: d['user'] is Map
          ? HomeUserModel.fromJson(d['user'] as Map<String, dynamic>)
          : HomeUserModel(name: '', rating: 0),
      stats: d['stats'] is Map
          ? HomeStatsModel.fromJson(d['stats'] as Map<String, dynamic>)
          : HomeStatsModel(
              averageResponse: '',
              totalDeliveries: '',
              reducedRides: '',
            ),
      whatsNew: (d['whatsNew'] as List<dynamic>? ?? [])
          .map((e) => WhatsNewItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
