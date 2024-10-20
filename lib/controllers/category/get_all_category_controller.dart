import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ourhands/services/get_all_category.dart';
import 'package:ourhands/services/ad_service.dart';
import '../../models/get_all_category_model.dart';
import 'dart:io';

class AddAdsController extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  final GetAllCategoryService _categoryService = GetAllCategoryService();
  final AdService _adService = AdService();
  var selectedJob = Rx<String?>(null);


  List<XFile> images = [];
  List<String> dropdownItems = [];
  bool isLoading = true;

  AddAdsController() {
    fetchCategories();
  }

  Future<void> pickImages() async {
    final List<XFile>? selectedImages = await _picker.pickMultiImage();
    if (selectedImages != null) {
      images.addAll(selectedImages);
      notifyListeners(); // Notify listeners to update UI
    }
  }

  Future<void> fetchCategories() async {
    try {
      final GetAllCategoryResponse? response = await _categoryService.fetchCategories();
      if (response != null && response.categories != null) {
        dropdownItems = response.categories!.map((category) => category.name!).toList();
      } else {
        dropdownItems = ['No Categories Available'];
      }
    } catch (e) {
      print('Error fetching categories: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void removeImage(int index) {
    images.removeAt(index);
    notifyListeners();
  }


  Future<void> createAd(String title, String description, String job) async {
    if (images.isEmpty) {
      Get.snackbar(
        "خطأ",
        "يرجى تحديد صور قبل محاولة إنشاء الإعلان",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return; // تأكد من تحديد صور قبل محاولة إنشاء الإعلان
    }

    // التحقق من طول الوصف
    if (description.length < 10) {
      Get.snackbar(
        "خطأ",
        "يجب أن يكون الوصف على الأقل 10 أحرف.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // تحويل XFile إلى File
    List<File> imageFiles = images.map((image) => File(image.path)).toList();

    isLoading = true;
    notifyListeners(); // Notify listeners to update UI

    // إنشاء الإعلان
    bool success = await _adService.createAd(
      title: title,
      description: description,
      job: job,
      images: imageFiles,
    );

    if (success) {
      Get.snackbar(
        "نجاح",
        "تم إنشاء الإعلان بنجاح",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      print('Ad created successfully');
    } else {
      print('Failed to create ad');
      Get.snackbar(
        "فشل",
        "فشل في إنشاء الإعلان",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

    isLoading = false;
    notifyListeners();
  }

}