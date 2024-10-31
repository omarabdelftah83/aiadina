import 'dart:convert';
import 'package:dio/dio.dart';
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
  Future<List<District>?> fetchDistricts(CityRequest city) async {
    try {
      final fromData = city.toMap();
      final response = await Dio().get('$baseUrl/api/v1/location/district',data:fromData );
      print('Fetching districts for city: ${city.city}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data;
        return jsonList.map((json) => District.fromJson(json)).toList();
      } else {
        print('Failed to load orders with status code: ${response.statusCode}');
        throw Exception('Failed to load orders');
      }
    } catch (e) {
      print('Failed to load orders: $e');
      throw Exception('Failed to load orders: $e');
    }

  }
}
