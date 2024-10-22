import 'dart:async';
import 'package:flutter/material.dart'; 
import 'package:get/get.dart';
import 'package:ourhands/services/password_recovery_service.dart';
import 'package:ourhands/views/auth/widgets/verification_code_page.dart';
import 'package:ourhands/views/home/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user_model_register.dart';
import '../../views/auth/login_screen.dart';
import '../../views/auth/widgets/new_password_pgae.dart';
class PasswordRecoveryController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController(); 
  final TextEditingController passwordController = TextEditingController(); 
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController passwordControllerProfile = TextEditingController(); 
  final TextEditingController confirmPasswordControllerProfile = TextEditingController();
  final PageController pageController = PageController();
  final currentPage = 0.obs;
  final PasswordRecoveryService service;
  var isLoading = false.obs;
  String email = '';
  bool isRecovering = false;
  var isResendEnabled = true.obs;
  var countdownTimer = 30.obs;
  Timer? _timer;
  PasswordRecoveryController(this.service);

  void startResendTimer() {
    isResendEnabled.value = false;
    countdownTimer.value = 30;

    _timer?.cancel(); 
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdownTimer.value > 0) {
        countdownTimer.value--;
      } else {
        _timer?.cancel();
        isResendEnabled.value = true; 
      }
    });
  }

  Future<void> resendOtp() async {
    if (!isResendEnabled.value) return; 
    isResendEnabled.value = false; 
    startResendTimer(); 
    await service.sendRecoveryEmail(email);
    showSnackbar('Success', 'OTP has been resent successfully.', isSuccess: true);
  }

 

  Future<void> sendRecoveryEmail() async {
    final emailInput = emailController.text.trim();
    if (emailInput.isNotEmpty) {
      isLoading.value = true;
      isRecovering = true; 
      try {
        final response = await service.sendRecoveryEmail(emailInput);
        final loginResponse = LoginResponse.fromJson(response);

        if (loginResponse.status == 'success') {
          email = emailInput;
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('recoveryEmail', emailInput);
          print('Email saved to preferences: $emailInput');
          
          showSnackbar('Success', loginResponse.message, isSuccess: true);
          await Get.to(VerificationCodePage());
        } else {
          showSnackbar('Error', loginResponse.message, isSuccess: false);
        }
      } catch (e) {
        showSnackbar('Error', 'An error occurred while sending recovery email. Please try again.', isSuccess: false);
      } finally {
        isLoading.value = false;
      }
    } else {
      showSnackbar('Error', 'Please enter your email', isSuccess: false);
    }
  }

  Future<void> verifyOtp() async {
    final otp = otpController.text.trim(); 
    if (otp.isNotEmpty) {
      isLoading.value = true;
      try {
        final response = await service.verifyOtp(otp);
        print('Response from service: $response');

        if (response['message'] == 'success') {
          showSnackbar('Success', 'OTP verified successfully', isSuccess: true);
          Get.off(NewPasswordPage(), arguments: email);  
        } else {
          showSnackbar('Error', response['message'] ?? 'Unknown error', isSuccess: false);
        }
      } catch (e) {
        print('Error');
      } finally {
        isLoading.value = false;
      }
    } else {
      showSnackbar('Error', 'Please enter the OTP', isSuccess: false);
    }
  }

    Future<void> resetPassword() async {
      final password = passwordController.text.trim(); 
      final confirmPassword = confirmPasswordController.text.trim();

      final prefs = await SharedPreferences.getInstance();
      email = prefs.getString('recoveryEmail') ?? '';

      if (email.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty) {
        if (password == confirmPassword) {
          if (password.length < 6) {
            showSnackbar('Error', 'Password must be at least 6 characters long.', isSuccess: false);
            return;
          }
          isLoading.value = true;
          try {
            await service.resetPassword(email, password, confirmPassword);
            showSnackbar('Success', 'Password reset successfully', isSuccess: true);
            Get.to(() => const LoginPage());
          } catch (e) {
          } finally {
            isLoading.value = false;
          }
        } else {
          showSnackbar('Error', 'Passwords do not match', isSuccess: false);
        }
      } else {
        showSnackbar('Error', 'Please fill all fields', isSuccess: false);
      }
    }

    Future<void> resetPasswordSettings(String? email) async {
      print('Email: $email');
      print('Password: ${passwordControllerProfile.text}');
      print('Confirm Password: ${confirmPasswordControllerProfile.text}');

      final passwordSettings = passwordControllerProfile.text.trim(); 
      final confirmPasswordSettings = confirmPasswordControllerProfile.text.trim();
      if (email != null && email.isNotEmpty && passwordSettings.isNotEmpty && confirmPasswordSettings.isNotEmpty) {
        if (passwordSettings == confirmPasswordSettings) {
          if (passwordSettings.length < 6) {
            showSnackbar('Error', 'Password must be at least 6 characters long.', isSuccess: false);
            return;
          }

          isLoading.value = true;
          try {
            print('Attempting to reset password');
            await service.resetPassword(email, passwordSettings, confirmPasswordSettings);
            print('Password reset success');
            showSnackbar('Success', 'Password reset successfully', isSuccess: true);
            Get.to(() => HomePage());
          } on Exception catch (e) {
            print('Error occurred while resetting password: $e');
          } finally {
            isLoading.value = false;
          }
        } else {
          showSnackbar('Error', 'Passwords do not match', isSuccess: false);
        }
      } else {
        showSnackbar('Error', 'Please fill all fields', isSuccess: false);
      }
    }




  void handleCancelOtp() {
    if (isRecovering) {
      Get.off(()=> VerificationCodePage()); 
    } else {
      Get.off( ()=> const LoginPage()); 
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    pageController.dispose();
    emailController.dispose();
    otpController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    passwordControllerProfile.dispose();
    confirmPasswordControllerProfile.dispose();
    super.onClose();
  }

  void showSnackbar(String s, result, {required bool isSuccess}) {}
}
