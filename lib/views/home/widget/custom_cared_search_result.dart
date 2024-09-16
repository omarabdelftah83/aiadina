import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ourhands/views/home/seller_page.dart';
import 'package:ourhands/widgets/app_text/AppText.dart';

class CustomCaredSearchResult extends StatelessWidget {
  const CustomCaredSearchResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const SellerPage()));
      },
      child: SizedBox(
        height: screenHeight * 0.4,
        width: screenWidth * 2.2,
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
                SizedBox(width: screenWidth * 0.1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 70.w,
                        ),
                        const CustomText(
                          text: '0123456789',
                          textColor: Colors.grey,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CustomText(
                          text: 'احمد السالم',
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        CircleAvatar(
                          radius: screenWidth * 0.05,
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CustomText(
                          text: 'الحى الرابع , 6 اكتوبر',
                          textColor: Colors.grey,
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.location_on,
                              color: Colors.green,
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        const CustomText(
                          text: 'تورت و حلويات',
                          textColor: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('assets/images/mdi_cake.png'),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 20.h,),
                const CustomText(text: 'بعض الاعمال السابقة'),
                SizedBox(height: 10.h,),

                Container(
                  height: 70,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
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
                              child: Image.asset(
                                'assets/images/Frame 34.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
