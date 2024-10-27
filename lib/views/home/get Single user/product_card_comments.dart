import 'package:flutter/material.dart';
import 'package:ourhands/widgets/app_text/AppText.dart';

class ProductCardComments extends StatelessWidget {
  final VoidCallback onTap;

  const ProductCardComments({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
                onTap: onTap,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const CustomText(
            text: 'التعليقات',
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/fluent_chat-32-regular.png',
              width: 15,
              height: 15,
            ),
          ),
        ],
      ),
    );
  }
}
