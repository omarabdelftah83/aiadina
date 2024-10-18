import 'dart:async';
import 'package:get/get.dart';
import '../../models/get_single_user.dart';
import '../../services/get_single_user.dart';

class UserController extends GetxController {
  var isLoading = true.obs;
  var userResponse = UserResponse(status: '', message: '', data: Data(user: null)).obs; 
  var errorMessage = ''.obs;
  final GetSingleUser userService;
  final String userId; 

  final StreamController<UserResponse> _userStreamController = StreamController<UserResponse>.broadcast();
  Stream<UserResponse> get userStream => _userStreamController.stream;

  UserController({required this.userService, required this.userId});

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<UserResponse> fetchUserData() async {
  try {
    isLoading(true);
    print('Fetching user data with user id: $userId');

    final response = await userService.fetchUser(userId);
    userResponse.value = response;

    if (response.status?.toLowerCase() == 'success') {
      errorMessage.value = ''; // Clear any error messages
      return response; // إرجاع الاستجابة الناجحة
    } else {
      errorMessage.value = response.message ?? 'Unknown error';
      throw Exception(errorMessage.value);
    }
  } catch (e) {
    print('Error occurred: $e');
    errorMessage.value = 'Failed to load user data: ${e.toString()}';
    throw Exception(errorMessage.value);
  } finally {
    isLoading(false);
  }
}

  @override
  void onClose() {
    _userStreamController.close(); // Close the stream when the controller is disposed
    super.onClose();
  }

  // Refresh method to manually fetch data
  Future<void> refreshUserData() async {
    await fetchUserData();
  }
}
