// ── Job Post API Response Model ───────────────────────────────────────────────

class JobPostModel {
  int? statusCode;
  bool? success;
  String? message;
  JobPostData? data;

  JobPostModel({this.statusCode, this.success, this.message, this.data});

  JobPostModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? JobPostData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'success': success,
      'message': message,
      if (data != null) 'data': data!.toJson(),
    };
  }
}

// ── Paginated wrapper ─────────────────────────────────────────────────────────

class JobPostData {
  JobPostMeta? meta;
  List<PostItem>? posts;

  JobPostData({this.meta, this.posts});

  JobPostData.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? JobPostMeta.fromJson(json['meta']) : null;
    if (json['posts'] != null) {
      posts = (json['posts'] as List)
          .map((v) => PostItem.fromJson(v as Map<String, dynamic>))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      if (meta != null) 'meta': meta!.toJson(),
      if (posts != null) 'posts': posts!.map((v) => v.toJson()).toList(),
    };
  }
}

// ── Pagination meta ───────────────────────────────────────────────────────────

class JobPostMeta {
  int? page;
  int? limit;
  int? total;
  int? totalPage;

  JobPostMeta({this.page, this.limit, this.total, this.totalPage});

  JobPostMeta.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    totalPage = json['totalPage'];
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'limit': limit,
      'total': total,
      'totalPage': totalPage,
    };
  }
}

// ── Single post item ──────────────────────────────────────────────────────────

class PostItem {
  String? sId;
  String? photo;
  String? title;
  String? type;

  /// `wasteType` in the API can be:
  ///   - null
  ///   - [] (empty list)
  ///   - ["Gas", "Water"] (list of strings)
  ///   - "Paper, Cardboard, Newspaper" (comma-separated string)
  List<String> wasteType;

  int? price;
  String? slotType;
  double? distanceKm;

  PostItem({
    this.sId,
    this.photo,
    this.title,
    this.type,
    List<String>? wasteType,
    this.price,
    this.slotType,
    this.distanceKm,
  }) : wasteType = wasteType ?? [];

  PostItem.fromJson(Map<String, dynamic> json)
      : wasteType = _parseWasteType(json['wasteType']) {
    sId = json['_id']?.toString();
    photo = json['photo']?.toString();
    title = json['title']?.toString();
    type = json['type']?.toString();
    price = (json['price'] as num?)?.toInt();
    slotType = json['slotType']?.toString();
    distanceKm = (json['distanceKm'] as num?)?.toDouble();
  }

  /// Safely parse the wasteType field regardless of its server-side format.
  static List<String> _parseWasteType(dynamic raw) {
    if (raw == null) return [];
    if (raw is List) {
      return raw.map((e) => e.toString()).toList();
    }
    if (raw is String) {
      return raw.trim().isEmpty ? [] : raw.split(',').map((e) => e.trim()).toList();
    }
    return [];
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'photo': photo,
      'title': title,
      'type': type,
      'wasteType': wasteType,
      'price': price,
      'slotType': slotType,
      'distanceKm': distanceKm,
    };
  }
}
