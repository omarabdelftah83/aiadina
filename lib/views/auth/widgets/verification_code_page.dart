import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ourhands/utils/colors.dart';
import 'package:ourhands/utils/font_styles.dart';
import 'package:ourhands/utils/strings.dart';
import '../../../Bindings/service_locator.dart';
import '../../../controllers/auth_conntroller/restore_password_controller.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/images.dart';
import '../../../widgets/custom/custom_button.dart';
import 'customs.dart';
import 'new_password_pgae.dart';

class VerificationCodePage extends StatelessWidget {
  final PasswordRecoveryController controller = getIt<PasswordRecoveryController>();

  VerificationCodePage({super.key});

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50.h),
            buildAppBar(),
            SizedBox(height: 30.h),
            GetBuilder<PasswordRecoveryController>(
              init: controller,
              builder: (_) => buildPageIndicator(controller.currentPage.value),
            ),
            SizedBox(height: 30.h),
            Image.asset(AssetImages.otp),
            SizedBox(height: 50.h),
            Center(
              child: Text(
                Strings.enterVerificationCode,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.w400,
                  color: AppColors.iconeye,
                ),
              ),
            ),
            OtpTextField(
              numberOfFields: 4,
              borderColor: AppColors.actionButton,
              fillColor: Colors.white,
              focusedBorderColor: AppColors.actionButton,
              cursorColor: AppColors.actionButton,
              textStyle: TextStyle(color: AppColors.actionButton),
              onSubmit: (String code) {
                controller.otpController.text = code;
              },
            ),
            const SizedBox(height: 40),
            GetBuilder<PasswordRecoveryController>(
              init: controller,
              builder: (_) {
                return Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: controller.isResendEnabled.value
                        ? () {
                            controller.resendOtp();
                          }
                        : null,
                    child: Text(
                      controller.isResendEnabled.value
                          ? Strings.resend
                          : 'إعادة الإرسال خلال ${controller.countdownTimer.value} ثانية',
                      style: TextStyle(
                        fontSize: 14.sp,
                        decoration: TextDecoration.underline,
                        color: controller.isResendEnabled.value
                            ? AppColors.actionButton
                            : Colors.grey,
                      ),
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              child: GetBuilder<PasswordRecoveryController>(
                init: controller,
                builder: (_) {
                  if (controller.isLoading.value) {
                    return Center(
                      child: Lottie.asset(
                        AssetImages.loading, // Lottie loading animation asset path
                        width: 100.w,
                        height: 100.h,
                      ),
                    );
                  } else {
                    return CustomButton(
                      height: 60.h,
                      text: Strings.verify,
                      onTap: () async {
                        await controller.verifyOtp();
                        if (controller.isRecovering) {
                          Get.to(() => NewPasswordPage(), transition: Transition.leftToRight, duration: const Duration(milliseconds: 500));
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
