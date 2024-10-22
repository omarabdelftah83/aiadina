import 'dart:async';
import 'dart:io'; 
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
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

  Future<void> fetchUserData() async {
    try {
            bool isConnected = await InternetConnectionChecker().hasConnection;
      if (!isConnected) {
        errorMessage.value = 'No internet connection. Please check your network and try again.';
        isLoading(false);
        return;
      }

      isLoading(true);
      print('Fetching user data with user id: $userId');

      final response = await userService.fetchUser(userId);
      userResponse.value = response;

      if (response.status?.toLowerCase() == 'success') {
        errorMessage.value = '';
      } else {
        errorMessage.value = response.message ?? 'Unknown error occurred';
      }
    } on SocketException {
      errorMessage.value = 'Network error. Please check your internet connection and try again.';
    } on TimeoutException {
      errorMessage.value = 'Request timed out. Please try again later.';
    } catch (e) {
      print('Error occurred: $e');
      errorMessage.value = 'Failed to load user data: ${e.toString()}';
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    _userStreamController.close(); 
    super.onClose();
  }

  Future<void> refreshUserData() async {
    await fetchUserData();
  }
}
