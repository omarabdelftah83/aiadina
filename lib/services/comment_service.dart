import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ourhands/utils/const.dart';
import '../helpers/cache_helper.dart';
import '../models/comments_model.dart';  

class CommentService {
  final String commentUrl = '$baseUrl/api/v1/comments';
  final String actionCommentUrl = '$baseUrl/api/v1/comments';


Future<bool> updateComment(String commentId, String newText) async {
  final url = Uri.parse('$actionCommentUrl$commentId');
  final body = jsonEncode({
    'text': newText,
  });

  String? token = CacheHelper.getToken();
  var headers = {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
  };

  // Create the request
  var request = http.Request('PATCH', url)
    ..headers.addAll(headers)
    ..body = body;

  print('Updating comment $commentId with new text: $newText');
  print('Sending request to $url with body: $body and headers: $headers');

  try {
    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    print('Response status code: ${response.statusCode}');
    print('Response body: $responseBody');

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonResponse = json.decode(responseBody);
      print('Response JSON: $jsonResponse');
      return jsonResponse['status'] == 'SUCCESS';
    } else {
      print('Failed to update comment: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    print('Error updating comment: $e');
    return false;
  }
}




Future<bool> deleteComment(String commentId) async {
  final url = Uri.parse('$actionCommentUrl$commentId');

  String? token = CacheHelper.getToken();
  var headers = {
    'Authorization': 'Bearer $token',
  };
  var request = http.Request('DELETE', url)
    ..headers.addAll(headers);

  print('Deleting comment $commentId');
  print('Sending request to $url');

  try {
    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();
    print('Response status code: ${response.statusCode}');
    print('Response body: $responseBody');

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonResponse = json.decode(responseBody);
      print('Response JSON: $jsonResponse');
      return jsonResponse['status'] == 'SUCCESS';
    } else {
      print('Failed to delete comment: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    print('Error deleting comment: $e');
    return false;
  }
}


 Future<bool> postComment(String postId, String text) async {
    String? token = CacheHelper.getToken();
    var headers = {
      'Content-Type': 'application/json',
    };
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    var body = jsonEncode({
      'postId': postId,
      'text': text,
    });

    print('Posting comment to $commentUrl with body: $body');

    try {
      var request = http.Request('POST', Uri.parse(commentUrl));
      request.body = body;
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 201) {
        print(await response.stream.bytesToString());
        print('Comment successfully posted.');
        return true; 
      } else {
        print('Failed to post comment. Reason: ${response.reasonPhrase}');
        return false; 
      }
    } catch (error) {
      print('Error posting comment: $error');
      return false; 
    }
  }
 Future<CommentResponse?> fetchComments(String postId) async {
  String? token = CacheHelper.getToken();
  var headers = {
    'Content-Type': 'application/json',
  };

  if (token != null) {
    headers['Authorization'] = 'Bearer $token';
  }

  String url = '$commentUrl/$postId';

  print('Fetching comments from $url with headers: $headers');

  try {
    final response = await http.get(Uri.parse(url), headers: headers);

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return CommentResponse.fromJson(jsonResponse);
    } else {
      print('Failed to load comments');
      return null;
    }
  } catch (error) {
    print('Error fetching comments: $error');
    return null;
  }
}
}