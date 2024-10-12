class SearchResponse {
  String? status;
  String? message;
  int? length;
  List<UserData>? data;

  SearchResponse({this.status, this.message, this.length, this.data});

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    return SearchResponse(
      status: json['status'],
      message: json['message'],
      length: json['length'],
      data: (json['data'] as List?)?.map((item) => UserData.fromJson(item)).toList(),
    );
  }
}

class UserData {
  String? id;
  String? location;
  String? city;
  List<String>? jobs;
  List<Post>? posts;
  List<String>? images;

  UserData({this.id, this.location, this.city, this.jobs, this.posts, this.images});

  factory UserData.fromJson(Map<String, dynamic> json) {
    print('Parsing UserData: $json');  // Debugging JSON parsing
    return UserData(
      id: json['_id'],
      location: json['location'],
      city: json['city'],
      jobs: List<String>.from(json['jobs']),
      posts: (json['posts'] as List).map((post) => Post.fromJson(post)).toList(),
      images: List<String>.from(json['images']),
    );
  }

  @override
  String toString() {
    return 'UserData(id: $id, location: $location, city: $city, jobs: $jobs, images: $images)';
  }
}

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
  List<Post>? posts; // Adding posts field

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
   ImageModel? images; // Modified to List<ImagesE>
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
      images: ImageModel.fromJson(json['image']),
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

class ImageModel {
  String? url;

  ImageModel({this.url});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      url: json['url'] as String?,
    );
  }

  @override
  String toString() => 'Image(url: $url)';
}
