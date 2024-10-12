import 'dart:convert';
import 'package:http/http.dart' as http;
import '../helpers/cache_helper.dart';
import '../models/get_all_category_model.dart';
import '../utils/const.dart'; 

class GetAllCategoryService {
  Future<GetAllCategoryResponse?> fetchCategories() async {
    const String url = '$baseUrl/api/v1/category'; 
    String? token = CacheHelper.getToken();

    if (token == null || token.isEmpty) {
      throw Exception('Token not found');
    }

    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      print('Response status code-------------------: ${response.statusCode}');
      print('Response body-----------------: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return GetAllCategoryResponse.fromJson(jsonResponse);
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
