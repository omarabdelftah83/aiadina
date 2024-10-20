import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ourhands/services/ad_service.dart';
import 'package:provider/provider.dart';
import '../../Bindings/service_locator.dart';
import '../../controllers/auth_conntroller/login_screen_controller.dart';
import '../../controllers/category/get_all_category_controller.dart';
import '../../utils/colors.dart';
import '../../utils/font_styles.dart';
import '../../utils/images.dart';
import '../../utils/strings.dart';
import '../../widgets/app_text/AppText.dart';
import '../../widgets/shared/auth_custom_text_filed.dart';
import '../../widgets/text_failed/drop_down_custom_textfailed.dart';
import '../../widgets/custom/custom_button.dart';
import '../home/seller_page.dart';

class ImageDisplayPage extends StatelessWidget {
  final String imagePath;

  ImageDisplayPage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Container(
          height: 400,
          width: 300,
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

void addAds(BuildContext context) {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  String? imagePath; // متغير لتخزين مسار الصورة

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return ChangeNotifierProvider(
        create: (context) => AddAdsController(),
        child: Consumer<AddAdsController>(
          builder: (context, controller, child) {
            final LoginController controllerForID = getIt<LoginController>();

            return LayoutBuilder(
              builder: (context, constraints) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                  backgroundColor: Colors.white,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.w),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
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
                              SizedBox(width: 20.w),
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: const Icon(Icons.arrow_forward_ios_rounded),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          controller.isLoading
                              ? Center(
                            child: Lottie.asset(
                              AssetImages.loading,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          )
                              : DropDownCustomTextfailed(
                            hintText: 'اختر القسم',
                            dropdownItems: controller.dropdownItems,
                            onDropdownChanged: (selectedItem) {
                              controller.selectedJob.value = selectedItem;
                            },
                          ),
                          const SizedBox(height: 20),

                          AuthTextFormField(
                            label: Strings.nameProduct,
                            height: 60.h,
                            controller: titleController,
                            textInputType: TextInputType.text,
                            hintText: 'كيكة فراولة',
                            enabled: true,
                          ),
                          const SizedBox(height: 20),
                          AuthTextFormField(
                            label: '',
                            height: 60.h,
                            controller: descriptionController,
                            textInputType: TextInputType.text,
                            hintText: 'وصف المنتج',
                            enabled: true,
                          ),

                          // Add product photo
                          const SizedBox(height: 20),
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              Strings.addproductPhoto,
                              style: FontStyles.font14Weight400RightAligned.copyWith(
                                color: AppColors.textColor,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: controller.pickImages,
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              shadowColor: Colors.grey.withOpacity(0.5),
                              child: SizedBox(
                                height: 90.h,
                                width: 86.h,
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    color: AppColors.textColor,
                                    size: 24.w,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Display selected images
                          if (controller.images.isNotEmpty)
                            SizedBox(
                              height: 100.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.images.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(10.r),
                                          child: Image.file(
                                            File(controller.images[index].path),
                                            width: 80.w,
                                            height: 80.h,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: GestureDetector(
                                            onTap: () => controller.removeImage(index),
                                            child: Icon(
                                              Icons.cancel,
                                              color: Colors.red,
                                              size: 24.w,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          const SizedBox(height: 10),

                          // Additional note
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              'ملحوظة: يجب ان تضاف صور الاعلان الخاصة بشغلك على الطبيعة',
                              style: FontStyles.font14Weight400RightAligned.copyWith(
                                color: AppColors.textColor,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          const SizedBox(height: 20),
                          CustomButton(
                            text: 'اضف اعلان',
                            onTap: () async {
                              String title = titleController.text.trim();
                              String description = descriptionController.text.trim();
                              String? userId = await controllerForID.getCachedUserId();

                              if (title.isEmpty) {
                                Get.snackbar(
                                  "خطأ",
                                  "يرجى إدخال عنوان الإعلان",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                );
                                return;
                              }

                              if (description.length < 10) {
                                Get.snackbar(
                                  "خطأ",
                                  "يجب أن يكون الوصف على الأقل 10 أحرف.",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red.shade400,
                                  colorText: Colors.white,
                                );
                                return;
                              }

                              if (controller.selectedJob.value == null) {
                                Get.snackbar(
                                  "خطأ",
                                  "يرجى اختيار وظيفة.",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red.shade400,
                                  colorText: Colors.white,
                                );
                                return;
                              }

                              if (controller.images.isEmpty) {
                                Get.snackbar(
                                  "خطأ",
                                  "يرجى إضافة صورة للإعلان.",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red.shade400,
                                  colorText: Colors.white,
                                );
                                return;
                              }

                              // إضافة الإعلان
                              await controller.createAd(title, description, controller.selectedJob.value!);

                              // عرض الصورة في صفحة جديدة
                              imagePath = 'assets/images/framee.png'; // تخزين مسار الصورة الأولى

                              // الانتقال إلى صفحة عرض الصورة
                              Get.off(() => ImageDisplayPage(imagePath: imagePath!));

                              // إغلاق Dialog بعد ثانيتين
                              await Future.delayed(Duration(seconds: 2));


                              Get.offAll(() => SellerPage(userID: userId!));

                              // إغلاق Dialog
                              Navigator.of(context).pop();
                            },
                            width: 310.w,
                            height: 50.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      );
    },
  );
}
