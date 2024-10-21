import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ourhands/views/home/home_page.dart';
import 'package:ourhands/views/profile/page_loading.dart';
import '../../controllers/user_single_controller/get_single_user__controller.dart';
import '../../models/get_single_user.dart';
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
  Map<String, bool> isDeletingMap = {}; // لتتبع حالة التحميل لكل عنصر
  @override
  void initState() {
    super.initState();
    userController = Get.put(UserController(
      userService: GetSingleUser(),
      userId: widget.userID,
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      userController.fetchUserData();
    });
  }
  void _deleteItem(String postId) async {
    setState(() {
      isDeletingMap[postId] = true; // تعيين حالة التحميل للعنصر
    });

    try {
      await DeleteItem().deleteItem(postId);
      setState(() {
        // تحديث واجهة المستخدم بعد حذف العنصر
        userController.userResponse.value.data?.user?.posts?.removeWhere((post) => post.id == postId);
        isDeletingMap.remove(postId); // إزالة حالة التحميل بعد الانتهاء
      });
      Get.snackbar('Success', 'Item deleted successfully');
    } catch (e) {
      setState(() {
        isDeletingMap.remove(postId); // إزالة حالة التحميل إذا حدث خطأ
      });
      Get.snackbar('Error', 'Failed to delete item');
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
            child: Text('Error: ${userController.errorMessage.value}'),
          );
        } else {
          final user = userController.userResponse.value.data?.user;

          if (user == null) {
            return const Center(child: Text('User not found'));
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
                            text: user.name ?? 'User Name',
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
                        label: user.jobs?.first ?? 'No Jobs',
                        icon: 'assets/images/mdi_cake.png',
                        iconSize: 24,
                      ),
                      ContactInfoRow(
                        label: user.location ?? 'Location',
                        icon: Icons.location_on,
                        iconColor: Colors.green,
                      ),
                      ContactInfoRow(
                        label: user.phone ?? 'Phone',
                        icon: Icons.call,
                        iconColor: Colors.green,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: user.posts?.length ?? 0,
                    itemBuilder: (context, index) {
                      final post = user.posts![index];
                      return ProductCard(
                        item: post,
                        onDelete: _deleteItem, // تمرير دالة الحذف هنا
                        isDeleting: isDeletingMap[post.id] ?? false, // تمرير حالة التحميل
                      );
                    },
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
