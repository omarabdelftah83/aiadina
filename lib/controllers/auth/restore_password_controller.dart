import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordRecoveryController extends GetxController {
  final PageController pageController = PageController();
  final currentPage = 0.obs;

  void nextPage() {
    if (currentPage.value < 2) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      currentPage.value++;
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      currentPage.value--;
    }
  }

  // Dispose controller
  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
