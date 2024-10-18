import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ourhands/utils/const.dart';
import 'package:ourhands/widgets/appar/custom_app_padding.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../Bindings/service_locator.dart';
import '../../controllers/auth_conntroller/login_screen_controller.dart';
import '../../controllers/auth_conntroller/restore_password_controller.dart';
import '../../controllers/user_single_controller/get_single_user__controller.dart';
import '../../services/get_single_user.dart';
import '../../services/password_recovery_service.dart';
import '../../utils/colors.dart';
import '../../utils/font_styles.dart';
import '../../utils/images.dart';
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

  // Declare TextEditingController for user info to avoid re-initialization
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  Future<String?> _getUserId() async {
    final LoginController loginController = getIt<LoginController>();
    return await loginController.getCachedUserId();
  }

  // Update the image path and rebuild the widget
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

              // Update controllers with fetched data
              nameController.text = userData?.name ?? '';
              phoneController.text = userData?.phone ?? '';
              emailController.text = userData?.email ?? '';

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
                    
                    // Profile Image Section
                    ProfileImageSection(
                      imagePath: imagePath ?? userData?.profilePhoto ?? AssetImages.loading,
                      onImageChanged: (newPath) {
                        updateImagePath( newPath!);
                      },
                    ),
                    
                    SizedBox(height: 40.h),
                    
                    // Button to navigate to seller profile
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
                    
                    // User Info Section
                    UserInfoSection(
                      nameController: nameController,
                      phoneController: phoneController,
                      emailController: emailController,
                      userId: userData?.id ?? '',
                    ),
                    
                    // Dropdown for jobs list
                   /*  DropDownCustomTextField(
                      hintText: 'المنتجات',
                      dropdownItems: jobsList,
                      onDropdownChanged: (selectedItem) {
                        if (selectedItem != null) {
                          userData?.jobs = selectedItem as List<String>?; // Update job list
                          userController.update(); // Trigger update
                        }
                      },
                    ), */
                    
                    40.heightBox,
                    Text(
                    'المنتجات',
                    style: FontStyles.font16Weight400Text,
                  ),
                    HorizontalJobsList(
                      jobsList: jobsList, // List of job items
                      onJobSelected: (selectedItem) {
                        // Update job list and trigger user controller update
                        if (selectedItem != null) {
                          userData?.jobs = [selectedItem]; // Assuming single selection, update as a list
                          userController.update(); // Trigger update
                        }
                      },
                    ),

                    
                    SizedBox(height: 10.h),
                    
                    // Password Change Section
                    PasswordChangeSection(
                      userData: userData,
                    ),
                    
                    SizedBox(height: 10.h),
                    
                    // LogOut Section
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


class HorizontalJobsList extends StatelessWidget {
  final List<String> jobsList;
  final Function(String selectedItem) onJobSelected;

  const HorizontalJobsList({
    required this.jobsList,
    required this.onJobSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, 
      child: SizedBox(
        height: 80.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: jobsList.length,
          itemBuilder: (context, index) {
            final job = jobsList[index];

            return GestureDetector(
              onTap: () {
                onJobSelected(job);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    margin: EdgeInsets.only(right: 10.w),
                    decoration: BoxDecoration(
                      color: AppColors.actionButton,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Center(
                      child: Text(
                        job,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white, // Text color
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
