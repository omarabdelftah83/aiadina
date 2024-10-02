import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ourhands/utils/colors.dart';
import 'Bindings/service_locator.dart';
import 'controllers/home_controller/get_search_controller.dart';
import 'helpers/cache_helper.dart';
import 'splash_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  getIt.registerLazySingleton<HomeController>(() => HomeController());
  setupDependencyInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      builder: (context, _) {
        return GetMaterialApp(
          title: 'OurHands',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            useMaterial3: false,
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.actionButton),
            fontFamily: 'Cairo',
            appBarTheme: const AppBarTheme(
              centerTitle: true,

              titleTextStyle: TextStyle(
                color: Colors.black,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ),
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
              ),
              color: Colors.white,
              elevation: 0,
            ),
          ),

          home:  SplashScreen(),
        );
      },
    );
  }
}

