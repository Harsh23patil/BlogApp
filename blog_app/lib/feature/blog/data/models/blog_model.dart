import 'package:blog_app/feature/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.posetrId,
    required super.title,
    required super.content,
    required super.topics,
    required super.imageUrl,
    required super.updatedDateTime,
  });

  // Factory constructor for creating a Blog instance from a JSON map
  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'] as String,
      posetrId: json['posetr_id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      imageUrl: json['image_url'] as String,
      topics: List<String>.from(json['topics']), // Ensures it's a List<String>
      updatedDateTime: json['updated_at'] == null
          ? DateTime.now()
          : DateTime.parse(json['updated_at']), // Parses ISO 8601 format
    );
  }

  // Method for converting a Blog instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'posetr_id': posetrId,
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'topics': topics,
      'updated_at':
          updatedDateTime.toIso8601String(), // Converts to ISO 8601 string
    };
  }
}
