import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ourhands/models/search_response_model.dart';
import 'package:ourhands/utils/colors.dart';
import 'package:ourhands/views/home/seller_page.dart';
import 'package:ourhands/widgets/app_text/AppText.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/const.dart';
import '../../../utils/images.dart';
import 'user_posts.dart';

class CustomCaredSearchResult extends StatefulWidget {
  final UserData userData;

  const CustomCaredSearchResult({Key? key, required this.userData}) : super(key: key);

  @override
  _CustomCaredSearchResultState createState() => _CustomCaredSearchResultState();
}

class _CustomCaredSearchResultState extends State<CustomCaredSearchResult> with SingleTickerProviderStateMixin {
  bool _isTapped = false;
  bool _showHint = false;
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(begin: Offset(1.5, 0), end: Offset(0, 0)).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _showHint = true;
      });
      _controller.forward(); // Start the animation
      // Hide hint after a few seconds
      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          _showHint = false;
        });
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final String? phoneNumber = (widget.userData.posts != null &&
            widget.userData.posts!.isNotEmpty &&
            widget.userData.posts![0].user != null)
        ? widget.userData.posts![0].user!.phone
        : null;

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
                          child: InkWell(
                            child: CustomText(
                              text: phoneNumber ?? 'لا يوجد رقم هاتف متاح',
                              textColor: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      CustomText(
                        text: (widget.userData.posts != null &&
                                widget.userData.posts!.isNotEmpty &&
                                widget.userData.posts![0].user != null)
                            ? widget.userData.posts![0].user!.name ?? 'مستخدم غير معروف'
                            : 'لا يوجد اسم مستخدم متاح',
                        fontSize: screenWidth * 0.035,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      GestureDetector(
                        onTapDown: (_) => setState(() => _isTapped = true),
                        onTapUp: (_) => setState(() => _isTapped = false),
                        onTap: () {
                          if (widget.userData.posts != null &&
                              widget.userData.posts!.isNotEmpty &&
                              widget.userData.posts![0].user != null) {
                            String uploaderId = widget.userData.posts![0].user!.id!;
                            Get.to(() => SellerPage(userID: uploaderId));
                          }
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            AnimatedScale(
                              scale: _isTapped ? 1.1 : 1.0,
                              duration: const Duration(milliseconds: 100),
                              child: CircleAvatar(
                                radius: screenWidth * 0.05,
                                backgroundColor: Colors.grey[200],
                                child: widget.userData.images != null && widget.userData.images!.isNotEmpty
                                    ? ClipOval(
                                        child: Image.network(
                                          baseUrl + widget.userData.images![0].url!,
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
                            if (_showHint)
                              Positioned(
                                top: -50
                                ,
                                child: SlideTransition(
                                  position: _offsetAnimation,
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.arrow_upward,
                                        color: Colors.green,
                                        size: 24,
                                      ),
                                      Text(
                                        'يمكن مشاهده ملف البائع',
                                        style: TextStyle(color: Colors.green, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
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
                        text: widget.userData.location ?? 'الموقع غير متوفر',
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
                  const Spacer(),
                  Row(
                    children: [
                      CustomText(
                        text: widget.userData.jobs != null && widget.userData.jobs!.isNotEmpty
                            ? widget.userData.jobs!.first
                            : 'لا توجد وظيفة',
                        textColor: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.handshake,
                          color: AppColors.actionButton,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              CustomText(
                text: '${(widget.userData.posts != null && widget.userData.posts!.isNotEmpty && widget.userData.posts![0].user != null)
                    ? widget.userData.posts![0].user!.name ?? 'هذا المستخدم'
                    : 'هذا المستخدم'}  بعض الأعمال السابقة لـ',
              ),
              SizedBox(height: 10.h),
              UserPosts(images: widget.userData.images?.map((image) => image.url!).toList() ?? []),
            ],
          ),
        ),
      ),
    );
  }
}
