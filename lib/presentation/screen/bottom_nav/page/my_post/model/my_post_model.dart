import 'package:get/get_utils/src/extensions/string_extensions.dart';

import '../../../../../../service/api_url.dart';

enum PostStatus { pending, active, completed }

extension PostStatusExtension on PostStatus {
  String get value {
    switch (this) {
      case PostStatus.pending:
        return 'pending';
      case PostStatus.active:
        return 'active';
      case PostStatus.completed:
        return 'completed';
    }
  }

  static PostStatus fromString(String? value) {
    switch (value?.toLowerCase()) {
      case 'active':
        return PostStatus.active;
      case 'completed':
        return PostStatus.completed;
      default:
        return PostStatus.pending;
    }
  }
}

class PostModel {
  final String id;
  final String title;
  final String category;
  final String date;
  final String size;
  final double price;
  final PostStatus status;
  final String imageUrl;

  PostModel({
    required this.id,
    required this.title,
    required this.category,
    required this.date,
    required this.size,
    required this.price,
    required this.status,
    required this.imageUrl,
  });

  // ── From JSON ─────────────────────────────────────────────────────────────
  factory PostModel.fromJson(Map<String, dynamic> json) {
    String extractDate(Map<String, dynamic> json) {
      if (json['dateTimeSlot'] != null) {
        final dt = json['dateTimeSlot'];
        if (dt['scheduledDate'] != null) {
          return dt['scheduledDate'].toString();
        }
      }
      return json['createdAt']?.toString().substring(0, 10) ?? '';
    }

    String extractImage(Map<String, dynamic> json) {
      if (json['photos'] != null && json['photos'] is List && json['photos'].isNotEmpty) {
        return ApiUrl.buildImageUrl(json['photos'][0].toString());
      }
      return '';
    }

    return PostModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      category: (json['type'] == 'recycling' && json['wasteType'] != null && (json['wasteType'] as List).isNotEmpty)
          ? (json['wasteType'] as List).join(', ')
          : (json['type']?.toString().capitalizeFirst ?? ''),
      date: extractDate(json),
      size: json['size'] ?? '',
      price: double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
      status: PostStatusExtension.fromString(json['status']),
      imageUrl: extractImage(json),
    );
  }

  // ── To JSON ───────────────────────────────────────────────────────────────
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'type': category,
      'date': date, // keeping as date for local cache if needed
      'size': size,
      'price': price,
      'status': status.value,
      'image_url': imageUrl,
    };
  }

  // ── Copy With ─────────────────────────────────────────────────────────────
  PostModel copyWith({
    String? id,
    String? title,
    String? category,
    String? date,
    String? size,
    double? price,
    PostStatus? status,
    String? imageUrl,
  }) {
    return PostModel(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      date: date ?? this.date,
      size: size ?? this.size,
      price: price ?? this.price,
      status: status ?? this.status,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}