import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/location_model.dart';
import '../utils/const.dart'; 

class GetAllLocationsService {
  static const String locationUrl = '$baseUrl/api/v1/location';

  Future<ApiResponseModel?> fetchLocationss() async {
    try {
      final response = await http.get(Uri.parse(locationUrl));

      print('Response status code-------------------: ${response.statusCode}');
      print('Response body-----------------: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return ApiResponseModel.fromJson(jsonResponse);
      } else {
        print('Error: Failed to load categories');
        return null;
      }
    } catch (error) {
      print('Error fetching categories: $error');
      return null;
    }
  }
}
