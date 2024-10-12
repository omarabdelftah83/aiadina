import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences
import '../../models/user_model_register.dart';
import '../../services/login_service.dart';
import '../../views/home/home_page.dart';

 class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKeyLogin = GlobalKey<FormState>();
  final RxBool isLoading = false.obs;
  final AuthLoginService _authService;
  
  LoginController(this._authService);

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    return null;
  }

  Future<void> loginUser() async {
    if (!formKeyLogin.currentState!.validate()) return;

    isLoading.value = true;

    try {
      LoginResponse response = await _authService.login(
        email: emailController.text,
        password: passwordController.text,
      );

      isLoading.value = false;

      if (response.status == 'SUCCESS') {
        print('Login successful, response message: ${response.message}');
        await cacheUserData(response.user!.id, response.token);
        Get.snackbar('Success', response.message,
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
        Get.offAll(HomePage());
      } else {
        print('Login failed, response message: ${response.message}');
        Get.snackbar('Error', response.message,
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      }
    } on Exception catch (e) {
      isLoading.value = false;
      print('Login failed, exception: $e');
      Get.snackbar('Error', 'An error occurred during login: $e',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    }
  }

  // Method to cache the user ID and token
  Future<void> cacheUserData(String userId, String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);  
    await prefs.setString('token', token);    
    print('User ID and token cached successfully.');
  }

  // Method to retrieve cached user ID
  Future<String?> getCachedUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }
}
