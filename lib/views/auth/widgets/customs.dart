import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ourhands/Bindings/service_locator.dart';
import 'package:ourhands/controllers/auth_conntroller/restore_password_controller.dart';
import 'package:ourhands/utils/font_styles.dart';
import '../../../utils/colors.dart';
import '../../../utils/strings.dart';

final PasswordRecoveryController controller = getIt<PasswordRecoveryController>();

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
        SizedBox(width: 48.w), 
      ],
    ),
  );
}

Widget buildPageIndicator(int currentIndex) {
  return Directionality(
    textDirection: TextDirection.rtl,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        Color indicatorColor = index == currentIndex
            ? AppColors.actionButton 
            : AppColors.iconeye; 

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          height: 5.0,
          width: 30.0,
          decoration: BoxDecoration(
            color: indicatorColor,
            borderRadius: BorderRadius.circular(5.0),
          ),
        );
      }),
    ),
  );
}
