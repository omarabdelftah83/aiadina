class SearchResponse {
  String? status;
  String? message;
  int? length;
  List<UserData>? data;

  SearchResponse({this.status, this.message, this.length, this.data});

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    return SearchResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      length: json['length'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.whereType<Map<String, dynamic>>()
          .map((item) => UserData.fromJson(item))
          .toList(),
    );
  }
}

class UserData {
  String? id;
  String? location;
  String? city;
  List<String>? jobs;
  String? profilePhoto;
  List<Post>? posts;
  List<ImageModel>? images;

  UserData({
    this.id,
    this.location,
    this.city,
    this.jobs,
    this.profilePhoto,
    this.posts,
    this.images,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
  return UserData(
    id: json['_id'] as String?,
    location: json['location'] as String?,
    city: json['city'] as String?,
    jobs: (json['jobs'] as List<dynamic>?)?.whereType<String>().toList(),
    profilePhoto: json['profilePhoto'] as String?,
    posts: (json['posts'] as List<dynamic>?)
        ?.whereType<Map<String, dynamic>>()
        .map((post) => Post.fromJson(post))
        .toList(),
    images: (json['images'] as List<dynamic>?)
        ?.whereType<String>() // Adjust if each image is a URL string
        .map((image) => ImageModel(url: image)) // Create ImageModel with URLs
        .toList(),
  );
}


  @override
  String toString() {
    return 'UserData(id: $id, location: $location, city: $city, jobs: $jobs, profilePhoto: $profilePhoto, posts: $posts, images: $images)';
  }
}

class Post {
  String? id;
  User? user;
  List<ImageModel>? images;
  int? commentCount;

  Post({this.id, this.user, this.images, this.commentCount});

  factory Post.fromJson(Map<String, dynamic> json) {
    final userJson = json['user'];
    User? user;
    if (userJson is Map<String, dynamic>) {
      user = User.fromJson(userJson);
    } else {
      print("No valid user found for the post.");
      user = null;
    }

    return Post(
      id: json['_id'] as String?,
      user: user,
      images: (json['image'] as List<dynamic>?)
          ?.whereType<Map<String, dynamic>>()
          .map((image) => ImageModel.fromJson(image))
          .toList(),
      commentCount: json['commentCount'] as int?,
    );
  }
}

class User {
  String? id;
  String? name;
  String? phone;
  String? location;
  String? city;
  List<String>? jobs;
  String? email;
  bool? isAdmin;

  User({
    this.id,
    this.name,
    this.phone,
    this.location,
    this.city,
    this.jobs,
    this.email,
    this.isAdmin,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      location: json['location'] as String?,
      city: json['city'] as String?,
      jobs: (json['jobs'] as List<dynamic>?)?.whereType<String>().toList(),
      email: json['email'] as String?,
      isAdmin: json['isAdmin'] as bool?,
    );
  }
}

class ImageModel {
  String? id;
  String? url;

  ImageModel({this.id, this.url});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['_id'] as String?,
      url: json['url'] as String?,
    );
  }
}
