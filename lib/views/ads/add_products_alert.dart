import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ourhands/utils/font_styles.dart';
import 'package:ourhands/widgets/custom/custom_button.dart';
import '../../utils/colors.dart';
import '../../utils/strings.dart';
import '../../widgets/app_text/AppText.dart';
import '../../widgets/shared/auth_custom_text_filed.dart';

final TextEditingController productController = TextEditingController();
final List<XFile> _images = []; // To store selected images

void addAds(BuildContext context) {
  final ImagePicker _picker = ImagePicker(); // Image picker instance

  Future<void> _pickImages() async {
    final List<XFile>? selectedImages = await _picker.pickMultiImage(); // Allow multiple images
    if (selectedImages != null) {
      _images.addAll(selectedImages);
    }
  }

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
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
              padding: EdgeInsets.all(20.w), // Add padding
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
                    AuthTextFormField(
                      label: Strings.nameProduct,
                      height: 60.h,
                      controller: productController,
                      textInputType: TextInputType.text,
                      hintText: 'كيكة فراولة',
                      enabled: true,
                    ),
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
                    // GestureDetector for adding images
                    GestureDetector(
                      onTap: _pickImages,
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
                    // Display uploaded images
                    if (_images.isNotEmpty)
                      SizedBox(
                        height: 100.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _images.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10.r),
                                    child: Image.file(
                                      File(_images[index].path),
                                      width: 80.w,
                                      height: 80.h,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        _images.removeAt(index); // Remove image
                                      },
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
                      onTap: () {
                        // Add your logic here
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
  );
}
