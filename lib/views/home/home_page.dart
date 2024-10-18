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

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final searchController = getIt<SearchHomeController>();
  final HomeController _controller = Get.put(HomeController());
  final LoginController loginController = getIt<LoginController>();

  Future<String?> _getUserId() async {
    return await loginController.getCachedUserId();
  }

  @override
  Widget build(BuildContext context) {
    final ConnectivityController connectivityController =
        Get.put(ConnectivityController());

    final GetStorage box = GetStorage();
    bool hasShownDialog = box.read<bool>('hasShownDialogeask') ?? false;

    if (!hasShownDialog) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showCustomDialog(context);
      });
      box.write('hasShownDialogeask', true);
    }

    return Obx(() {
      if (connectivityController.connectivityStatus.value ==
          ConnectivityStatus.Offline) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.wifi_off, size: 100, color: Colors.red),
                const SizedBox(height: 20),
                Center(
                child: Lottie.asset(
                  AssetImages.noInternet,
                  fit: BoxFit.scaleDown,
                ),
              ),

                const Text(
                  'لا يوجد اتصال بالإنترنت',
                  style: TextStyle(fontSize: 20),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('أعد المحاولة'),
                ),
              ],
            ),
          ),
        );
      }

      return Scaffold(
        body: FutureBuilder<String?>(
          future: _getUserId(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.asset(
                  AssetImages.loading,
                  fit: BoxFit.scaleDown,
                ),
              );
            }

            if (snapshot.hasError ||
                !snapshot.hasData ||
                snapshot.data == null ||
                snapshot.data!.isEmpty) {
              return const Center(
                  child: Text('Error: Could not fetch user ID.'));
            }
            final UserController userController = Get.put(UserController(
              userService: getIt<GetSingleUser>(),
              userId: snapshot.data!,
            ));
            return Obx(() {
              if (userController.isLoading.value) {
                return Center(
                  child: Lottie.asset(
                    AssetImages.noInternet,
                    fit: BoxFit.scaleDown,
                  ),
                );
              }
              var userData = userController.userResponse.value.data?.user;
              return CustomPaddingApp(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildHeader(
                          userData?.name ?? 'ضيف', userData?.profilePhoto),
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
                          _controller
                              .updateSelectedLocation(selectedItem ?? '');
                        },
                      ),
                      SizedBox(height: 127.h),
                      CustomButton(
                        text: 'متابعه',
                        onTap: () {
                          final selectedJob = _controller.selectedJob.value;
                          final selectedCity = _controller.selectedCity.value;
                          final selectedLocation =
                              _controller.selectedLocation.value;

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
            });
          },
        ),
      );
    });
  }

  Widget _buildHeader(String userName, String? userImage) {
    String baseUrl = 'http://194.164.77.238:8002/';
    String? imagePath;
    if (userImage != null && userImage.isNotEmpty) {
      imagePath =
          userImage.startsWith('/') ? userImage.substring(1) : userImage;
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
              CustomText(
                text: '$userName اهلا يا ',
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(width: 10.w),
              ClipOval(
                child: imagePath != null
                    ? Image.network(
                        baseUrl + imagePath,
                        fit: BoxFit.cover,
                        width: 40,
                        height: 40,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.person_3_rounded,
                            size: 40,
                            color: AppColors.actionButton,
                          );
                        },
                      )
                    : Icon(
                        Icons.person_3_rounded,
                        size: 40,
                        color: AppColors.actionButton,
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
