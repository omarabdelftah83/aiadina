import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Bindings/service_locator.dart';
import '../../controllers/auth_conntroller/restore_password_controller.dart';
import 'widgets/email_input.dart';
import 'widgets/new_password_pgae.dart';
import 'widgets/verification_code_page.dart';

class PasswordRecoveryPage extends StatefulWidget {
  const PasswordRecoveryPage({super.key});

  @override
  State<PasswordRecoveryPage> createState() => _PasswordRecoveryPageState();
}

class _PasswordRecoveryPageState extends State<PasswordRecoveryPage> with TickerProviderStateMixin {
  final PasswordRecoveryController controller = getIt<PasswordRecoveryController>();
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500), // Duration for the animation
    );

    _animation = Tween<double>(begin: 1.0, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void animateToPage(int pageIndex) {
    // Start the animation
    _animationController.forward().then((_) {
      controller.pageController.animateToPage(
        pageIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      _animationController.reset(); // Reset the animation controller
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetBuilder<PasswordRecoveryController>(
        init: controller,
        builder: (_) {
          return Column(
            children: [
              Expanded(
                child: PageView(
                  controller: controller.pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    controller.currentPage.value = index;
                    controller.update();
                  },
                  children: [
                    buildEmailInputPage(
                      onContinue: () {
                        animateToPage(1); 
                      },
                    ),
                    VerificationCodePage(),
                    NewPasswordPage(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
