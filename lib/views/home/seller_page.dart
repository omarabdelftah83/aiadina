import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ourhands/views/home/home_page.dart';
import '../../controllers/user_single_controller/get_single_user__controller.dart';
import '../../services/get_single_user.dart';
import '../../utils/const.dart';
import '../../utils/images.dart';
import 'widget/contact_info.dart';
import 'package:ourhands/widgets/app_text/AppText.dart';
import 'package:ourhands/widgets/appar/custom_app_padding.dart';
import 'get Single user/product_cared.dart';

class SellerPage extends StatefulWidget {
  final String userID;

  const SellerPage({super.key, required this.userID});

  @override
  _SellerPageState createState() => _SellerPageState();
}

class _SellerPageState extends State<SellerPage> {
  late UserController userController;
  Map<String, bool> isDeletingMap = {}; 

  @override
  void initState() {
    super.initState();
    Get.delete<UserController>(tag: widget.userID);

    userController = Get.put(
      UserController(
        userService: GetSingleUser(),
        userId: widget.userID,
      ),
      tag: widget.userID,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      userController.fetchUserData();
    });
  }

  void _deleteItem(String postId) async {
    setState(() {
      isDeletingMap[postId] = true; 
    });

    try {
      await DeleteItem().deleteItem(postId);
      setState(() {
        userController.userResponse.value.data?.user?.posts?.removeWhere((post) => post.id == postId);
        isDeletingMap.remove(postId); 
      });
      Get.snackbar('نجاح', 'تم حذف العنصر بنجاح');
    } catch (e) {
      setState(() {
        isDeletingMap.remove(postId);
      });
      Get.snackbar('خطأ', 'فشل في حذف العنصر. يرجى المحاولة مرة أخرى.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (userController.isLoading.value) {
          return Center(
            child: Lottie.asset(
              AssetImages.loading,
              width: 250,
              height: 250,
            ),
          );
        } else if (userController.errorMessage.isNotEmpty) {
          return Center(
            child: Text('خطأ: ${userController.errorMessage.value}'),
          );
        } else {
          final user = userController.userResponse.value.data?.user;

          if (user == null) {
            return const Center(child: Text('المستخدم غير موجود'));
          }

          return CustomPaddingApp(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: user.name ?? 'اسم المستخدم',
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                      CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.07,
                        backgroundImage: user.profilePhoto?.isNotEmpty == true
                            ? NetworkImage(baseUrl + user.profilePhoto!)
                            : null,
                        child: user.profilePhoto?.isEmpty == true
                            ? const Icon(Icons.person)
                            : null,
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 22,
                        ),
                        onPressed: () {
                          Get.to(() => HomePage());
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ContactInfoRow(
                        label: (user.jobs != null && user.jobs!.isNotEmpty) ? user.jobs!.first : 'لا توجد وظيفة',
                        icon: 'assets/images/mdi_cake.png',
                        iconSize: 24,
                      ),
                      ContactInfoRow(
                        label: user.location ?? 'الموقع',
                        icon: Icons.location_on,
                        iconColor: Colors.green,
                      ),
                      ContactInfoRow(
                        label: user.phone ?? 'رقم الهاتف',
                        icon: Icons.call,
                        iconColor: Colors.green,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const SizedBox(height: 20),
                  if (user.posts != null && user.posts!.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      reverse: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: user.posts!.length,
                      itemBuilder: (context, index) {
                        final post = user.posts![index];
                        return ProductCard(
                          item: post,
                          onDelete: _deleteItem, 
                          isDeleting: isDeletingMap[post.id] ?? false,
                        );
                      },
                    )
                  else
                    Center(
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
                            "لا توجد منشورات متاحة.",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[700],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
