

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ourhands/utils/colors.dart';

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
