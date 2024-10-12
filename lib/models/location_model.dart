// location_model.dart

class LocationModel {
  final String id;
  final String city;
  final String district;
  final int version; 

  LocationModel({
    required this.id,
    required this.city,
    required this.district,
    required this.version,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['_id'] as String,
      city: json['city'] as String,
      district: json['district'] as String,
      version: json['__v'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'city': city,
      'district': district,
      '__v': version,
    };
  }
}

class LocationResponse {
  final String status;
  final int results;
  final List<LocationModel> locations;

  LocationResponse({
    required this.status,
    required this.results,
    required this.locations,
  });

  factory LocationResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> locationData = json['data']['locations'];

    return LocationResponse(
      status: json['status'] as String,
      results: json['results'] as int,
      locations: List<LocationModel>.from(
        locationData.map((location) => LocationModel.fromJson(location)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'results': results,
      'data': {
        'locations': locations.map((location) => location.toJson()).toList(),
      },
    };
  }
}
