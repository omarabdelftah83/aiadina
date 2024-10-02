import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ourhands/widgets/app_text/AppText.dart';
import 'package:ourhands/widgets/appar/custom_app_padding.dart';
import 'package:ourhands/widgets/custom/custom_button.dart';

import '../ads/add_products_alert.dart';

class PageLoading extends StatelessWidget {
  const PageLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaddingApp(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Image.asset('assets/images/illustration.png')),
              SizedBox(
                height: 50.h,
              ),
              InkWell(
                  onTap: () {
                    showCommentDialog(context);
                  },
                  child: const CustomText(
                    text: 'تطبيق ايادينا اول خطوة للنجاح',
                    textColor: Colors.green,
                    fontSize: 24,
                  )),
            ],
          )),
    );
  }

  void showCommentDialog(BuildContext context) {
    final TextEditingController commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: const BorderSide(color: Colors.grey, width: 0.5),
          ),
          content: SizedBox(
            height: 280,
            width: 340,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const CustomText(
                      text: 'ارشادات اضافة الاعلان',
                      textColor: Colors.green,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      width: 30.w,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_forward_ios_rounded),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,

                  children: [
                    const Expanded(
                      child: Align(
                        alignment: Alignment.topRight,

                        child: CustomText(
                          text: 'إضافة صور الإعلان الخاصة بالشغل على الطبيعة',fontSize: 14,),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Image.asset('assets/images/icon.png'),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,

                  children: [
                    const Expanded(
                      child: Align(
                        alignment: Alignment.topRight,

                        child: CustomText(
                          text: 'الاهتمام بجودة الصورة',fontSize: 14,),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Image.asset('assets/images/icon.png'),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,

                  children: [
                    const Expanded(
                      child: Align(
                        alignment: Alignment.topRight,

                        child: CustomText(
                          text: 'الاهتمام بالتغليف والباكدجينج',fontSize: 14,),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Image.asset('assets/images/icon.png'),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Expanded(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: CustomText(
                          text: 'الاهتمام بموعد التسليم',fontSize: 14,),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Image.asset('assets/images/icon.png'),
                    )
                  ],
                ),
                const Align(
                  alignment: Alignment.topRight,
                  child: CustomText(
                    text: 'لكسب مزيد من العملاء و رفع التقييم',fontSize: 14,textColor: Colors.green,),
                ),
                const SizedBox(height: 20,),
                CustomButton(text: 'اضف اعلان', onTap: (){
              Get.back();
                 addAds(context);
                },width: 310,height: 50,)
              ],
            ),
          ),
        );
      },
    );
  }
}