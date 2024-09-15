import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math'; 

import 'onbording_screen.dart';
import 'utils/images.dart'; // Replace with your images utility
import 'utils/colors.dart'; // Make sure to include your AppColors file

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  double _opacity = 0.0;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // Scale animation
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    // Rotation animation
    _rotationAnimation = Tween<double>(begin: 0, end: 7 * pi).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _controller.forward();

    _startOpacityAnimation();
  //  _checkUserStatus();
  }

  // Delayed opacity change
  void _startOpacityAnimation() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _opacity = 1.0;
      });
      Get.to(OnBording());
    });
  }

/*   Future<void> _checkUserStatus() async {
    await Future.delayed(const Duration(seconds: 3), () async {
      // Simulate token checking (replace with real CacheHelper logic)
      final token = null; // Replace with CacheHelper.getToken();

      if (token != null) {
        Get.offAll(() => const BottomNavBarWithDrawer());
      } else {
        Get.off(() => const OnboardingScreen());
      }
    });
  }
 */
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isPortrait = screenSize.height > screenSize.width;

    return Scaffold(
      backgroundColor: AppColors.actionButton, // Set the background color
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(seconds: 2),
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: RotationTransition(
              turns: _rotationAnimation,
              child: Center( // Center the animated widget
                child: SizedBox(
                  width: isPortrait
                      ? screenSize.width * 0.7
                      : screenSize.height * 0.7,
                  child: Image.asset(AssetImages.applogo),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
