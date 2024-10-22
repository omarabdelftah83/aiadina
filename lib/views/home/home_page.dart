import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:ourhands/controllers/home_controller/get_search_controller.dart';
import 'package:ourhands/utils/colors.dart';
import 'package:ourhands/utils/images.dart';
import 'package:ourhands/views/home/search_result_page.dart';
import 'package:ourhands/views/profile/profile_page.dart';
import 'package:ourhands/widgets/alert_dialog.dart';
import 'package:ourhands/widgets/app_text/AppText.dart';
import 'package:ourhands/widgets/appar/custom_app_padding.dart';
import 'package:ourhands/widgets/custom/custom_button.dart';
import 'package:ourhands/widgets/text_failed/drop_down_custom_textfailed.dart';
import '../../Bindings/service_locator.dart';
import '../../controllers/auth_conntroller/login_screen_controller.dart';
import '../../controllers/connectivity internet/connectivity_controller.dart';
import '../../controllers/home_controller/search_controller.dart';
import '../../controllers/user_single_controller/get_single_user__controller.dart';
import '../../services/get_single_user.dart';
import '../../widgets/shared/custom_check_internet.dart';
import '../profile/page_loading.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = getIt<SearchHomeController>();
  final HomeController _controller = Get.put(HomeController());
  final LoginController loginController = getIt<LoginController>();
  final ConnectivityController connectivityController = Get.put(ConnectivityController());
  final GetStorage box = GetStorage();
  late UserController userController;
  bool isControllerInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializePage();
    connectivityController.connectivityStream.listen((status) {
      if (status == ConnectivityStatus.Offline) {
        _showNoInternetDialog();
      }
    });
  }

  Future<void> _initializePage() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      bool hasShownDialog = box.read<bool>('hasShownDialogeask') ?? false;

      if (!hasShownDialog) {
        showCustomDialog(context);
        box.write('hasShownDialogeask', true);
      }

      if (connectivityController.connectivityStatus.value == ConnectivityStatus.Offline) {
        _showNoInternetDialog();
      }

      final userId = await _getUserId();
      if (userId != null) {
        userController = Get.put(UserController(
          userService: getIt<GetSingleUser>(),
          userId: userId,
        ));

        userController.fetchUserData();
        setState(() {
          isControllerInitialized = true;
        });
      }
    });
  }

  Future<String?> _getUserId() async {
    return await loginController.getCachedUserId();
  }

  void _showNoInternetDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('No Internet Connection'),
        content: const Text('Please check your internet connection and try again.'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('OK'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!isControllerInitialized) {
      return Scaffold(
        body: Center(
          child: Lottie.asset(
            AssetImages.loading,
            fit: BoxFit.scaleDown,
          ),
        ),
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
        return CustomPaddingApp(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildHeader(userData?.name ?? 'ضيف', userData?.profilePhoto),
                SizedBox(height: 50.h),
                const CustomText(
                  text: 'بتدور على ايه؟',
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 10.h),
                DropDownCustomTextfailed(
                  hintText: 'اختر نوع الخدمة',
                  dropdownItems: _controller.jobs
                      .where((job) => job != null)
                      .cast<String>()
                      .toList(),
                  onDropdownChanged: (selectedItem) {
                    _controller.updateSelectedJob(selectedItem ?? '');
                  },
                ),
                SizedBox(height: 50.h),
                const CustomText(
                  text: 'محافظة ايه؟',
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 10.h),
                DropDownCustomTextfailed(
                  hintText: 'اختر المحافظة',
                  dropdownItems: _controller.cities
                      .where((city) => city != null)
                      .cast<String>()
                      .toList(),
                  onDropdownChanged: (selectedItem) {
                    _controller.updateSelectedCity(selectedItem ?? '');
                  },
                ),
                SizedBox(height: 50.h),
                const CustomText(
                  text: 'حى ايه ؟',
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 10.h),
                DropDownCustomTextfailed(
                  hintText: 'اختر الحي',
                  dropdownItems: _controller.locations
                      .where((location) => location != null)
                      .cast<String>()
                      .toList(),
                  onDropdownChanged: (selectedItem) {
                    _controller.updateSelectedLocation(selectedItem ?? '');
                  },
                ),
                SizedBox(height: 127.h),
                CustomButton(
                  text: 'متابعه',
                  onTap: () {
                    final selectedJob = _controller.selectedJob.value;
                    final selectedCity = _controller.selectedCity.value;
                    final selectedLocation = _controller.selectedLocation.value;

                    Get.to(() => SearchResultPage(
                          selectedCity: selectedCity,
                          selectedLocation: selectedLocation,
                          selectedJob: selectedJob,
                        ));
                  },
                  height: 45,
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildHeader(String userName, String? userImage) {
    String baseUrl = 'http://194.164.77.238:8002/';
    String? imagePath;
    if (userImage != null && userImage.isNotEmpty) {
      imagePath = userImage.startsWith('/') ? userImage.substring(1) : userImage;
    }

    return Row(
      children: [
        InkWell(
          onTap: () {
            Get.to(() => const PageLoading());
          },
          child: const CustomText(
            textColor: Colors.green,
            text: 'اضف اعلان',
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: () async {
            Get.to(() => const ProfilePage());
          },
          child: Row(
            children: [
              Tooltip(
                message: 'الذهاب إلى الملف الشخصي',
                child: CustomText(
                  text: '$userName اهلا يا ',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10.w),
              Tooltip(
                message: 'الذهاب إلى الملف الشخصي',
                child: Column(
                  children: [
                    ClipOval(
                      child: imagePath != null
                          ? Image.network(
                              baseUrl + imagePath,
                              fit: BoxFit.cover,
                              width: 40,
                              height: 40,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: Lottie.asset(
                                    AssetImages.loading,
                                    width: 40,
                                    height: 40,
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.person_3_rounded,
                                  size: 40,
                                  color: AppColors.actionButton,
                                );
                              },
                            )
                          : Center(
                              child: Lottie.asset(
                                AssetImages.loading,
                                width: 40,
                                height: 40,
                              ),
                            ),
                    ),
                    SizedBox(height: 4.h),
                    const Text(
                      'الملف الشخصي',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}