class PostModel {
  final String id;
  final String title;
  final String description;
  final List<String> skillsRequired;
  final double budget;
  final String duration;
  final String categoryId;
  final String? picture;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  PostModel({
    required this.id,
    required this.title,
    required this.description,
    required this.skillsRequired,
    required this.budget,
    required this.duration,
    required this.categoryId,
    this.picture,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['_id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      skillsRequired: (json['skillsRequired'] as List<dynamic>?)?.cast<String>() ?? [],
      budget: (json['budget'] is int ? json['budget'].toDouble() : json['budget']) ?? 0.0,
      duration: json['duration']?.toString() ?? '',
      categoryId: json['category']?.toString() ?? '',
      picture: json['picture']?.toString(),
      createdBy: json['createdBy']?.toString() ?? '',
      createdAt: DateTime.tryParse(json['createdAt']?.toString() ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt']?.toString() ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'title': title,
    'description': description,
    'skillsRequired': skillsRequired,
    'budget': budget,
    'duration': duration,
    'category': categoryId,
    'picture': picture,
    'createdBy': createdBy,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };
}