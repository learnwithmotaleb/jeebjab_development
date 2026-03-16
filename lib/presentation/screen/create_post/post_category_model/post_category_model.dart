import '../../../../core/enums/post_category_type.dart';

class PostCategoryModel {
  final PostCategoryType type;
  final String title;
  final String subtitle;
  final bool isEnabled;

  PostCategoryModel({
    required this.type,
    required this.title,
    required this.subtitle,
    this.isEnabled = true,
  });

  Map<String, dynamic> toJson() => {
    'type': type.name,
    'title': title,
    'subtitle': subtitle,
    'isEnabled': isEnabled,
  };

  factory PostCategoryModel.fromJson(Map<String, dynamic> json) {
    return PostCategoryModel(
      type: PostCategoryType.values.firstWhere(
            (e) => e.name == json['type'],
      ),
      title: json['title'],
      subtitle: json['subtitle'],
      isEnabled: json['isEnabled'],
    );
  }
}