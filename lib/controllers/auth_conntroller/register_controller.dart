import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ourhands/models/user_model_register.dart';
import 'package:ourhands/views/home/home_page.dart';
import '../../services/register_service.dart';

class RegisterController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController confirmationController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController districtController = TextEditingController(); 

  final formKeyLogin = GlobalKey<FormState>();
  final RxBool isLoading = false.obs;

  final AuthService _authService;
 RegisterController(this._authService);
  String? validateEmail(String value) {
    if (value.isEmpty) return 'Email cannot be empty';
    if (!GetUtils.isEmail(value)) return 'Enter a valid email';
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) return 'Password cannot be empty';
    if (value.length < 6) return 'Password must be at least 6 characters long';
    return null;
  }

  String? validateMobile(String value) {
    if (value.isEmpty) return 'Mobile cannot be empty';
    if (!GetUtils.isPhoneNumber(value)) return 'Enter a valid phone number';
    return null;
  }

  Future<void> registerUser() async {
    if (!formKeyLogin.currentState!.validate()) return;

    isLoading.value = true;

    LoginResponse response = await _authService.register(
      name: nameController.text,
      phone: mobileController.text,
      city: cityController.text,
      location: districtController.text,
      email: emailController.text,
      password: passwordController.text,
      confirmPassword: confirmationController.text,
    );

    isLoading.value = false;

    if (response.status == 'success' || response.status == 'SUCCESS') {
      Get.snackbar('Success', response.message,
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
      
    
      Get.to( HomePage());
    } else {
      Get.snackbar('Error', response.message,
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    }
  }

  void handleSignUp() async {
    if (formKeyLogin.currentState?.validate() ?? false) {
      await registerUser();
    }
  }
}
