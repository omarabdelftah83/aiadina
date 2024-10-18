import 'dart:convert';
import 'package:http/http.dart' as http;
import '../helpers/cache_helper.dart';

class UserService {
  final String _baseUrl = 'http://194.164.77.238:8002/api/v1/user/';

  Future<bool> updateUser({
    required String userId,
    String? name,
    String? phone,
    String? email,
    String? location, 
  }) async {
    String? token = CacheHelper.getToken();
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final body = <String, dynamic>{};
    if (name != null) body["name"] = name;     
    if (phone != null) body["phone"] = phone;  
    if (email != null) body["email"] = email;  
    if (location != null) body["location"] = location; 

    var url = Uri.parse('$_baseUrl$userId');

    var response = await http.patch(url, headers: headers, body: json.encode(body));

    if (response.statusCode == 200) {
      print('User updated successfully');
      return true;
    } else {
      print('Failed to update user. Error: ${response.body}');
      return false;
    }
  }
}
