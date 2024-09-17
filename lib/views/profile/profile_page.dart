import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ourhands/views/profile/widget/edit_profile_items.dart';
import 'package:ourhands/widgets/app_text/AppText.dart';
import 'package:ourhands/widgets/appar/custom_app_padding.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaddingApp(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                    textColor: Colors.green,
                    text: 'اضف اعلان',
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 17,
                      )),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              const CircleAvatar(
                radius: 30,
              ),
              const CustomText(text: 'مريم محمد'),
              const EditProfileTextFieldAndLabel(
                customIcon: Icon(Icons.phone_android, color: Colors.green),
                // تخصيص الأيقونة هنا

                label: 'الاسم',
                keyboardType: TextInputType.name,
              ),
              SizedBox(
                height: 10.h,
              ),
              const EditProfileTextFieldAndLabel(
                customIcon: Icon(Icons.email_outlined, color: Colors.green),
                label: 'الايميل',
                keyboardType: TextInputType.name,
              ),
              // const Align(
              //     alignment: Alignment.topLeft,
              //     child: CustomText(text: 'نسيت كلمة المرور ؟',
              //       fontSize: 12,
              //       textColor: Colors.green,)),
              SizedBox(
                height: 10.h,
              ),
              const EditProfileTextFieldAndLabel(
                isPassword: true,
                obscureText: true,
                customIcon: Icon(Icons.lock_outline, color: Colors.green),
                label: ' تغيير كلمة المرور الحاليه',
                keyboardType: TextInputType.name,
              ),
              SizedBox(
                height: 10.h,
              ),
              const EditProfileTextFieldAndLabel(
                isPassword: true,
                obscureText: true,
                customIcon: Icon(Icons.lock_outline, color: Colors.green),
                label: ' تغيير كلمة المرور الجديده',
                keyboardType: TextInputType.name,
              ),
              SizedBox(
                height: 10.h,
              ),
              const Align(
                  alignment: Alignment.topRight,
                  child: CustomText(
                    text: 'تواصل معنا',
                    fontSize: 14,
                  )),
              SizedBox(
                height: 10.h,
              ),
              const Align(
                  alignment: Alignment.topRight,
                  child: CustomText(
                    text:
                        'لاى استفسارات تواصل معنا على رقم 012345678 مكالمة او واتساب',
                    fontSize: 13,
                    textColor: Colors.grey,
                    textAlign: TextAlign.center,
                  )),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const CustomText(text: 'تسجيل الخروج',textColor: Colors.red,),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.logout,color: Colors.red,)),
                ],
              ),

              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
