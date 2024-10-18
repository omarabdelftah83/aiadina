import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ourhands/utils/images.dart';
import 'package:ourhands/views/home/home_page.dart';
import 'helpers/cache_helper.dart';
import 'onbording_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
   void initState() {
    super.initState();
    _checkUserStatus();
  }
     Future<void> _checkUserStatus() async {
    await Future.delayed(const Duration(seconds: 1), () {
      

      Future.delayed(const Duration(seconds: 1), () async {
        final token = CacheHelper.getToken();
        if (token != null) {
          Get.offAll(() =>  HomePage());
        } else {
          Get.off(() => const OnBording());
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          height: 80,
          width: 80,
          child: Image.asset(
            AssetImages.iconApp,
            width: MediaQuery.of(context).size.width,  
            height: MediaQuery.of(context).size.height, 
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
