import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/const.dart';

class PasswordRecoveryService {
  final String _sendRecoveryemail = '$baseUrl/api/v1/auth/forget-password';
  final String _verifyotp = '$baseUrl/api/v1/auth/verify-otp';
  final String _resetPassword = '$baseUrl/api/v1/auth/reset-password';

  Future<Map<String, dynamic>> sendRecoveryEmail(String email) async {
    try {
      print('Sending request to $_sendRecoveryemail with body: {"email": "$email"}');
      final response = await http.post(
        Uri.parse(_sendRecoveryemail),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Error: Failed to send recovery email with status code ${response.statusCode}');
        throw Exception('Failed to send recovery email');
      }
    } catch (e) {
      print('Error occurred: $e');
      rethrow; 
    }
  }

  Future<Map<String, dynamic>> verifyOtp(String otp) async {
  var headers = {
    'Content-Type': 'application/json',
  };
  print('Sending request to $_verifyotp with header: $headers and body: {"otp": "$otp"}');
  var request = http.Request('POST', Uri.parse(_verifyotp));
  request.body = json.encode({"otp": otp});
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  print('Response status code: ${response.statusCode}');  
  final responseBody = await response.stream.bytesToString();
  print('Response body: $responseBody');
  if (response.statusCode == 200) {
    return json.decode(responseBody);
  } else {
    print('Error: Verification failed with status code ${response.statusCode}');
    return json.decode(responseBody);
  }
}

  Future<void> resetPassword(String email, String password, String confirmPassword) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(_resetPassword));
    request.body = json.encode({
      "email": email,
      "password": password,
      "confirmPassword": confirmPassword
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print('Error: ${response.reasonPhrase}');
    }
  }
}
