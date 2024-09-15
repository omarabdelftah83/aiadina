import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../utils/font_styles.dart';
import '../../utils/strings.dart';
import '../../widgets/custom/custom_button.dart';
import '../../widgets/shared/auth_custom_text_filed.dart';

class SignUP extends StatelessWidget {
  const SignUP({super.key});

  @override
  Widget build(BuildContext context) {
     final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
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
                      style: FontStyles.appbartext
                    ),
                    SizedBox(width: 48.w), 
                  ],
                ),
              ),
              AuthTextFormField(
                label: Strings.phoneNumber,
                height: 60.h,
                controller: mobileController,
                textInputType: TextInputType.phone,
                hintText: '01012345678',
                enabled: true,
              ),
              AuthTextFormField(
                label: Strings.name,
                height: 60.h,
                controller: mobileController,
                textInputType: TextInputType.phone,
                hintText: 'ali',
                enabled: true,
              ),
              AuthTextFormField(
                label: Strings.email,
                height: 60.h,
                controller: mobileController,
                textInputType: TextInputType.phone,
                hintText: 'ali@gmail.com',
                enabled: true,
              ),
              AuthTextFormField(
                label: Strings.password,
                controller: passwordController,
                textInputType: TextInputType.text,
                obSecureText: true,
                hintText: '***********',
                height: 60.h,
                enabled: true,
              ),
           
              AuthTextFormField(
                label: Strings.confirmPassword,
                controller: passwordController,
                textInputType: TextInputType.text,
                obSecureText: true,
                hintText: '***********',
                height: 60.h,
                enabled: true,
              ),
              SizedBox(height: 30.h),
              CustomButton(
                height: 60.h,
                text: Strings.signup,
                onTap: () {
                  // Handle login
                },
              ),
           
            ],
          ),
        ),
      ),
    );
  }
}