import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import '../helpers/cache_helper.dart'; 
import '../utils/const.dart'; 
class ProfileImageService {
  String? _errorMessage;
  final String _baseUrl = '$baseUrl/api/v1/user/profile-photo';

  Future<String?> changeProfileImage(String imagePath) async {
    String? token = CacheHelper.getToken();
    if (token == null) {
      print('Error: No token found');
      return null;
    }

    try {
      var request = http.MultipartRequest('POST', Uri.parse(_baseUrl));
      request.headers['Authorization'] = 'Bearer $token';

      final mimeType = lookupMimeType(imagePath);
      var contentType = mimeType != null
          ? MediaType(mimeType.split('/')[0], mimeType.split('/')[1])
          : null;

      request.files.add(await http.MultipartFile.fromPath('image', imagePath, contentType: contentType));

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseBody);
        String newImagePath = jsonResponse['data']['profilePhoto']; 
        return '$baseUrl/$newImagePath';
      } else {
        print('Failed to update profile image: ${response.reasonPhrase}');
        print('Response body: ${await response.stream.bytesToString()}');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }

  String? getErrorMessage() {
    if (_errorMessage != null) {
      final errorResponse = json.decode(_errorMessage!);
      return errorResponse['message'];
    }
    return null;
  }
}
