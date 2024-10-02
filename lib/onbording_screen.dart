import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ourhands/utils/colors.dart';
import 'package:ourhands/utils/images.dart';
import 'package:ourhands/utils/strings.dart';
import 'package:velocity_x/velocity_x.dart';
import 'views/auth/login_screen.dart';
import 'views/auth/register_screen.dart';
import 'widgets/custom/custom_button.dart';

class OnBording extends StatelessWidget {
  const OnBording({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double padding = 20.w;
          double buttonWidth = constraints.maxWidth * 0.4;

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: padding), 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    AssetImages.onBording,
                    width: constraints.maxWidth * 0.8,
                    height: constraints.maxHeight * 0.3,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 20.h), 
                Text(
                  Strings.appDesc,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.actionButton,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h), 
                Text(
                  Strings.appDetails,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30.h), 
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: Strings.signup,
                        height: 55.h,
                        width: buttonWidth, 
                        borderColor: AppColors.actionButton,
                        showBorder: true,
                        color: Colors.white,
                        textColor: AppColors.actionButton,
                        onTap: () {
                          Get.to(const SignUP());
                        },
                      ),
                    ),
                    SizedBox(width: 15.w), 
                    Expanded(
                      child: CustomButton(
                        height: 55.h,
                        width: buttonWidth, 
                        text: Strings.login,
                        onTap: () {
                          Get.to(LoginPage());
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
