import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ourhands/utils/font_styles.dart';
import 'package:ourhands/views/home/widget/custom_cared_search_result.dart';
import 'package:ourhands/widgets/appar/custom_app_padding.dart';
import 'package:lottie/lottie.dart'; 
import '../../controllers/home_controller/search_controller.dart';
import '../../services/result of search.dart';
import '../../utils/images.dart';
import '../../utils/strings.dart';

class SearchResultPage extends StatefulWidget {
  final String selectedCity;
  final String selectedLocation;
  final String selectedJob;

  const SearchResultPage({
    Key? key,
    required this.selectedCity,
    required this.selectedLocation,
    required this.selectedJob,
  }) : super(key: key);

  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  final SearchHomeController searchController = Get.put(SearchHomeController(SearchService()));

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await searchController.fetchSearchResults(
      widget.selectedCity,
      widget.selectedLocation,
      widget.selectedJob,
    );
    setState(() {}); 
  }

  @override
  Widget build(BuildContext context) {
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
                  return  Lottie.asset(
                          AssetImages.loading,
                      
                          fit: BoxFit.scaleDown,
                        );
                }
                if (searchController.errorMessage.value.isNotEmpty) {
                  return Center(child: Text(searchController.errorMessage.value));
                }

                if (searchController.searchResults.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          AssetImages.noData,
                          width: 250.w,
                          height: 250.h,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          "No results found for your search.",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "Try adjusting your search criteria to find more results.",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: searchController.searchResults.length,
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
