class CategoryModel {
  final String id;
  final String name;
  final String? description;
  final DateTime createdAt;

  CategoryModel({
    required this.id,
    required this.name,
    this.description,
    required this.createdAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? 'Unknown',
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }
}