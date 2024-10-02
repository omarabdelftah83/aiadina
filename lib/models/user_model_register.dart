class LoginResponse {
  final String status;
  final String message;
  final String token;
  final User? user;

  LoginResponse({
    required this.status,
    required this.message,
    this.token = '',
    this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'] ?? 'error',
      message: json['message'] ?? 'No message available',
      token: json['token'] ?? '',
      user: json['data'] != null && json['data']['user'] != null
          ? User.fromJson(json['data']['user'])
          : null,
    );
  }
}

class User {
  final String name;
  final String phone;
  final String city;
  final String location;
  final String job;
  final String email;
  final String profilePhoto;
  final bool isAdmin;
  final String id;
  final String createdAt;
  final String updatedAt;

  User({
    required this.name,
    required this.phone,
    required this.city,
    required this.location,
    required this.job,
    required this.email,
    required this.profilePhoto,
    required this.isAdmin,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      city: json['city'] ?? '',
      location: json['location'] ?? '',
      job: json['job'] ?? '',
      email: json['email'] ?? '',
      profilePhoto: json['profilePhoto'] ?? '',
      isAdmin: json['isAdmin'] ?? false, 
      id: json['_id'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}
