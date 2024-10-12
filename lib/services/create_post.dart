import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart'; 
import 'package:http_parser/http_parser.dart';
import 'package:ourhands/utils/const.dart';

import '../helpers/cache_helper.dart'; 

class PostService {
  static const String _baseUrl = '$baseUrl/api/v1/posts';

  
  Future<void> createPost({
    required String title,
    required String description,
    required String job,
    required List<File> images,
  }) async {
    String? token = CacheHelper.getToken();
  var headers = {
    'Authorization': 'Bearer $token',
  };
    var request = http.MultipartRequest('POST', Uri.parse('$_baseUrl/posts'));
    request.fields.addAll({
      'title': title,
      'description': description,
      'job': job,
    });
    for (var image in images) {
      try {
        String mimeType = lookupMimeType(image.path) ?? 'image/jpeg';
        print('Adding image: ${image.path}, MIME type: $mimeType');
        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            image.path,
            contentType: MediaType(mimeType.split('/')[0], mimeType.split('/')[1]),
          ),
        );
      } catch (e) {
        print('Error adding image: ${image.path} - $e');
      }
    }

    request.headers.addAll(headers);

    try {
      print('Sending request to $_baseUrl/posts with fields: ${request.fields} and headers: $headers');
      http.StreamedResponse response = await request.send();

      print('Response status code: ${response.statusCode}');
      if (response.statusCode == 201) {
        String responseBody = await response.stream.bytesToString();
        var responseData = jsonDecode(responseBody);
        print('Post created successfully: $responseData');
      } else {
        String responseError = await response.stream.bytesToString();
        print('Failed to create post. Status Code: ${response.statusCode}');
        print('Error response: $responseError');
      }
    } catch (e) {
      print('Error creating post: $e');
    }
  }
}
