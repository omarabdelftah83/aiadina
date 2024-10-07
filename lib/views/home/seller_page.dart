import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../controllers/user_single_controller/get_single_user__controller.dart';
import '../../services/get_single_user.dart';
import '../../utils/images.dart';
import '../../widgets/shared/show_full_image.dart';
import 'widget/contact_info.dart';
import 'widget/custom_rating.dart';
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
  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController(
      userService: GetSingleUser(),
      userId: widget.userID,
    ));

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
            child: Text(userController.errorMessage.value),
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
                        /*   RatingWidget(
                            rating: 5 ,
                            onRatingUpdate: (newRating) {
                              setState(() {
                                // Handle rating update if needed
                              });
                            },
                            size: 15,
                          ), */
                        ],
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                      CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.07,
                        backgroundImage: user.profilePhoto?.isNotEmpty == true
                            ? NetworkImage(user.profilePhoto!)
                            : null,
                        child: user.profilePhoto?.isEmpty == true
                            ? const Icon(Icons.person)
                            : null,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ContactInfoRow(
                        label:user.jobs!.first ?? 'No Jobs',
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
                 /*  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RatingWidget(
                        rating:  5, 
                        onRatingUpdate: (newRating) {
                          setState(() {
                          });
                        },
                        size: 25,
                      ),
                      const SizedBox(width: 10),
                      const CustomText(text: 'قيم'), 
                    ],
                  ), */
                  const SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: user.posts!.length, 
                    itemBuilder: (context, index) {
                      return ProductCard(item: user.posts![index]); 
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