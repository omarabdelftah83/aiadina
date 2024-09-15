import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ourhands/views/auth/restore_password.dart';

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
           // colorScheme: ColorScheme.fromSeed(seedColor: AppColors.redtext),
            useMaterial3: true,
          ),
          home:  PasswordRecoveryPage(), 
        );
      },
    );
  }
}

