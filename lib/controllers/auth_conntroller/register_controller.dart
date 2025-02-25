import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ourhands/models/location_model.dart';
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
    if (value.isEmpty) return 'البريد الإلكتروني لا يمكن أن يكون فارغًا';
    if (!GetUtils.isEmail(value)) return 'يرجى إدخال بريد إلكتروني صحيح';
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) return 'كلمة المرور لا يمكن أن تكون فارغة';
    if (value.length < 6) return 'يجب أن تكون كلمة المرور 6 أحرف على الأقل';
    return null;
  }

  String? validateMobile(String value) {
    if (value.isEmpty) return 'رقم الهاتف لا يمكن أن يكون فارغًا';
    if (!GetUtils.isPhoneNumber(value)) return 'يرجى إدخال رقم هاتف صحيح';
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
      print('تم جلب المدن: ${cities}');
      print('تم جلب المناطق لكل مدينة: ${districtsMap}');
    } else {
      print('فشل في جلب المواقع');
    }
  }

  void onCitySelected(String city) {
    print('City selected: $city'); // Debugging line
    cityController.text = city;
    fetchDistrictsForCity(city);
  }

  Future<void> fetchDistrictsForCity(String city) async {
    isLoading.value = true;

    // التأكد من أن المدينة ليست فارغة قبل إرسال الطلب
    if (city.isEmpty) {
      print('Error: City cannot be empty.');
      districts.value = [];
      isLoading.value = false;
      return;
    }

    final cityRequest = CityRequest(city: city);
    final response = await locationService.fetchDistricts(cityRequest); // تأكد من أن هذه القيمة غير فارغة
    isLoading.value = false;

    if (response != null) {
      districts.value = response.map((district) => district.district).toList();
    } else {
      districts.value = [];
      print('Error: No districts found for the selected city');
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
      Get.snackbar('نجاح', 'تم التسجيل بنجاح',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
      
      Get.to(() =>const LoginPage());
    } else {
      Get.snackbar('خطأ', 'فشل في التسجيل',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    }
  }

  void handleSignUp() async {
    if (formKeyLogin.currentState?.validate() ?? false) {
      await registerUser();
    }
  }
}
