import 'dart:convert';

import 'package:http_parser/http_parser.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';  
import '../helpers/cache_helper.dart';
import '../utils/const.dart';

class AdService {
  String? _errorMessage; 
  Future<bool> createAd({
    required String title,
    required String description,
    required String job,
    required List<File> images,
  }) async {
    String? token = CacheHelper.getToken();
    print('createAd: token: $token');
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/api/v1/posts'));
    request.headers['Authorization'] = 'Bearer $token';
    print('createAd: headers: ${request.headers}');
    request.fields['title'] = title;
    print('createAd: title: $title');
    request.fields['description'] = description;
    print('createAd: description: $description');
    request.fields['job'] = job;
    print('createAd: job: $job');
    for (var image in images) {
      final mimeType = lookupMimeType(image.path);
      print('createAd: mimeType: $mimeType');
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        image.path,
        contentType: mimeType != null ? MediaType(mimeType.split('/')[0], mimeType.split('/')[1]) : null,
      ));
      print('createAd: image: ${image.path}');
    }
    var response = await request.send();

    if (response.statusCode == 201) {
      print('Ad created successfully');
      return true;
    } else {
      print('Failed to create ad: ${response.statusCode}');
      print('Response body: ${await response.stream.bytesToString()}');
      return false;
    }
  }

  String? getErrorMessage() {
    if (_errorMessage != null) {
      final errorResponse = json.decode(_errorMessage!);
      return errorResponse['message']; // الحصول على الرسالة من الرد
    }
    return null;
  }
}

