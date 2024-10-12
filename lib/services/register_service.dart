import 'dart:convert';
import 'package:http/http.dart' as http;
import '../helpers/cache_helper.dart';
import '../models/location_model.dart';
import '../models/user_model_register.dart';
import '../utils/const.dart'; 

class AuthService {
  static const String registerUrl = '$baseUrl/api/v1/auth/register';
static const String locationUrl = '$baseUrl/api/v1/location';
   Future<LoginResponse> register({
    required String name,
    required String phone,
    required String city,
    required String location,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      String? token = CacheHelper.getToken();
      var headers = {
        'Content-Type': 'application/json',
      };
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
      
      var body = jsonEncode({
        "name": name,
        "phone": phone,
        "city": city,
        "location": location,
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
      });

      print('Sending request to $registerUrl with body: $body');
      final response = await http.post(
        Uri.parse(registerUrl),
        headers: headers,
        body: body,
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
  final data = jsonDecode(response.body);
  return LoginResponse.fromJson(data); 
} else {
  print('Error: Registration failed with status code ${response.statusCode}');
  return LoginResponse(
    status: 'error',
    message: 'Failed to register: ${response.reasonPhrase}',
    token: '',
  );
}

    } catch (e) {
      print('Exception during registration: ${e.toString()}');
      return LoginResponse(
        status: 'error',
        message: 'Exception: ${e.toString()}',
        token: '',
      );
    }
  }

/* Future<Map<String, dynamic>> getAllLocations() async {
    try {
       String? token = CacheHelper.getToken();

      if (token == null || token.isEmpty) {
        throw Exception('Token not found');
      }

      var headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };


      var response = await http.get(Uri.parse(locationUrl), headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<String> cities = [];
        Map<String, List<String>> districtMap = {};
        for (var location in data['locations']) {
          String city = location['city'];
          String district = location['district'];

          if (!cities.contains(city)) {
            cities.add(city);
            districtMap[city] = [];
          }
          districtMap[city]!.add(district); 
        }

        return {
          'cities': cities,
          'districts': districtMap,
        };
      } else {
        throw Exception('Failed to load locations: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Exception during fetching locations: ${e.toString()}');
      return {
        'cities': [],
        'districts': {},
      };
    }
  }
 */


}