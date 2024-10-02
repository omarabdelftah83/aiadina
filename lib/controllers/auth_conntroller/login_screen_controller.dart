import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
}
