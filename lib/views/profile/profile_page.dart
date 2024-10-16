import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ourhands/widgets/appar/custom_app_padding.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../Bindings/service_locator.dart';
import '../../controllers/auth_conntroller/login_screen_controller.dart';
import '../../controllers/auth_conntroller/restore_password_controller.dart';
import '../../controllers/user_single_controller/get_single_user__controller.dart';
import '../../services/get_single_user.dart';
import '../../services/password_recovery_service.dart';
import '../../utils/const.dart';
import '../../utils/font_styles.dart';
import '../../utils/images.dart';
import '../../widgets/text_failed/drop_down_custom_textfailed.dart';
import '../home/seller_page.dart';
import 'sections/logOut_section.dart';
import 'sections/password_section.dart';
import 'sections/profiles_image_section.dart';
import 'sections/user_info.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? imagePath;

  Future<String?> _getUserId() async {
    final LoginController loginController = getIt<LoginController>();
    return await loginController.getCachedUserId();
  }

  void updateImagePath(String newPath) {
    setState(() {
      imagePath = newPath;
    });
  }

  @override
  Widget build(BuildContext context) {
    final PasswordRecoveryController passwordRecoveryController = Get.put(
      PasswordRecoveryController(PasswordRecoveryService()),
    );

    return Scaffold(
      body: FutureBuilder<String?>(
        future: _getUserId(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Lottie.asset(
                AssetImages.noImage,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            );
          }

          if (snapshot.hasError || !snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(child: Text('Error: Could not fetch user ID.'));
          }

          final UserController userController = Get.put(UserController(
            userService: getIt<GetSingleUser>(),
            userId: snapshot.data!,
          ));

          return CustomPaddingApp(
            child: Obx(() {
              if (userController.isLoading.value) {
                return Center(
                  child: Lottie.asset(
                    AssetImages.noImage,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                );
              }

              if (userController.errorMessage.isNotEmpty) {
                return Center(child: Text(userController.errorMessage.value));
              }

              var userData = userController.userResponse.value.data?.user;
              List<String> jobsList = userData?.jobs?.take(15).map((job) => job.toString()).toList() ?? [];

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Directionality(
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
                          Text(
                            'الاعدادات',
                            style: FontStyles.appbartext,
                          ),
                          SizedBox(width: 48.w),
                        ],
                      ),
                    ),
                    ProfileImageSection(
                      imagePath: imagePath != null ?imagePath! : AssetImages.loading,
                      onImageChanged: (newPath) {
                        updateImagePath(newPath!);
                      },
                    
                    ),
                    TextButton(
                      onPressed: () {
                        if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                          Get.to(() => SellerPage(userID: snapshot.data!));
                        } else {
                          Get.snackbar('Error', 'Not found', snackPosition: SnackPosition.BOTTOM);
                        }
                      },
                      child: const Text('عرض الملف الشخصي'),
                    ),
                    SizedBox(height: 20.h),
                   UserInfoSection(
  nameController: TextEditingController(text: userData?.name),
  phoneController: TextEditingController(text: userData?.phone),
  emailController: TextEditingController(text: userData?.email), userId: userData!.id!,
),
                    DropDownCustomTextfailed(
                      hintText: 'المنتجات',
                      dropdownItems: jobsList,
                      onDropdownChanged: (selectedItem) {
                        if (selectedItem != null) {
                          userData?.jobs = selectedItem as List<String>?; // Adjust based on your model
                          userController.update();
                        }
                      },
                    ),
                    SizedBox(height: 10.h),
                    PasswordChangeSection(
                      userData: userData,
                    ),
                    SizedBox(height: 10.h),
                    LogOutSection(),
                    SizedBox(height: 20.h),
                  ],
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
