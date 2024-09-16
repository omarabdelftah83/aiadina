import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ourhands/views/home/search_result_page.dart';
import 'package:ourhands/widgets/app_text/AppText.dart';
import 'package:ourhands/widgets/appar/custom_app_padding.dart';
import 'package:ourhands/widgets/custom/custom_button.dart';
import 'package:ourhands/widgets/text_failed/drop_down_custom_textfailed.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaddingApp(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  const Row(
                    children: [
                      CustomText(
                        textColor: Colors.green,
                        text: 'اضف اعلان',
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const CustomText(
                        text: 'اهلا مريم',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      const CircleAvatar(),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 50.h,
              ),
              const CustomText(
                text: 'بتدور على ايه؟',
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
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchResultPage()));
                },
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
