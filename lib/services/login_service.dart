import 'dart:convert';
import 'package:http/http.dart' as http;
import '../helpers/cache_helper.dart';
import '../models/user_model_register.dart';
import '../utils/const.dart';


class AuthLoginService {
  final String loginUrl = '$baseUrl/api/v1/auth/login';
  Future<LoginResponse> login({required String email, required String password}) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var body = json.encode({
      'email': email,
      'password': password,
    });
    try {
      final response = await http.post(
        Uri.parse(loginUrl),
        headers: headers,
        body: body,
      );
      print('Response status code: ${response.statusCode}');
      print('Request body: $body');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = response.body;
        print('Response body: $responseBody');
        final loginResponse = LoginResponse.fromJson(jsonDecode(responseBody));
        await CacheHelper.saveToken(loginResponse.token);
        return loginResponse;
      } else {
        final responseBody = response.body; 
        print('Error body: $responseBody');
        print('Error: ${response.reasonPhrase}');
        throw Exception('Failed to login: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error occurred: $e');
      throw Exception('Failed to login: $e');
    }
  }
}