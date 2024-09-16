import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ourhands/views/auth/restore_password.dart';
import 'package:ourhands/views/home/home_page.dart';
import 'splash_screen.dart';

void main() {
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
          title: 'HARLEY',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            useMaterial3: false,
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
                statusBarColor: Colors.transparent,
              ),
              color: Colors.white,
              elevation: 0,
            ),
          ),

          home:  HomePage(),
        );
      },
    );
  }
}

