import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ourhands/models/search_response_model.dart';
import 'package:ourhands/views/home/seller_page.dart';
import 'package:ourhands/widgets/app_text/AppText.dart';

class CustomCaredSearchResult extends StatelessWidget {
  final UserData userData;

  const CustomCaredSearchResult({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SellerPage()),
        );
      },
      child: SizedBox(
        height: screenHeight * 0.4,
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
                    Row(
                      children: [
                        SizedBox(width: 70.w),
                        CustomText(
                          text: userData.id ?? '0123456789',
                          textColor: Colors.grey,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CustomText(
                          text: userData.city ?? 'Unknown City',
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        CircleAvatar(
                          radius: screenWidth * 0.05,
                          backgroundImage: userData.images!.isNotEmpty
                              ? NetworkImage(userData.images![0])
                              : const AssetImage('assets/images/default_avatar.png') as ImageProvider,
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
                          text: userData.location ?? 'Location not provided',
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
                    Row(
                      children: [
                        CustomText(
                          text: userData.jobs!.isNotEmpty
                              ? userData.jobs!.join(', ')
                              : 'No job listed',
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
                const CustomText(text: 'Some previous works'),
                SizedBox(height: 10.h),
                Container(
                  height: 70,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: userData.images!.length,
                    itemBuilder: (context, index) {
                      String imageUrl = userData.images!.isNotEmpty
                          ? userData.images![index]
                          : 'assets/images/placeholder.png';

                      return Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: SizedBox(
                          width: 80.w,
                          height: 120.h,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Image.asset(
                                  'assets/images/placeholder.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
