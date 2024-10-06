import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ourhands/controllers/home_controller/get_search_controller.dart';
import 'package:ourhands/views/ads/ads_page.dart';
import 'package:ourhands/views/home/search_result_page.dart';
import 'package:ourhands/views/profile/profile_page.dart';
import 'package:ourhands/widgets/alert_dialog.dart';
import 'package:ourhands/widgets/app_text/AppText.dart';
import 'package:ourhands/widgets/appar/custom_app_padding.dart';
import 'package:ourhands/widgets/custom/custom_button.dart';
import 'package:ourhands/widgets/text_failed/drop_down_custom_textfailed.dart';
import '../../Bindings/service_locator.dart';
import '../../controllers/home_controller/search_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final searchController = getIt<SearchHomeController>();
  final HomeController _controller = Get.put(HomeController());


  @override
  Widget build(BuildContext context) {
    final GetStorage box = GetStorage();
    bool hasShownDialog = box.read<bool>('hasShownDialogeask') ?? false;
    if (!hasShownDialog) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showCustomDialog(context);
      });
      box.write('hasShownDialogeask', true);
    }

    return Scaffold(
      body: CustomPaddingApp(
        child: SingleChildScrollView(
          child: Obx(() {
            if (_controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildHeader(),
                SizedBox(height: 50.h),
                const CustomText(
                  text: 'بتدور على ايه؟',
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 10.h),
                DropDownCustomTextfailed(
                  hintText: 'اختر نوع الخدمة',
                  dropdownItems: _controller.jobs.where((job) => job != null).cast<String>().toList(), 
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
                  dropdownItems: _controller.cities.where((city) => city != null).cast<String>().toList(), 
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
                  dropdownItems: _controller.locations.where((location) => location != null).cast<String>().toList(), 
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
            );
          }),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Get.to(const AdsPage());
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
          onTap: () {
            Get.to(const ProfilePage());
          },
          child: Row(
            children: [
              const CustomText(
                text: 'اهلا مريم',
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(width: 10.w),
              const CircleAvatar(),
            ],
          ),
        ),
      ],
    );
  }
}
