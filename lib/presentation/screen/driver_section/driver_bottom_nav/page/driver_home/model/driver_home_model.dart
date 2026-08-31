// ── GET /driver/home response model ─────────────────────────────────────

class DriverHomeModel {
  final String approvalStatus;
  final bool isAvailable;
  final DriverHomeStats stats;
  final List<DriverHomeTaskItem> currentTasks;
  final List<DriverHomeTaskItem> recentJobs;
  final DriverHomeUser user;

  DriverHomeModel({
    required this.approvalStatus,
    required this.isAvailable,
    required this.stats,
    required this.currentTasks,
    required this.recentJobs,
    required this.user,
  });

  factory DriverHomeModel.fromJson(Map<String, dynamic> json) {
    final d = json['data'] != null
        ? json['data'] as Map<String, dynamic>
        : json;

    return DriverHomeModel(
      approvalStatus: d['approvalStatus']?.toString() ?? '',
      isAvailable: d['isAvailable'] == true,
      stats: d['stats'] is Map
          ? DriverHomeStats.fromJson(d['stats'] as Map<String, dynamic>)
          : DriverHomeStats.empty(),
      currentTasks: (d['currentTasks'] as List<dynamic>? ?? [])
          .map((e) => DriverHomeTaskItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      recentJobs: (d['recentJobs'] as List<dynamic>? ?? [])
          .map((e) => DriverHomeTaskItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      user: d['user'] is Map
          ? DriverHomeUser.fromJson(d['user'] as Map<String, dynamic>)
          : DriverHomeUser(name: '', rating: 0),
    );
  }
}

class DriverHomeStats {
  final int activeTasks;
  final int completedTasks;
  final int pendingRequests;
  final double totalEarnings;
  final double rating;
  final int totalDeliveries;

  DriverHomeStats({
    required this.activeTasks,
    required this.completedTasks,
    required this.pendingRequests,
    required this.totalEarnings,
    required this.rating,
    required this.totalDeliveries,
  });

  factory DriverHomeStats.empty() => DriverHomeStats(
    activeTasks: 0,
    completedTasks: 0,
    pendingRequests: 0,
    totalEarnings: 0,
    rating: 0,
    totalDeliveries: 0,
  );

  factory DriverHomeStats.fromJson(Map<String, dynamic> json) =>
      DriverHomeStats(
        activeTasks: (json['activeTasks'] as num?)?.toInt() ?? 0,
        completedTasks: (json['completedTasks'] as num?)?.toInt() ?? 0,
        pendingRequests: (json['pendingRequests'] as num?)?.toInt() ?? 0,
        totalEarnings: (json['totalEarnings'] as num?)?.toDouble() ?? 0,
        rating: (json['rating'] as num?)?.toDouble() ?? 0,
        totalDeliveries: (json['totalDeliveries'] as num?)?.toInt() ?? 0,
      );
}

class DriverHomeUser {
  final String name;
  final double rating;

  DriverHomeUser({required this.name, required this.rating});

  factory DriverHomeUser.fromJson(Map<String, dynamic> json) => DriverHomeUser(
    name: json['name']?.toString() ?? '',
    rating: (json['rating'] as num?)?.toDouble() ?? 0,
  );
}

/// Shared shape for both `currentTasks` and `recentJobs` entries — a
/// lightweight dashboard summary of a job/task, not the full post/task
/// record (no dropoff/timeline/waste-type/etc.).
class DriverHomeTaskItem {
  final String id;
  final String title;
  final int price;
  final List<String> photos;
  final String? pickupAddressText;

  DriverHomeTaskItem({
    required this.id,
    required this.title,
    required this.price,
    required this.photos,
    this.pickupAddressText,
  });

  factory DriverHomeTaskItem.fromJson(Map<String, dynamic> json) {
    final pickup = json['pickup'];
    final address = pickup is Map ? pickup['address'] : null;

    return DriverHomeTaskItem(
      id: json['_id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      price: (json['price'] as num?)?.toInt() ?? 0,
      photos: (json['photos'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      pickupAddressText: address is Map ? address['text']?.toString() : null,
    );
  }
}
