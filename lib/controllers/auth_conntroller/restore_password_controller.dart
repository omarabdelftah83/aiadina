import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; 
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ourhands/services/password_recovery_service.dart';
import 'package:ourhands/views/auth/widgets/verification_code_page.dart';
import 'package:ourhands/views/home/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user_model_register.dart';
import '../../views/auth/login_screen.dart';
import '../../views/auth/widgets/new_password_pgae.dart';
import '../../utils/images.dart'; // Make sure this points to the correct path for your assets

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

  void showLoadingDialog() {
    Get.dialog(
      Center(
        child: Lottie.asset(
          AssetImages.loading,
          width: 100.w,
          height: 100.h,
        ),
      ),
      barrierDismissible: false,
    );
  }

  void hideLoadingDialog() {
    if (Get.isDialogOpen ?? false) {
      Get.back(); // Close the dialog if it's open
    }
  }

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
    showSnackbar('نجاح', 'تم إرسال رمز التحقق مرة أخرى بنجاح.', isSuccess: true);
  }

 Future<void> sendRecoveryEmail() async {
  final emailInput = emailController.text.trim();
  if (emailInput.isNotEmpty) {
    // Regex for validating email format
    final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    
    // Check if email format is valid
    if (!emailRegex.hasMatch(emailInput)) {
      showSnackbar('خطأ', 'يرجى إدخال بريد إلكتروني صالح', isSuccess: false);
      return;
    }

    isLoading.value = true;
    isRecovering = true; 
    showLoadingDialog(); // Show loading animation
    try {
      final response = await service.sendRecoveryEmail(emailInput);
      final loginResponse = LoginResponse.fromJson(response);

      if (loginResponse.status == 'success') {
        email = emailInput;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('recoveryEmail', emailInput);
        
        showSnackbar('نجاح', loginResponse.message, isSuccess: true);
        
        // Navigate with a transition and duration
        await Get.to(
          VerificationCodePage(),
          transition: Transition.rightToLeft,
          duration: Duration(milliseconds: 500),
        );
      } else {
        showSnackbar('خطأ', loginResponse.message, isSuccess: false);
      }
    } catch (e) {
      showSnackbar('خطأ', 'حدث خطأ أثناء إرسال البريد الإلكتروني. يرجى المحاولة مرة أخرى.', isSuccess: false);
    } finally {
      hideLoadingDialog(); // Hide loading animation
      isLoading.value = false;
    }
  } else {
    showSnackbar('خطأ', 'يرجى إدخال بريدك الإلكتروني', isSuccess: false);
  }
}

  Future<void> verifyOtp() async {
    final otp = otpController.text.trim(); 
    if (otp.isNotEmpty) {
      isLoading.value = true;
      showLoadingDialog(); // Show loading animation
      try {
        final response = await service.verifyOtp(otp);

        if (response['message'] == 'success') {
          showSnackbar('نجاح', 'تم التحقق من الرمز بنجاح', isSuccess: true);
          
          // Navigate with a transition and duration
          await Get.off(
            () => NewPasswordPage(),
            arguments: email,
            transition: Transition.leftToRight,
            duration: Duration(milliseconds: 500),
          );
        } else {
          showSnackbar('خطأ', response['message'] ?? 'خطأ غير معروف', isSuccess: false);
        }
      } catch (e) {
        showSnackbar('خطأ', 'حدث خطأ أثناء التحقق من الرمز. يرجى المحاولة مرة أخرى.', isSuccess: false);
      } finally {
        hideLoadingDialog(); // Hide loading animation
        isLoading.value = false;
      }
    } else {
      showSnackbar('خطأ', 'يرجى إدخال الرمز', isSuccess: false);
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
          showSnackbar('خطأ', 'يجب أن تكون كلمة المرور على الأقل 6 أحرف.', isSuccess: false);
          return;
        }
        isLoading.value = true;
        showLoadingDialog(); // Show loading animation
        try {
          await service.resetPassword(email, password, confirmPassword);
          showSnackbar('نجاح', 'تم إعادة تعيين كلمة المرور بنجاح', isSuccess: true);
          
          // Navigate with a transition and duration
          await Get.to(() => const LoginPage());
        } catch (e) {
          showSnackbar('خطأ', 'حدث خطأ أثناء إعادة تعيين كلمة المرور.', isSuccess: false);
        } finally {
          hideLoadingDialog(); // Hide loading animation
          isLoading.value = false;
        }
      } else {
        showSnackbar('خطأ', 'كلمتا المرور غير متطابقتين', isSuccess: false);
      }
    } else {
      showSnackbar('خطأ', 'يرجى ملء جميع الحقول', isSuccess: false);
    }
  }

  Future<void> resetPasswordSettings(String? email) async {
    final passwordSettings = passwordControllerProfile.text.trim(); 
    final confirmPasswordSettings = confirmPasswordControllerProfile.text.trim();
    if (email != null && email.isNotEmpty && passwordSettings.isNotEmpty && confirmPasswordSettings.isNotEmpty) {
      if (passwordSettings == confirmPasswordSettings) {
        if (passwordSettings.length < 6) {
          showSnackbar('خطأ', 'يجب أن تكون كلمة المرور على الأقل 6 أحرف.', isSuccess: false);
          return;
        }

        isLoading.value = true;
        showLoadingDialog(); // Show loading animation
        try {
          await service.resetPassword(email, passwordSettings, confirmPasswordSettings);
          showSnackbar('نجاح', 'تم إعادة تعيين كلمة المرور بنجاح', isSuccess: true);
          
          // Navigate with a transition and duration
          await Get.to(() => HomePage());
        } catch (e) {
          showSnackbar('خطأ', 'حدث خطأ أثناء إعادة تعيين كلمة المرور.', isSuccess: false);
        } finally {
          hideLoadingDialog(); // Hide loading animation
          isLoading.value = false;
        }
      } else {
        showSnackbar('خطأ', 'كلمتا المرور غير متطابقتين', isSuccess: false);
      }
    } else {
      showSnackbar('خطأ', 'يرجى ملء جميع الحقول', isSuccess: false);
    }
  }

  void handleCancelOtp() {
    isLoading.value = true;
    showLoadingDialog(); // Show loading animation
    if (isRecovering) {
      Get.off(() => VerificationCodePage());
    } else {
      Get.off(() => const LoginPage());
    }
    hideLoadingDialog(); // Hide loading animation
    isLoading.value = false;
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

  void showSnackbar(String title, String message, {required bool isSuccess}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isSuccess ? Colors.green : Colors.red,
      colorText: Colors.white,
    );
  }
}
