import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ourhands/widgets/app_text/AppText.dart';
import 'package:ourhands/widgets/appar/custom_app_padding.dart';
import 'package:ourhands/widgets/custom/custom_button.dart';
import 'package:ourhands/widgets/text_failed/drop_down_custom_textfailed.dart';

class AdsPage extends StatelessWidget {
  const AdsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaddingApp(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                const SizedBox(width: 50,),

                  const CustomText(
                    textColor: Colors.green,
                    text: 'اضف اعلان',
                    fontSize: 26,
                    fontWeight: FontWeight.w400,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_forward_ios_rounded)),
                ],
              ),
              SizedBox(
                height: 50.h,
              ),
              const CustomText(
                text: 'منتجاتك',
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(
                height: 10.h,
              ),
              DropDownCustomTextfailed(
                hintText: ' ',
                dropdownItems: const [
                  'اكل بيتي',
                  'شنط هاند ميد',
                  'تورت و حلويات',
                  'ميكاب ارتست',
                  'تطريز',
                ],
                onDropdownChanged: (selectedItem) {},
              ),
              SizedBox(
                height: 50.h,
              ),
              const CustomText(
                text: 'محافظة ايه؟',
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(
                height: 10.h,
              ),
              DropDownCustomTextfailed(
                hintText: ' ',
                dropdownItems: const [
                  'القاهرة',
                  'الجيزة',
                  '6 اكتوبر',
                  'الاسكندرية',
                  'القليوبية',
                ],
                onDropdownChanged: (selectedItem) {},
              ),
              SizedBox(
                height: 50.h,
              ),
              const CustomText(
                text: 'حى ايه ؟',
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(
                height: 10.h,
              ),
              DropDownCustomTextfailed(
                hintText: ' ',
                dropdownItems: const [
                  'الحى الاول',
                  'الحى الثانى',
                  'الحى الثالث',
                  'الحى الرابع',
                  'التوسعات الشمالية',
                ],
                onDropdownChanged: (selectedItem) {},
              ),
              SizedBox(height: 127.h),
              CustomButton(
                text: 'متابعه',
                onTap: () {},
                height: 45,
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
