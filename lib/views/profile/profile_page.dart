import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ourhands/widgets/appar/custom_app_padding.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../Bindings/service_locator.dart';
import '../../controllers/auth_conntroller/login_screen_controller.dart';
import '../../controllers/user_single_controller/get_single_user__controller.dart';
import '../../services/get_single_user.dart';
import '../../utils/font_styles.dart';
import '../../utils/images.dart';
import '../home/seller_page.dart';
import 'sections/horizontal_job_list.dart';
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
  late UserController userController;
  bool isControllerInitialized = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeUserController();
  }

  void _initializeUserController() async {
    final userId = await _getUserId();
    if (userId != null) {
      userController = Get.put(UserController(
        userService: GetSingleUser(),
        userId: userId,
      ));
      userController.fetchUserData();
      setState(() {
        isControllerInitialized = true; 
      });
    }
  }

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
      if (!isControllerInitialized) {
      return Scaffold(
        body: Center(
            child: Lottie.asset(
              AssetImages.loading,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          )
      );
    }

    return Scaffold(
      body: Obx(() {
        if (userController.isLoading.value) {
          return Center(
            child: Lottie.asset(
              AssetImages.loading,
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

        return CustomPaddingApp(
          child: SingleChildScrollView(
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
  imagePath: imagePath ?? (userData?.profilePhoto ?? AssetImages.loading),
  onImageChanged: (newPath) {
    updateImagePath(newPath!);
  },
),

                
                SizedBox(height: 40.h),
                
                TextButton(
                  onPressed: () {
                    if (userController.userId.isNotEmpty) {
                      Get.to(() => SellerPage(userID: userController.userId));
                    } else {
                      Get.snackbar('Error', 'Not found', snackPosition: SnackPosition.BOTTOM);
                    }
                  },
                  child: const Text('عرض الملف الشخصي'),
                ),
                
                SizedBox(height: 20.h),
                
                UserInfoSection(
                  nameController: nameController,
                  phoneController: phoneController,
                  emailController: emailController,
                  userId: userController.userId,
                ),
                
                40.heightBox,
                Text(
                  'المنتجات',
                  style: FontStyles.font16Weight400Text,
                ),
                HorizontalJobsList(
                  jobsList: jobsList,
                  onJobSelected: (selectedItem) {
                    userData?.jobs = [selectedItem];
                    userController.update();
                    print('Jobs List Length: ${jobsList.length}'); // Log the length to verify data is fetched
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
          ),
        );
      }),
    );
  }
}
