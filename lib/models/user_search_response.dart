class UserSearchResponse {
  final String status;
  final String message;
  final List<String> locations;
  final List<String?> jobs;
  final List<String> cities;

  UserSearchResponse({
    required this.status,
    required this.message,
    required this.locations,
    required this.jobs,
    required this.cities,
  });

  factory UserSearchResponse.fromJson(Map<String, dynamic> json) {
    return UserSearchResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      locations: List<String>.from(json['locations'] ?? []),
      jobs: List<String?>.from(json['jobs'] ?? []),
      cities: List<String>.from(json['cities'] ?? []),
    );
  }
}
