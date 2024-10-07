class Comment {
  String? id;
  String? postId;
  dynamic user; 
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
      user: json['user'],
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
