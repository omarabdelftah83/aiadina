import 'dart:convert';
import 'package:http/http.dart' as http;
import '../helpers/cache_helper.dart';
import '../models/search_response_model.dart';

class SearchService {
  final String searchUrl = 'http://194.164.77.238:8002/api/v1/user/filter-data-search';

  Future<SearchResponse> fetchSearchResults(String city, String location, String job) async {
    try {
      String? token = CacheHelper.getToken();

      if (token == null || token.isEmpty) {
        throw Exception('Token not found');
      }

      var headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      // Updated to include query parameters for city, location, and job
      var response = await http.get(
        Uri.parse('$searchUrl?city=$city&location=$location&job=$job'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        String responseBody = response.body;
        print('Response body: $responseBody');

        var jsonResponse = jsonDecode(responseBody);
        SearchResponse searchResponse = SearchResponse.fromJson(jsonResponse);

        return searchResponse;
      } else {
        print('Error: ${response.reasonPhrase}');
        throw Exception('Failed to load search data');
      }
    } catch (e) {
      print('Error occurred: $e');
      throw Exception('Failed to fetch search data: $e');
    }
  }
}
