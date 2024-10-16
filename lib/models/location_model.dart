
class ApiResponseModel {
  final String status;
  final int results;
  final CityDistrictModel data;

  ApiResponseModel({
    required this.status,
    required this.results,
    required this.data,
  });

  factory ApiResponseModel.fromJson(Map<String, dynamic> json) {
    return ApiResponseModel(
      status: json['status'],
      results: json['results'],
      data: CityDistrictModel.fromJson(json['data']),
    );
  }
}


class CityDistrictModel {
  final List<String> cities;
  final List<String> districts;

  CityDistrictModel({required this.cities, required this.districts});

  factory CityDistrictModel.fromJson(Map<String, dynamic> json) {
    return CityDistrictModel(
      cities: List<String>.from(json['cities']),
      districts: List<String>.from(json['districts']),
    );
  }


}