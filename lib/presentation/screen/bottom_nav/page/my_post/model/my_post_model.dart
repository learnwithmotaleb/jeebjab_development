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
  final String title;
  final String category;
  final String date;
  final String size;
  final double price;
  final PostStatus status;
  final String imageUrl;

  PostModel({
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
    return PostModel(
      title: json['title'] ?? '',
      category: json['category'] ?? '',
      date: json['date'] ?? '',
      size: json['size'] ?? '',
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      status: PostStatusExtension.fromString(json['status']),
      imageUrl: json['image_url'] ?? '',
    );
  }

  // ── To JSON ───────────────────────────────────────────────────────────────
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'category': category,
      'date': date,
      'size': size,
      'price': price,
      'status': status.value,
      'image_url': imageUrl,
    };
  }

  // ── Copy With ─────────────────────────────────────────────────────────────
  PostModel copyWith({
    String? title,
    String? category,
    String? date,
    String? size,
    double? price,
    PostStatus? status,
    String? imageUrl,
  }) {
    return PostModel(
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