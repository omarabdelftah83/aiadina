import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ourhands/Bindings/service_locator.dart';
import 'package:ourhands/utils/images.dart';
import '../../controllers/auth_conntroller/register_controller.dart';
import '../../utils/font_styles.dart';
import '../../utils/strings.dart';
import '../../widgets/custom/custom_button.dart';
import '../../widgets/shared/auth_custom_text_filed.dart';

class SignUP extends StatelessWidget {
  const SignUP({super.key});

  @override
  Widget build(BuildContext context) {
    final RegisterController controller = getIt<RegisterController>();
    return Scaffold(
      resizeToAvoidBottomInset: true, 
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Form(
              key: controller.formKeyLogin,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
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
                          Strings.signup,
                          style: FontStyles.appbartext,
                        ),
                        SizedBox(width: 48.w),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h), // Added spacing

                  Obx(() {
                    if (controller.isLoading.value) {
                      return Center(
                        child: Lottie.asset(
                          AssetImages.loading,
                          width: 100.w,
                          height: 100.h,
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          AuthTextFormField(
                            label: Strings.phoneNumber,
                            height: 50.h,
                            controller: controller.mobileController,
                            textInputType: TextInputType.phone,
                            hintText: '01012345678',
                            enabled: !controller.isLoading.value, // Disable during loading
                            validator: (value) => controller.validateMobile(value!),
                          ),
                          AuthTextFormField(
                            label: Strings.name,
                            height: 50.h,
                            controller: controller.nameController,
                            textInputType: TextInputType.text,
                            hintText: 'Ali',
                            enabled: !controller.isLoading.value, // Disable during loading
                          ),
                          AuthTextFormField(
                            label: Strings.email,
                            height: 50.h,
                            controller: controller.emailController,
                            textInputType: TextInputType.emailAddress,
                            hintText: 'ali@gmail.com',
                            enabled: !controller.isLoading.value, // Disable during loading
                            validator: (value) => controller.validateEmail(value!),
                          ),
                          AuthTextFormField(
                            label: Strings.location,
                            height: 50.h,
                            controller: controller.cityController,
                            textInputType: TextInputType.text,
                            hintText: 'Your City',
                            enabled: !controller.isLoading.value, // Disable during loading
                          ),
                          AuthTextFormField(
                            label: Strings.location,
                            height: 50.h,
                            controller: controller.locationController,
                            textInputType: TextInputType.text,
                            hintText: 'Your Location',
                            enabled: !controller.isLoading.value, // Disable during loading
                          ),
                          AuthTextFormField(
                            label: Strings.password,
                            controller: controller.passwordController,
                            textInputType: TextInputType.text,
                            obSecureText: true,
                            hintText: '***********',
                            height: 50.h,
                            enabled: !controller.isLoading.value, // Disable during loading
                            validator: (value) => controller.validatePassword(value!),
                          ),
                          AuthTextFormField(
                            label: Strings.confirmPassword,
                            controller: controller.confirmationController,
                            textInputType: TextInputType.text,
                            obSecureText: true,
                            hintText: '***********',
                            height: 50.h,
                            enabled: !controller.isLoading.value,
                            validator: (value) => controller.validatePassword(value!),
                          ),
                          SizedBox(height: 20.h), 
                          CustomButton(
                        height: 60.h,
                        text: Strings.signup,
                        onTap: controller.isLoading.value ? () {} : controller.handleSignUp, 
                      ),
                          SizedBox(height: 20.h), 
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
