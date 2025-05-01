import 'package:flutter/foundation.dart';

class ClientModel {
  final String username;
  final String email;

  ClientModel({
    required this.username,
    required this.email,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      username: json['username']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'username': username,
    'email': email,
  };
}

class CategoryModel {
  final String name;

  CategoryModel({
    required this.name,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json['name']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
  };
}

class PostModel {
  final String id;
  final String title;
  final String description;
  final List<String> skillsRequired;
  final double budget;
  final String duration;
  final String categoryId;
  final CategoryModel? category;
  final String? picture;
  final ClientModel? client;
  final String status;
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
    this.category,
    this.picture,
    this.client,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    if (kDebugMode) {
      print('PostModel.fromJson: Parsing JSON: $json');
    }
    return PostModel(
      id: json['_id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      skillsRequired: (json['skillsRequired'] as List<dynamic>?)?.cast<String>() ?? [],
      budget: (json['budget'] is int ? json['budget'].toDouble() : json['budget']) ?? 0.0,
      duration: json['duration']?.toString() ?? '',
      categoryId: json['category'] is Map ? json['category']['_id']?.toString() ?? '' : json['category']?.toString() ?? '',
      category: json['category'] is Map ? CategoryModel.fromJson(json['category']) : null,
      picture: json['picture']?.toString(),
      client: json['client'] != null ? ClientModel.fromJson(json['client']) : null,
      status: json['status']?.toString() ?? 'open',
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
    'category': category?.toJson() ?? categoryId,
    'picture': picture,
    'client': client?.toJson(),
    'status': status,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };
}