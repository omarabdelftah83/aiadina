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
    // Perform the login request
    LoginResponse response = await _authService.login(
      email: emailController.text,
      password: passwordController.text,
    );

    isLoading.value = false;

    // Check if the login was successful
    if (response.status?.toLowerCase() == 'success') {
      print('Login successful, response message: ${response.message}');
      await cacheUserData(response.user!.id, response.token);
      Get.snackbar(
        'نجاح',
        response.message ?? 'تم تسجيل الدخول بنجاح',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
      );
      Get.offAll(HomePage());
    } else {
      // Handle the case where login failed and show the message
      String errorMessage = response.message ?? 'البريد الإلكتروني أو كلمة المرور غير صحيحة';
      print('Login failed, response message: $errorMessage');
      Get.snackbar(
        'خطأ',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  } catch (e) {
    isLoading.value = false;

    // If an exception occurs, handle it and show a generic error message
    print('Login failed, exception: $e');
    Get.snackbar(
      'خطأ',
      'حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى لاحقاً.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
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
