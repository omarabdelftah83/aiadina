import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ourhands/models/user_model_register.dart';
import 'package:ourhands/views/home/home_page.dart';
import '../../services/get_all_locations.dart';
import '../../services/register_service.dart';
import '../../views/auth/login_screen.dart';

class RegisterController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController confirmationController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  
  final GetAllLocationsService locationService = GetAllLocationsService();
  final RxList<String> cities = <String>[].obs;
  final RxMap<String, List<String>> districtsMap = <String, List<String>>{}.obs;
  final RxList<String> districts = <String>[].obs;
  
  final formKeyLogin = GlobalKey<FormState>();
  final RxBool isLoading = false.obs;
  
  final AuthService _authService;
  RegisterController(this._authService);
  
  @override
  void onInit() {
    super.onInit();
    fetchLocations(); 
  }

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
  
  Future<void> fetchLocations() async {
    isLoading.value = true;
    final response = await locationService.fetchLocationss();
    isLoading.value = false; 
    if (response != null && response.status == 'SUCCESS') {
      cities.value = response.data.cities.toSet().toList();
      for (var city in cities) {
        districtsMap[city] = response.data.districts.toSet().toList();
      }
      print('Cities fetched: ${cities}');
      print('Districts fetched for each city: ${districtsMap}');
    } else {
      print('فشل في جلب المواقع');
    }
  }

  void onCitySelected(String city) {
    cityController.text = city; 
    updateDistrictsForCity(city);
  }

  void updateDistrictsForCity(String city) {
    if (districtsMap[city] != null) {
      districts.value = districtsMap[city]!; 
    } else {
      districts.value = [];
    }
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
      
      Get.to(() =>const LoginPage());
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
