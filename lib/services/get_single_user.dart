import 'dart:convert';
import 'package:http/http.dart' as http;
import '../helpers/cache_helper.dart';
import '../models/get_single_user.dart';
import '../utils/const.dart';

class GetSingleUser {
  Future<UserResponse> fetchUser(String userId) async {
    final String getSingleUserUrl = '$baseUrl/api/v1/user/$userId';
    String? token = CacheHelper.getToken();

    if (token == null || token.isEmpty) {
      throw Exception('Token not found');
    }

    print('Fetching user data from $getSingleUserUrl');

    final response = await http.get(
      Uri.parse(getSingleUserUrl),
      headers: {
        'Authorization': 'Bearer $token', 
      },
    );

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      return UserResponse.fromJson(jsonDecode(response.body));
    } else {
      print('Error: Failed to load user data: ${response.statusCode}');
      throw Exception('Failed to load user data: ${response.statusCode}');
    }
  }
}
