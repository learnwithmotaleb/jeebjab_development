class DriverTask {
  final String id;
  final String title;
  final String subtitle;
  final String address;
  final double price;
  final String categoryIcon; // e.g., 'move', 'recycle', 'gift'
  final String status; // 'active', 'completed', 'cancelled'

  DriverTask({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.address,
    required this.price,
    required this.categoryIcon,
    required this.status,
  });

  factory DriverTask.fromJson(Map<String, dynamic> json) {
    return DriverTask(
      id: json['_id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      subtitle: json['subtitle']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      price: (json['price'] ?? 0).toDouble(),
      categoryIcon: json['categoryIcon']?.toString() ?? 'move',
      status: json['status']?.toString() ?? 'active',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'subtitle': subtitle,
      'address': address,
      'price': price,
      'categoryIcon': categoryIcon,
      'status': status,
    };
  }
}
