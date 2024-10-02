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

class Post {
  String? id;
  User? user;
  ImageModel? image;
  int? commentCount;

  Post({this.id, this.user, this.image, this.commentCount});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'],
      user: User.fromJson(json['user']),
      image: ImageModel.fromJson(json['image']),
      commentCount: json['commentCount'],
    );
  }

  @override
  String toString() {
    return 'Post(id: $id, commentCount: $commentCount)';
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

  User({this.id, this.name, this.phone, this.location, this.city, this.jobs, this.email, this.isAdmin});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      phone: json['phone'],
      location: json['location'],
      city: json['city'],
      jobs: List<String>.from(json['jobs']),
      email: json['email'],
      isAdmin: json['isAdmin'],
    );
  }
}

class ImageModel {
  String? url;

  ImageModel({this.url});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      url: json['url'],
    );
  }
}
