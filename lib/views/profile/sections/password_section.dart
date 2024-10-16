import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../controllers/auth_conntroller/restore_password_controller.dart';
import '../../../models/get_single_user.dart';
import '../../../widgets/app_text/AppText.dart';
import '../../../widgets/custom/custom_button.dart';
import '../../../widgets/shared/auth_custom_text_filed.dart';
import '../../../widgets/shared/snack_bar.dart';

class PasswordChangeSection extends StatelessWidget {
  final User? userData;

  const PasswordChangeSection({
    super.key,
    this.userData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const CustomText(
          text: 'تغيير كلمة المرور',
          fontSize: 14,
        ),
        SizedBox(height: 10.h),
        CustomButton(
          height: 60.h,
          text: 'تغيير كلمة المرور',
          onTap: () {
            _showPasswordChangeDialog(context);
          },
        ),
      ],
    );
  }

  void _showPasswordChangeDialog(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final PasswordRecoveryController passwordRecoveryController = Get.find<PasswordRecoveryController>();

    showDialog(
      context: context,
      builder: (context) {
        return ScaleTransition(
          scale: Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: ModalRoute.of(context)!.animation!,
              curve: Curves.fastOutSlowIn,
              
            ),
          ),
          child: AlertDialog(
            title: const Text('تغيير كلمة المرور'),
            content: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AuthTextFormField(
                      label: 'كلمة المرور الجديدة',
                      height: 60.h,
                      controller: passwordRecoveryController.passwordControllerProfile,
                      textInputType: TextInputType.visiblePassword,
                      hintText: '********',
                      enabled: true,
                      obSecureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال كلمة المرور';
                        } else if (value.length < 6) {
                          return 'يجب أن تكون كلمة المرور 6 أحرف على الأقل';
                        }
                        return null;
                      },
                    ).animate().slideX(delay: 200.ms), // Slide in animation
                    SizedBox(height: 10.h),
                    AuthTextFormField(
                      label: 'تأكيد كلمة المرور',
                      height: 60.h,
                      controller: passwordRecoveryController.confirmPasswordControllerProfile,
                      textInputType: TextInputType.visiblePassword,
                      hintText: '********',
                      enabled: true,
                      obSecureText: true,
                      validator: (value) {
                        if (value != passwordRecoveryController.passwordControllerProfile.text) {
                          return 'كلمة المرور غير متطابقة';
                        }
                        return null;
                      },
                    ).animate().slideX(delay: 400.ms), // Slide in with delay
                  ],
                ),
              ),
            ),
            actions: [
             /*  TextButton(
                onPressed: () {
                  Get.back(); // Close the dialog
                },
                child: const Text('إلغاء'),
              ).animate().fade(delay: 500.ms),  */// Fade-in animation for cancel button
              CustomButton(
                height: 60.h,
                text: 'تغيير كلمة المرور',
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    try {
                      // Call the reset password service
                      await passwordRecoveryController.resetPasswordSettings(userData!.email);

                      // Show success message
                      showSnackbar('نجاح', 'تم تغيير كلمة المرور بنجاح', isSuccess: true);
                      Get.back(); // Close the dialog after success
                    } catch (error) {
                      // Handle any errors during the service call
                      showSnackbar('خطأ', 'حدث خطأ أثناء تغيير كلمة المرور. يرجى المحاولة لاحقاً', isSuccess: false);
                    }
                  } else {
                    // If form validation fails
                    showSnackbar('خطأ', 'يرجى التأكد من صحة كلمة المرور', isSuccess: false);
                  }
                },
              ).animate().scale(delay: 600.ms), // Scale animation for submit button
            ],
          ),
        );
      },
    );
  }
}
