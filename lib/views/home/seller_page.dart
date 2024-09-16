import 'package:flutter/material.dart';
import 'package:ourhands/views/home/widget/contact_info.dart';
import 'package:ourhands/views/home/widget/custom_rating.dart';
import 'package:ourhands/views/home/widget/product_cared.dart';
import 'package:ourhands/widgets/app_text/AppText.dart';
import 'package:ourhands/widgets/appar/custom_app_padding.dart';

class SellerPage extends StatefulWidget {
  const SellerPage({super.key});

  @override
  _SellerPageState createState() => _SellerPageState();
}

class _SellerPageState extends State<SellerPage> {
  int _rating = 0;

  final List<Map<String, String>> items = [
    {
      'image1': 'assets/images/Frame 35.png',
      'image2': 'assets/images/Frame 36.png'
    },
    {
      'image1': 'assets/images/Frame 35.png',
      'image2': 'assets/images/Frame 36.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: CustomPaddingApp(
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
                      const CustomText(
                        text: 'سارة محمد',
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                      RatingWidget(
                        rating: _rating,
                        onRatingUpdate: (newRating) {
                          setState(() {
                            _rating = newRating;
                          });
                        },
                        size: 15,
                      ),
                    ],
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  CircleAvatar(
                    radius: screenWidth * 0.07,
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ContactInfoRow(
                    label: 'تورت و حلويات',
                    icon: 'assets/images/mdi_cake.png',
                    iconSize: 24,
                  ),
                  ContactInfoRow(
                    label: 'الحى الرابع , 6 اكتوبر',
                    icon: Icons.location_on,
                    iconColor: Colors.green,
                  ),
                  ContactInfoRow(
                    label: '01213456789',
                    icon: Icons.call,
                    iconColor: Colors.green,
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RatingWidget(
                    rating: _rating,
                    onRatingUpdate: (newRating) {
                      setState(() {
                        _rating = newRating;
                      });
                    },
                    size: 25,
                  ),
                  const SizedBox(width: 10),
                  const CustomText(text: 'قيم'),
                ],
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ProductCard(item: items[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}