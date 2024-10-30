import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ourhands/onbording_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
      return 'البريد الإلكتروني لا يمكن أن يكون فارغًا';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'كلمة المرور لا يمكن أن تكون فارغة';
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

      if (response.status.toLowerCase() == 'success') {
        await cacheUserData(response.user!.id, response.token);
        Get.snackbar(
          'نجاح',
          'تم تسجيل الدخول بنجاح' ?? 'حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
        );
        Get.offAll(HomePage());
      } else {
        String errorMessage = response.message ?? 'البريد الإلكتروني أو كلمة المرور غير صحيحة';
        print('فشل تسجيل الدخول، الرسالة: $errorMessage');
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

      print('فشل تسجيل الدخول، استثناء: $e');
      Get.snackbar(
        'خطأ',
        'حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى لاحقاً.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> logOut() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      Get.offAll(() => const OnBording());
    } catch (e) {
      Get.snackbar(
        'خطأ',
        'فشل في تسجيل الخروج. حاول مرة أخرى.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> cacheUserData(String userId, String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);  
    await prefs.setString('token', token);    
  }

  Future<String?> getCachedUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }
}
