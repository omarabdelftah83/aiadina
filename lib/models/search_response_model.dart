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
          ?.map((item) => UserData.fromJson(item as Map<String, dynamic>))
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
    this.posts,
    this.images,
    this.profilePhoto,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    print('Parsing UserData: $json'); // لمتابعة كيفية تحليل البيانات
    return UserData(
      id: json['_id'] as String?,
      location: json['location'] as String?,
      city: json['city'] as String?,
      jobs: (json['jobs'] as List<dynamic>?)
          ?.map((job) => job as String)
          .toList(),
      posts: (json['posts'] as List<dynamic>?)
          ?.map((post) => Post.fromJson(post as Map<String, dynamic>))
          .toList(),
      profilePhoto: json['profilePhoto'] as String?,
      images: (json['images'] as List<dynamic>?)
          ?.map((image) => ImageModel.fromJson(image as Map<String, dynamic>))
          .toList(),
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
  List<ImageModel>? images; // تعديل الاسم ليكون متوافقاً مع الـ JSON
  int? commentCount;

  Post({this.id, this.user, this.images, this.commentCount});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'] as String?,
      user: json['user'] != null ? User.fromJson(json['user'] as Map<String, dynamic>) : null,
      images: (json['image'] as List<dynamic>?) // يجب استخدام 'image' هنا
          ?.map((image) => ImageModel.fromJson(image as Map<String, dynamic>))
          .toList(),
      commentCount: json['commentCount'] as int?,
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
      id: json['_id'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      location: json['location'] as String?,
      city: json['city'] as String?,
      jobs: (json['jobs'] as List<dynamic>?)
          ?.map((job) => job as String)
          .toList(),
      email: json['email'] as String?,
      isAdmin: json['isAdmin'] as bool?,
    );
  }
}

class ImageModel {
  String? id; // إضافة id هنا
  String? url;

  ImageModel({this.id, this.url});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['_id'] as String?, // افتراض أنك تريد تحليل ID من JSON
      url: json['url'] as String?,
    );
  }
}
