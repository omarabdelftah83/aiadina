import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ourhands/Bindings/service_locator.dart';
import 'package:ourhands/utils/colors.dart';
import 'package:ourhands/utils/images.dart';
import 'package:ourhands/utils/strings.dart';
import 'package:ourhands/views/auth/widgets/customs.dart';
import 'package:ourhands/widgets/custom/custom_button.dart';
import '../../../controllers/auth_conntroller/restore_password_controller.dart';
import '../../../widgets/shared/auth_custom_text_filed.dart';

class NewPasswordPage extends StatelessWidget {
  final PasswordRecoveryController controller = getIt<PasswordRecoveryController>();

   NewPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => controller.isLoading.value 
          ? Center(
              child: Lottie.asset(
                AssetImages.loading, 
                width: 100.w,
                height: 100.h,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  SizedBox(height: 50.h),
                  buildAppBar(),
          SizedBox(height: 30.h),
buildPageIndicator(controller.currentPage.value),          SizedBox(height: 30.h),
       //   Obx(() => Image.asset(AssetImages.reset2)),
       Image.asset(AssetImages.reset2),
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
                          Strings.resetPassword,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.iconeye,
                          ),
                        ),
                        SizedBox(width: 48.w),
                      ],
                    ),
                  ),
                  SizedBox(height: 40.h),
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
                    label: Strings.newPassword, 
                    height: 60.h,
                    controller: controller.passwordController,
                    textInputType: TextInputType.visiblePassword,
                    hintText: '********',
                    enabled: true,
                  ),
                  const SizedBox(height: 20),
                  AuthTextFormField(
                    label: Strings.confirmPassword,
                    height: 60.h,
                    controller: controller.confirmPasswordController,
                    textInputType: TextInputType.visiblePassword,
                    hintText: '********',
                    enabled: true,
                  ),
                  const SizedBox(height: 40),
                  CustomButton(
                    height: 60.h,
                    text: Strings.continueButton,
                    onTap: () {
                      controller.resetPassword();
                    },
                  ),
                  const SizedBox(height: 20),
                 
                  CustomButton(
                    height: 60.h,
                    text: 'Cancel',
                    onTap: () {
                      controller.handleCancelOtp(); 
                    },
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }
}
