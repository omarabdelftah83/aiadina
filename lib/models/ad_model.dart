// models/ad_model.dart
class AdModel {
  final String title;
  final String description;
  final String userId;
  final String imageUrl;
  final String job;

  AdModel({
    required this.title,
    required this.description,
    required this.userId,
    required this.imageUrl,
    required this.job,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'user': userId,
      'image': {'url': imageUrl},
      'job': job,
    };
  }
}
