import 'package:get/get.dart';
import 'package:ourhands/views/auth/register_screen.dart';
import '../views/auth/login_screen.dart';
import '../views/home/home_page.dart';

class AppPages {
  static final routes = [
    GetPage(name: '/login', page: () => LoginPage()),
    GetPage(name: '/register', page: () => const SignUP()),
    GetPage(name: '/home', page: () =>  HomePage()),
  ];
}
