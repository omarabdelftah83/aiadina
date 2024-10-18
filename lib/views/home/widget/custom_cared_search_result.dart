import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ourhands/models/search_response_model.dart';
import 'package:ourhands/views/home/seller_page.dart';
import 'package:ourhands/widgets/app_text/AppText.dart';
import '../../../utils/const.dart';
import '../../../utils/images.dart';
import 'user_posts.dart';

class CustomCaredSearchResult extends StatelessWidget {
  final UserData userData;

  const CustomCaredSearchResult({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
    
      width: screenWidth * 0.9,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        elevation: 2.0,
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                       
                        Flexible(
                          child: CustomText(
                            text: (userData.posts != null &&
                                    userData.posts!.isNotEmpty &&
                                    userData.posts![0].user != null)
                                ? userData.posts![0].user!.phone ?? '0123456789'
                                : 'لا يوجد رقم هاتف متاح',
                            textColor: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      CustomText(
                        text: (userData.posts != null &&
                                userData.posts!.isNotEmpty &&
                                userData.posts![0].user != null)
                            ? userData.posts![0].user!.name ?? 'مستخدم غير معروف'
                            : 'لا يوجد اسم مستخدم متاح',
                        fontSize: screenWidth * 0.035,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(width: screenWidth * 0.02),
                   InkWell(
                     onTap: () {
  if (userData.posts != null && userData.posts!.isNotEmpty) {
    Get.to(() => SellerPage(userID: userData.posts![0].user!.id!));
    print("Navigating to SellerPage with userID: ${userData.posts![0].user!.id}");

  }
},
                     child: CircleAvatar(
                                 radius: screenWidth * 0.05,
                                 backgroundColor: Colors.grey[200],
                                 child: userData.images != null && userData.images!.isNotEmpty
                                     ? ClipOval(
                      child: Image.network(
                       baseUrl+ userData.images![0],
                        fit: BoxFit.cover,
                        width: 100, 
                        height: 100, 
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Lottie.asset(
                              AssetImages.noImage,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                                       )
                                     : Center(
                      child: Lottie.asset(
                        AssetImages.noImage,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                                       ),
                               ),
                   ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CustomText(
                        text: userData.location ?? 'الموقع غير متوفر',
                        textColor: Colors.grey,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.location_on,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      CustomText(
                        text: userData.jobs != null && userData.jobs!.isNotEmpty
                            ? userData.jobs!.take(1).toString()
                            : 'لا توجد وظيفة',
                        textColor: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/images/mdi_cake.png'),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.h),
             CustomText(
      text: '${(userData.posts != null && userData.posts!.isNotEmpty && userData.posts![0].user != null) 
    ? userData.posts![0].user!.name ?? 'هذا المستخدم'
    : 'هذا المستخدم'}  بعض الأعمال السابقة لـ',
    ),
    
              SizedBox(height: 10.h),
          UserPosts(images: userData.images ?? [])
    
            ],
          ),
        ),
      ),
    );
  }
} 
