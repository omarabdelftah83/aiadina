import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart'; 
import 'package:ourhands/Bindings/service_locator.dart';
import 'package:ourhands/utils/images.dart';
import '../../controllers/auth_conntroller/login_screen_controller.dart';
import '../../utils/colors.dart';
import '../../utils/font_styles.dart';
import '../../utils/strings.dart';
import '../../widgets/custom/custom_button.dart';
import '../../widgets/shared/auth_custom_text_filed.dart';
import 'register_screen.dart';
import 'restore_password_recovery.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
  final LoginController controller = getIt<LoginController>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SafeArea(
          child: SingleChildScrollView( 
            child: Form(
              key: controller.formKeyLogin,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40.h),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new_outlined),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                        Text(
                          Strings.login,
                          style: FontStyles.appbartext,
                        ),
                        SizedBox(width: 48.w),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),

                  Obx(() {
                    if (controller.isLoading.value) {
                      return Center(
                        child: Lottie.asset(AssetImages.loading, width: 100.w, height: 100.h),
                      );
                    } else {
                      return Column(
                        children: [
                          AuthTextFormField(
                            label: Strings.email,
                            height: 60.h,
                            controller: controller.emailController,
                            textInputType: TextInputType.emailAddress,
                            hintText: 'alli@example.com',
                            validator: controller.validateEmail,
                            enabled: true,
                          ),
                          SizedBox(height: 10.h),
                          AuthTextFormField(
                            label: Strings.password,
                            controller: controller.passwordController,
                            textInputType: TextInputType.text,
                            obSecureText: true,
                            hintText: '***********',
                            height: 60.h,
                            validator: controller.validatePassword,
                            enabled: true,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: TextButton(
                              onPressed: () {
                                Get.to(const PasswordRecoveryPage());
                              },
                              child: Text(
                                Strings.forgotPassword,
                                style: FontStyles.font16Weight400Text.copyWith(
                                  color: AppColors.iconeye,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30.h),
                          CustomButton(
                            height: 60.h,
                            text: Strings.login,
                            onTap: () {
                              if (controller.formKeyLogin.currentState!.validate()) {
                                controller.loginUser();
                              }
                            },
                          ),
                          SizedBox(height: 20.h),
                          Center(
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'ليس لديك حساب ؟',
                                    style: FontStyles.font16Weight400Text.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(width: 1.w),
                                  TextButton(
                                    onPressed: () {
                                      Get.offAll(const SignUP());
                                    },
                                    child: Text(
                                      'انشئ حساب الان',
                                      style: FontStyles.font16Weight400Text.copyWith(
                                        color: AppColors.actionButton,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 30.h),
                        ],
                      );
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
