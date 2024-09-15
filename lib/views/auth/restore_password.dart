import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ourhands/utils/colors.dart';
import '../../controllers/auth/restore_password_controller.dart';
import '../../utils/font_styles.dart';
import '../../utils/images.dart';
import '../../utils/strings.dart';
import '../../widgets/custom/custom_button.dart';
import '../../widgets/shared/auth_custom_text_filed.dart';

class PasswordRecoveryPage extends StatefulWidget {
  @override
  State<PasswordRecoveryPage> createState() => _PasswordRecoveryPageState();
}

class _PasswordRecoveryPageState extends State<PasswordRecoveryPage> {
  final PasswordRecoveryController controller = Get.put(PasswordRecoveryController());
  final TextEditingController mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 30.h),
          buildAppBar(),
          SizedBox(height: 30.h),
          buildPageIndicator(),
          SizedBox(height: 30.h),
          Obx(() => Image.asset(controller.currentPage.value == 0
              ? AssetImages.lock
              : AssetImages.reset2)), // Change image dynamically
          Expanded(
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: PageView(
                controller: controller.pageController,
                physics: const NeverScrollableScrollPhysics(), // No manual scroll
                onPageChanged: (index) {
                  controller.currentPage.value = index;
                },
                children: [
                  buildPhoneInputPage(),
                  buildVerificationCodePage(),
                  buildNewPasswordPage(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build app bar with back button
  Widget buildAppBar() {
    return Directionality(
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
          Text(Strings.resetPassword, style: FontStyles.appbartext),
          SizedBox(width: 48.w), // Placeholder for centering title
        ],
      ),
    );
  }

  // Page Indicator
  Widget buildPageIndicator() {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            height: 5.0,
            width: 30.0,
            decoration: BoxDecoration(
              color: controller.currentPage.value == index ? AppColors.actionButton : AppColors.iconeye,
              borderRadius: BorderRadius.circular(5.0),
            ),
          );
        }),
      );
    });
  }

  // First Page: Enter Phone Number
  Widget buildPhoneInputPage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text(
              Strings.enterPhoneNumber,
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Cairo",
                fontWeight: FontWeight.w400,
                color: AppColors.iconeye,
              ),
            ),
          ),
          const SizedBox(height: 20),
          AuthTextFormField(
            label: Strings.phoneNumber,
            height: 60.h,
            controller: mobileController,
            textInputType: TextInputType.phone,
            hintText: '01012345678',
            enabled: true,
          ),
          const SizedBox(height: 40),
          CustomButton(
            height: 60.h,
            text: Strings.continueButton,
            onTap: () {
              // Navigate to the next page
              controller.nextPage();
            },
          ),
        ],
      ),
    );
  }

  // Second Page: Enter Verification Code
  Widget buildVerificationCodePage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
            OtpTextField(
                mainAxisAlignment: MainAxisAlignment.center,
                numberOfFields: 6,
                fillColor: Colors.black.withOpacity(0.1),
                filled: true,
                onSubmit: (code) => print("OTP is => $code")),
          const SizedBox(height: 40),
          CustomButton(
            height: 60.h,
            text: Strings.continueButton,
            onTap: () {
              controller.nextPage(); // Call controller to go to the next page
            },
          ),
        ],
      ),
    );
  }

  // Third Page: Enter New Password
  Widget buildNewPasswordPage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text(
              Strings.password,
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Cairo",
                fontWeight: FontWeight.w400,
                color: AppColors.iconeye,
              ),
            ),
          ),
          const SizedBox(height: 20),
          AuthTextFormField(
            label: Strings.resetPassword,
            height: 60.h,
            controller: TextEditingController(),
            textInputType: TextInputType.visiblePassword,
            hintText: '********',
            enabled: true,
          ),
          const SizedBox(height: 40),
          CustomButton(
            height: 60.h,
            text: Strings.continueButton,
            onTap: () {
              controller.nextPage(); // Call controller to go to the next page
            },
          ),
        ],
      ),
    );
  }
}
