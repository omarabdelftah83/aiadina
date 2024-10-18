class User {
  String? id;
  String? name;
  String? phone;
  String? location;
  String? city;
  List<String>? jobs;
  String? email;
  String? profilePhoto;
  bool? isAdmin;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.name,
    this.phone,
    this.location,
    this.city,
    this.jobs,
    this.email,
    this.profilePhoto,
    this.isAdmin,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      phone: json['phone'],
      location: json['location'],
      city: json['city'],
      jobs: json['jobs'] != null ? List<String>.from(json['jobs']) : null,
      email: json['email'],
      profilePhoto: json['profilePhoto'],
      isAdmin: json['isAdmin'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }
}

class Comment {
  String? id;
  String? postId;
  User? user; // Changed to User type to match the structure
  String? text;
  String? username;
  DateTime? createdAt;
  DateTime? updatedAt;

  Comment({
    this.id,
    this.postId,
    this.user,
    this.text,
    this.username,
    this.createdAt,
    this.updatedAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['_id'],
      postId: json['postId'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      text: json['text'],
      username: json['username'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }
}

class CommentResponse {
  String? status;
  String? message;
  int? length;
  List<Comment>? comments;

  CommentResponse({
    this.status,
    this.message,
    this.length,
    this.comments,
  });

  factory CommentResponse.fromJson(Map<String, dynamic> json) {
    return CommentResponse(
      status: json['status'],
      message: json['message'],
      length: json['length'],
      comments: (json['data']['comments'] as List)
          .map((commentJson) => Comment.fromJson(commentJson))
          .toList(),
    );
  }
}
