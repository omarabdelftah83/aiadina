import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ourhands/Bindings/service_locator.dart';
import 'package:ourhands/controllers/auth_conntroller/restore_password_controller.dart';
import 'package:ourhands/utils/colors.dart';
import 'package:ourhands/utils/strings.dart';
import 'package:ourhands/views/auth/widgets/customs.dart';
import 'package:ourhands/widgets/custom/custom_button.dart';
import '../../../utils/images.dart';
import '../../../widgets/shared/auth_custom_text_filed.dart';
import 'package:lottie/lottie.dart';

Widget buildEmailInputPage() {
  final PasswordRecoveryController controller = getIt<PasswordRecoveryController>();

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 50.h),
          buildAppBar(),
          SizedBox(height: 30.h),
          GetBuilder<PasswordRecoveryController>(
            builder: (_) {
              return buildPageIndicator(controller.currentPage.value);
            },
          ),
          SizedBox(height: 30.h),
          Image.asset(AssetImages.reset2),
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
          GetBuilder<PasswordRecoveryController>(
            builder: (_) {
              return AuthTextFormField(
                label: Strings.email,
                height: 60.h,
                controller: controller.emailController,
                textInputType: TextInputType.emailAddress,
                hintText: 'ayadina@gmail.com',
                enabled: !controller.isLoading.value,
              );
            },
          ),
          const SizedBox(height: 40),
          GetBuilder<PasswordRecoveryController>(
            builder: (_) {
              if (controller.isLoading.value) {
                return Center(
                  child: Lottie.asset(
                    AssetImages.loading,
                    width: 100.w,
                    height: 100.h,
                  ),
                );
              } else {
                return CustomButton(
                  height: 60.h,
                  text: Strings.continueButton,
                  onTap: () async {
                    await controller.sendRecoveryEmail();
                  },
                );
              }
            },
          ),
        ],
      ),
    ),
  );
}
