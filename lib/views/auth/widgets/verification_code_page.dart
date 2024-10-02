import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ourhands/utils/colors.dart';
import 'package:ourhands/utils/font_styles.dart';
import 'package:ourhands/utils/strings.dart';
import 'package:ourhands/views/auth/widgets/customs.dart';
import '../../../Bindings/service_locator.dart';
import '../../../controllers/auth_conntroller/restore_password_controller.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/images.dart';
import '../../../widgets/custom/custom_button.dart';
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
buildPageIndicator(controller.currentPage.value),
          SizedBox(height: 30.h),
       //   Obx(() => Image.asset(AssetImages.reset2)),
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
                print("OTP entered: $code");
                controller.otpController.text = code; 
              },
            ),
            const SizedBox(height: 40),
            Obx(() {
                return Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: controller.isResendEnabled.value ? () {
                      controller.resendOtp();
                    } : null,
                    child: Text(
                      controller.isResendEnabled.value ? Strings.resend : 'Resend in ${controller.countdownTimer.value}s',
                      style: TextStyle(
                        fontSize: 14.sp,
                      decoration: TextDecoration.underline,
                        color: controller.isResendEnabled.value ? AppColors.actionButton : Colors.grey,
                      ),
                    ),
                  ),
                );
              }),
            Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              child: Obx(() {
                return CustomButton(
                  height: 60.h,
                  text: controller.isLoading.value ? 'Verifying...' : Strings.verify,
                  onTap: controller.isLoading.value
                      ? () {} 
                      : () {
                          controller.verifyOtp(); 
                        },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
