import 'dart:convert';
import 'package:http/http.dart' as http;
import '../helpers/cache_helper.dart';
import '../models/user_model_register.dart';
import '../utils/const.dart';

class AuthService {
  static const String registerUrl = '$baseUrl/api/v1/auth/register';

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
      var headers = {
        'Content-Type': 'application/json',
      };

      var request = http.Request('POST', Uri.parse(registerUrl));
      request.body = json.encode({
        "name": name,
        "phone": phone,
        "city": city,
        "location": location,
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = await response.stream.bytesToString();
        final data = jsonDecode(responseBody);
        
        // Create LoginResponse from JSON
        final loginResponse = LoginResponse.fromJson(data);
        
        await CacheHelper.saveToken(loginResponse.token);
        
        return loginResponse;
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
}
