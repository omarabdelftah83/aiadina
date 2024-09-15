import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/colors.dart';
import '../../utils/font_styles.dart';
import '../../utils/strings.dart';
import '../../widgets/custom/custom_button.dart';
import '../../widgets/shared/auth_custom_text_filed.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                    icon: Icon(Icons.arrow_back_ios_new_outlined),
                    onPressed: () {
                    },
                  ),
                  Text(
                    Strings.login,
                    style: FontStyles.appbartext
                  ),
                  SizedBox(width: 48.w), 
                ],
              ),
            ),
            SizedBox(height: 30.h),
            AuthTextFormField(
              label: Strings.phoneNumber,
              height: 60.h,
              controller: mobileController,
              textInputType: TextInputType.phone,
              hintText: '01012345678',
              enabled: true,
            ),
            SizedBox(height: 10.h),
            AuthTextFormField(
              label: Strings.password,
              controller: passwordController,
              textInputType: TextInputType.text,
              obSecureText: true,
              hintText: '***********',
              height: 60.h,
              enabled: true,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: TextButton(
                onPressed: () {
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
                // Handle login
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
                    SizedBox(width: 1.w), // Add spacing between texts
                    TextButton(
                      onPressed: () {
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
        ),
      ),
    );
  }
}
