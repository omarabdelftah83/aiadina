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
        'Content-Type': 'application/json', // Adding Content-Type for consistency
      },
    );

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      return UserResponse.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 403) {
      print('Access denied: ${response.body}');
      throw Exception('Access denied. Please check permissions.');
    } else {
      print('Error: Failed to load user data: ${response.statusCode}');
      throw Exception('Failed to load user data: ${response.statusCode}');
    }
  }
}

class DeleteItem {
  Future<void> deleteItem(String postId) async {
    final String deletePostUrl = '$baseUrl/api/v1/posts/$postId';
    String? token = CacheHelper.getToken();

    if (token == null || token.isEmpty) {
      throw Exception('Token not found');
    }

    print('Deleting item with ID: $postId from $deletePostUrl');

    final response = await http.delete(
      Uri.parse(deletePostUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json', 
      },
    );

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 204) {
      print('Item deleted successfully');
    } else if (response.statusCode == 403) {
      print('Access denied: ${response.body}');
      throw Exception('Access denied. Please check permissions.');
    } else {
      print('Error: Failed to delete item: ${response.statusCode}');
      throw Exception('Failed to delete item: ${response.statusCode}');
    }
  }
}
