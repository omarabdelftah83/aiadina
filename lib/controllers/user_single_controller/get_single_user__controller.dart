import 'package:get/get.dart';
import '../../models/get_single_user.dart';
import '../../services/get_single_user.dart';

class UserController extends GetxController {
  var isLoading = true.obs;
  var userResponse = UserResponse(status: '', message: '', data: Data(user: null)).obs; 
  var errorMessage = ''.obs;
  final GetSingleUser userService;
  final String userId; 

  UserController({required this.userService, required this.userId});

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      isLoading(true);
      print('Fetching user data with user id: $userId');

      userResponse.value = await userService.fetchUser(userId); 

      print('Response status: ${userResponse.value.status}');
      print('Response message: ${userResponse.value.message}');

      if (userResponse.value.status?.toLowerCase() == 'success') {
      } else {
        errorMessage.value = userResponse.value.message ?? 'Unknown error';
      }
    } catch (e) {
      print('Error occurred: $e');
      errorMessage.value = 'Failed to load user data: ${e.toString()}';
    } finally {
      isLoading(false);
    }
  }
}
