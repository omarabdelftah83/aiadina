import 'package:get/get.dart';
import 'package:ourhands/models/user_search_response.dart'; // Import the model
import 'package:ourhands/services/user_search-3_service.dart';

class HomeController extends GetxController {
  final UserSearchService _userSearchService = UserSearchService();

  RxList<String> locations = <String>[].obs;
  RxList<String?> jobs = <String?>[].obs;
  RxList<String> cities = <String>[].obs;
  RxString selectedLocation = ''.obs;
  RxString selectedJob = ''.obs;
  RxString selectedCity = ''.obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      isLoading.value = true;
      final UserSearchResponse data = await _userSearchService.fetchUserData();
      locations.assignAll(data.locations);
      jobs.assignAll(data.jobs);
      cities.assignAll(data.cities);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load user data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void updateSelectedLocation(String value) {
    selectedLocation.value = value;
  }

  void updateSelectedJob(String value) {
    selectedJob.value = value;
  }

  void updateSelectedCity(String value) {
    selectedCity.value = value;
  }




}
