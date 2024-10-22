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

class _PasswordRecoveryPageState extends State<PasswordRecoveryPage> {
  final PasswordRecoveryController controller = getIt<PasswordRecoveryController>();

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
                    buildEmailInputPage(),
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
