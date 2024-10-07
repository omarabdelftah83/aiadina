class UserResponse {
  String? status;
  String? message;
  Data? data;

  UserResponse({this.status, this.message, this.data});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  @override
  String toString() => 'UserResponse(status: $status, message: $message, data: $data)';
}

class Data {
  User? user;

  Data({this.user});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  @override
  String toString() => 'Data(user: $user)';
}

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
  String? createdAt;
  String? updatedAt;
  int? version;
  String? passwordResetToken;
  String? passwordResetTokenExpire;
  List<Post>? posts; 

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
    this.version,
    this.passwordResetToken,
    this.passwordResetTokenExpire,
    this.posts,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      location: json['location'] as String?,
      city: json['city'] as String?,
      jobs: json['jobs'] != null ? List<String>.from(json['jobs']) : null,
      email: json['email'] as String?,
      profilePhoto: json['profilePhoto'] as String?,
      isAdmin: json['isAdmin'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      version: json['__v'] as int?,
      passwordResetToken: json['passwordResetToken'] as String?,
      passwordResetTokenExpire: json['passwordResetTokenExpire'] as String?,
      posts: json['posts'] != null
          ? (json['posts'] as List).map((i) => Post.fromJson(i)).toList()
          : null,
    );
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, phone: $phone, location: $location, city: $city, jobs: $jobs, email: $email, profilePhoto: $profilePhoto, isAdmin: $isAdmin, createdAt: $createdAt, updatedAt: $updatedAt, version: $version, passwordResetToken: $passwordResetToken, passwordResetTokenExpire: $passwordResetTokenExpire, posts: $posts)';
  }
}

class Post {
  String? id;
  String? title;
  String? description;
  User? user;
  List<ImagesE>? images; 
  List<String>? likes;
  String? job;
  String? createdAt;
  String? updatedAt;
  int? version;
  int? commentCount;

  Post({
    this.id,
    this.title,
    this.description,
    this.user,
    this.images, 
    this.likes,
    this.job,
    this.createdAt,
    this.updatedAt,
    this.version,
    this.commentCount,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      images: json['images'] != null 
          ? (json['images'] as List).map((i) => ImagesE.fromJson(i)).toList()
          : null,
      likes: json['likes'] != null ? List<String>.from(json['likes']) : null,
      job: json['job'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      version: json['__v'] as int?,
      commentCount: json['commentCount'] as int?,
    );
  }

  @override
  String toString() {
    return 'Post(id: $id, title: $title, description: $description, user: $user, images: $images, likes: $likes, job: $job, createdAt: $createdAt, updatedAt: $updatedAt, version: $version, commentCount: $commentCount)';
  }
}



class ImagesE {
  String? url;

  ImagesE({this.url});

  factory ImagesE.fromJson(Map<String, dynamic> json) {
    return ImagesE(
      url: json['url'] as String?,
    );
  }

  @override
  String toString() => 'Image(url: $url)';
}
