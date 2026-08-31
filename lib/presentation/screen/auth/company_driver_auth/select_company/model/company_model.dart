class CompanyModel {
  final String id;
  final String name;
  final String? logo;

  CompanyModel({required this.id, required this.name, this.logo});

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
    id: json['_id']?.toString() ?? '',
    name: json['name']?.toString() ?? '',
    logo: json['logo']?.toString(),
  );
}
