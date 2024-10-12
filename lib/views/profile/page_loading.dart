import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ourhands/widgets/app_text/AppText.dart';
import 'package:ourhands/widgets/appar/custom_app_padding.dart';
import 'package:ourhands/widgets/custom/custom_button.dart';
import '../../utils/images.dart';
import '../ads/add_products_alert.dart';

class PageLoading extends StatefulWidget {
  const PageLoading({super.key});

  @override
  _PageLoadingState createState() => _PageLoadingState();
}

class _PageLoadingState extends State<PageLoading> {
  bool _showContent = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _showContent = true; 
      });
      showCommentDialog(context); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaddingApp(
        child: _showContent 
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/illustration.png',
                      width: 200.w, 
                      height: 200.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 50.h), 
                  const CustomText(
                    text: 'تطبيق ايادينا اول خطوة للنجاح',
                    textColor: Colors.green,
                    fontSize: 24, 
                  ),
                ],
              )
            : Center(
                child: Lottie.asset(
                  AssetImages.loading,
                  width: 60.w,
                  height: 60.h, 
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }

  void showCommentDialog(BuildContext context) {
    final TextEditingController commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.r), // Responsive border radius
            side: const BorderSide(color: Colors.grey, width: 0.5),
          ),
          content: SizedBox(
            width: 340.w, // Set responsive width
            child: Column(
              mainAxisSize: MainAxisSize.min, // Use minimum size for dialog
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
                    SizedBox(width: 30.w),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_forward_ios_rounded),
                    ),
                  ],
                ),
                _buildDialogRow('إضافة صور الإعلان الخاصة بالشغل على الطبيعة'),
                _buildDialogRow('الاهتمام بجودة الصورة'),
                _buildDialogRow('الاهتمام بالتغليف والباكدجينج'),
                _buildDialogRow('الاهتمام بموعد التسليم'),
                const Align(
                  alignment: Alignment.topRight,
                  child: CustomText(
                    text: 'لكسب مزيد من العملاء و رفع التقييم',
                    fontSize: 14,
                    textColor: Colors.green,
                  ),
                ),
                SizedBox(height: 20.h),
                CustomButton(
                  text: 'اضف اعلان',
                  onTap: () {
                    Get.back();
                    addAds(context);
                  },
                  width: 310.w, 
                  height: 50.h, 
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDialogRow(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.topRight,
            child: CustomText(
              text: text,
              fontSize: 14,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Image.asset(
            'assets/images/icon.png',
            width: 20.w,
            height: 20.h,
          ),
        ),
      ],
    );
  }
}
