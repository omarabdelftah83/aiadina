import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ourhands/utils/font_styles.dart';
import 'package:ourhands/views/home/widget/custom_cared_search_result.dart';
import 'package:ourhands/widgets/appar/custom_app_padding.dart';
import '../../Bindings/service_locator.dart';
import '../../controllers/home_controller/search_controller.dart';
import '../../utils/strings.dart';

class SearchResultPage extends StatelessWidget {
  const SearchResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = getIt<SearchHomeController>();

    return Scaffold(
      body: CustomPaddingApp(
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
                    Strings.serachResult,
                    style: FontStyles.appbartext,
                  ),
                  SizedBox(width: 48.w),
                ],
              ),
            ),
           Expanded(
  child: Obx(() {
    if (searchController.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }
    if (searchController.errorMessage.value.isNotEmpty) {
      return Center(child: Text(searchController.errorMessage.value));
    }
    
    print('Current Search Results: ${searchController.searchResults.value.toList()}'); 
    
    if (searchController.searchResults.value.isEmpty) {
      return const Center(child: Text("No results found."));
    }
    
    return ListView.builder(
      itemCount: searchController.searchResults.value.length,
      itemBuilder: (context, index) {
        final userData = searchController.searchResults[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 9),
          child: CustomCaredSearchResult(userData: userData),
        );
      },
    );
  }),
),
          ],
        ),
      ),
    );
  }
}
