import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackbar(String title, String message, {bool isSuccess = true}) {
    if (Get.isSnackbarOpen) {
      Get.back();
    }
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isSuccess ? Colors.green[100] : Colors.red[100],
      colorText: Colors.black,
      duration: const Duration(seconds: 3),
    );
  }