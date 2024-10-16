import 'dart:convert';
import 'package:http/http.dart' as http;
import '../helpers/cache_helper.dart';

class UserService {
  final String _baseUrl = 'http://194.164.77.238:8002/api/v1';

  Future<bool> updateUser({
    required String userId,
    required String name,
    required String phone,
    required String email,
  }) async {
    String? token = CacheHelper.getToken();
  var headers = {
    'Authorization': 'Bearer $token',
  };

    var body = json.encode({
      "name": name,
      "phone": phone,
      "email": email,
    });

    var url = Uri.parse('$_baseUrl/user/$userId');

    var response = await http.patch(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      print('User updated: ${response.body}');
      return true;
    } else {
      print('Failed to update user: ${response.body}');
      return false;
    }
  }
}
