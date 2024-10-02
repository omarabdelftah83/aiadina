import 'dart:convert';
import 'package:http/http.dart' as http;
import '../helpers/cache_helper.dart';
import '../models/user_search_response.dart';
import '../utils/const.dart'; 

class UserSearchService {
  static const String userSearchUrl = '$baseUrl/api/v1/user/get-data-search';

  Future<UserSearchResponse> fetchUserData() async {
    try {
      String? token = CacheHelper.getToken();
      print('Token: $token');
      final headers = {
        'Authorization': 'Bearer $token',
      };
      final response = await http.get(Uri.parse(userSearchUrl), headers: headers);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Response body: ${response.body}'); 
        return UserSearchResponse.fromJson(data);
      } else {
        print('Error: Failed to load user data with status code ${response.statusCode}');
        print('Response body: ${response.body}'); 
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      print('Error occurred: $e');
      throw Exception('Error: $e');
    }
  }
}
