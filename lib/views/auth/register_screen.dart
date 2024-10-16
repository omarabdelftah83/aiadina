import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart'; 
import '../../controllers/auth_conntroller/register_controller.dart';
import '../../services/register_service.dart';
import '../../utils/font_styles.dart';
import '../../utils/images.dart';
import '../../utils/strings.dart';
import '../../widgets/custom/custom_button.dart';
import '../../widgets/shared/auth_custom_text_filed.dart';
import '../../widgets/text_failed/drop_down_custom_textfailed.dart';

class SignUP extends StatelessWidget {
  const SignUP({super.key});

  @override
  Widget build(BuildContext context) {
    RegisterController controller = Get.put(RegisterController(AuthService()));
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return Center(
              child: Lottie.asset(
                AssetImages.loading, 
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            );
          } else {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Form(
                    key: controller.formKeyLogin,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        Row(
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
                        SizedBox(height: 20.h),
                        AuthTextFormField(
                          label: Strings.phoneNumber,
                          height: 50.h,
                          controller: controller.mobileController,
                          textInputType: TextInputType.phone,
                          hintText: '01012345678',
                          validator: (value) => controller.validateMobile(value!),
                        ),
                        AuthTextFormField(
                          label: Strings.name,
                          height: 50.h,
                          controller: controller.nameController,
                          textInputType: TextInputType.text,
                          hintText: 'Ali',
                        ),
                        AuthTextFormField(
                          label: Strings.email,
                          height: 50.h,
                          controller: controller.emailController,
                          textInputType: TextInputType.emailAddress,
                          hintText: 'ali@gmail.com',
                          validator: (value) => controller.validateEmail(value!),
                        ),
                        DropDownCustomTextfailed(
                          hintText: 'اختار المدينه',
                          dropdownItems: controller.cities,
                          dropdownValue: controller.cityController.text.isEmpty ? null : controller.cityController.text,
                          onDropdownChanged: (selectedCity) {
                            if (selectedCity != null) {
                              controller.cityController.text = selectedCity; 
                              controller.onCitySelected(selectedCity);
                            }
                          },
                        ),
                        SizedBox(height: 20.h),
                        DropDownCustomTextfailed(
                          hintText: 'اختار الحي',
                          dropdownItems: controller.districts,
                          dropdownValue: controller.districtController.text.isEmpty ? null : controller.districtController.text,
                          onDropdownChanged: (selectedDistrict) {
                            if (selectedDistrict != null) {
                              controller.districtController.text = selectedDistrict; 
                            }
                          },
                        ),
                        // Password Fields
                        AuthTextFormField(
                          label: Strings.password,
                          controller: controller.passwordController,
                          textInputType: TextInputType.text,
                          obSecureText: true,
                          hintText: '***********',
                          height: 50.h,
                          validator: (value) => controller.validatePassword(value!),
                        ),
                        AuthTextFormField(
                          label: Strings.confirmPassword,
                          controller: controller.confirmationController,
                          textInputType: TextInputType.text,
                          obSecureText: true,
                          hintText: '***********',
                          height: 50.h,
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
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
