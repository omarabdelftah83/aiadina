import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ourhands/utils/font_styles.dart';
import '../../../services/update_data_user.dart';
import '../../../utils/colors.dart';
import '../../../widgets/custom/custom_button.dart';

class UserInfoSection extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final String userId;

  UserInfoSection({
    Key? key,
    required this.nameController,
    required this.phoneController,
    required this.emailController,
    required this.userId,
  }) : super(key: key);

  // Initialize the controller
  final UserInfoController _userInfoController = Get.put(UserInfoController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'معلومات المستخدم',
            style: FontStyles.font16Weight400Text,
          ),
          SizedBox(height: 16.h),
          _buildTextField('الاسم', nameController),
          SizedBox(height: 16.h),
          _buildTextField('رقم الهاتف', phoneController),
          SizedBox(height: 16.h),
          _buildTextField('البريد الإلكتروني', emailController),
          SizedBox(height: 20.h), // Added spacing before the button
          _buildUpdateButton(context),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: const Color(0xff0E30A8)),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      ),
    );
  }

  Widget _buildUpdateButton(BuildContext context) {
    return Obx(() {
      return CustomButton(
        text: 'تحديث',
        onTap: () async {
          final userService = UserService();
          final name = nameController.text.isNotEmpty ? nameController.text : null;
          final phone = phoneController.text.isNotEmpty ? phoneController.text : null;
          final email = emailController.text.isNotEmpty ? emailController.text : null;

          // Start loading state
          _userInfoController.setLoading(true);

          // Call the update function
          final success = await userService.updateUser(
            userId: userId,
            name: name,
            phone: phone,
            email: email,
          );

          // SnackBar messages based on the update success
          String message = success 
              ? 'تم تحديث المعلومات بنجاح' 
              : 'فشل تحديث المعلومات';
          _showSnackBar(context, message);

          // Stop loading state
          _userInfoController.setLoading(false);
        },
        height: 50.h, // Set button height
        isLoading: _userInfoController.isLoading.value, // React to loading state
        color: AppColors.actionButton, // Optional custom color
        textStyle: FontStyles.font16Weight400Text.copyWith(color: Colors.white), // Set text style
      );
    });
  }

  // Method to show a SnackBar with the given message
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }
}


class UserInfoController extends GetxController {
  var isLoading = false.obs;

  // Method to update loading state
  void setLoading(bool value) {
    isLoading.value = value;
  }
}