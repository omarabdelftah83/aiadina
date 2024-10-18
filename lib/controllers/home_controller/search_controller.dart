import 'package:get/get.dart';
import 'package:ourhands/models/search_response_model.dart';

import '../../services/result of search.dart';

class SearchHomeController extends GetxController {
  var isLoading = false.obs;
  var searchResults = <UserData>[].obs;  
  var errorMessage = ''.obs;
  final SearchService searchService;
  SearchHomeController(this.searchService);
  Future<void> fetchSearchResults(String city, String location, String job) async {
    try {
      isLoading(true);
      errorMessage('');
      SearchResponse searchResponse = await searchService.fetchSearchResults(city, location, job);

      if (searchResponse.status == "SUCCESS" && searchResponse.data != null) {
        searchResults.assignAll(searchResponse.data!); 
        print('Updated Search Results: ${searchResults}');
      } else {
        errorMessage.value = searchResponse.message ?? 'Unknown error';
      }
    } catch (e) {
      errorMessage.value = 'Error fetching search results: $e';
    } finally {
      isLoading(false);
    }
  }

  void clearSearchResults() {
    searchResults.clear();
    errorMessage('');
  }
}
