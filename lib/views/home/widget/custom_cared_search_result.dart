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

// Function to open WhatsApp with Egypt's country code if not included
Future<void> whatsapp({required String contact, String text = ''}) async {
  final String formattedContact = contact.startsWith('+') ? contact : '+2$contact';
  
  final String androidUrl = "whatsapp://send?phone=$formattedContact&text=${Uri.encodeComponent(text)}";
  final String iosUrl = "https://wa.me/$formattedContact?text=${Uri.encodeComponent(text)}";
  final String webUrl = "https://api.whatsapp.com/send/?phone=$formattedContact&text=${Uri.encodeComponent(text)}";

  try {
    if (Platform.isIOS) {
      if (await canLaunchUrl(Uri.parse(iosUrl))) {
        await launchUrl(Uri.parse(iosUrl), mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(Uri.parse(webUrl), mode: LaunchMode.externalApplication);
      }
    } else if (Platform.isAndroid) {
      if (await canLaunchUrl(Uri.parse(androidUrl))) {
        await launchUrl(Uri.parse(androidUrl), mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(Uri.parse(webUrl), mode: LaunchMode.externalApplication);
      }
    } else {
      await launchUrl(Uri.parse(webUrl), mode: LaunchMode.externalApplication);
    }
  } catch (e) {
    print('Error launching WhatsApp URL: $e');
    await launchUrl(Uri.parse(webUrl), mode: LaunchMode.externalApplication);
  }
}

class CustomCaredSearchResult extends StatelessWidget {
  final UserData userData;

  const CustomCaredSearchResult({Key? key, required this.userData}) : super(key: key);

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final String? phoneNumber = (userData.posts != null &&
            userData.posts!.isNotEmpty &&
            userData.posts![0].user != null)
        ? userData.posts![0].user!.phone
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
                            onTap: () {
                              if (phoneNumber != null) {
                                whatsapp(contact: phoneNumber, text: ' اهلا بكم انا اتواصل معكم من تطبيق ايادينا ');
                              } else {
                                _showSnackBar(context, "No phone number available");
                              }
                            },
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
                          if (userData.posts != null && userData.posts!.isNotEmpty && userData.posts![0].user != null) {
                            String uploaderId = userData.posts![0].user!.id!;
                            Get.to(() => SellerPage(userID: uploaderId));
                            print("Navigating to SellerPage with userID: $uploaderId");
                          } else {
                            print("No valid user found for the post.");
                          }
                        },
                        child: CircleAvatar(
                          radius: screenWidth * 0.05,
                          backgroundColor: Colors.grey[200],
                          child: userData.images != null && userData.images!.isNotEmpty
                              ? ClipOval(
                                  child: Image.network(
                                    baseUrl + userData.images![0].url!,
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
                            ? userData.jobs!.first
                            : 'لا توجد وظيفة',
                        textColor: Colors.grey,
                      ),
                      Padding(
                        padding:const EdgeInsets.all(8.0),
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
                text: '${(userData.posts != null && userData.posts!.isNotEmpty && userData.posts![0].user != null)
                    ? userData.posts![0].user!.name ?? 'هذا المستخدم'
                    : 'هذا المستخدم'}  بعض الأعمال السابقة لـ',
              ),
              SizedBox(height: 10.h),
              UserPosts(images: userData.images?.map((image) => image.url!).toList() ?? []),
            ],
          ),
        ),
      ),
    );
  }
}
