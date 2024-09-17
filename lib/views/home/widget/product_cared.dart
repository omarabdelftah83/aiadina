import 'package:flutter/material.dart';
import 'package:ourhands/widgets/app_text/AppText.dart';
import 'package:ourhands/widgets/text_failed/custom_text_failed.dart';

class ProductCard extends StatelessWidget {
  final Map<String, String> item;

  const ProductCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: const BorderSide(color: Colors.grey, width: 0.1),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: 'منذ يوم',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                CustomText(
                  text: 'كيك شوكولاتة',
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ImageContainer(imagePath: item['image1']!),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ImageContainer(imagePath: item['image2']!),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const CustomText(
                  text: 'التعليقات',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                InkWell(
                  onTap: () {
                    _showCommentDialog(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/fluent_chat-32-regular.png',
                      width: 15,
                      height: 15,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Function to show dialog
  void _showCommentDialog(BuildContext context) {
    final TextEditingController _commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: const BorderSide(color: Colors.grey, width: 0.5),
          ),
          content: Container(
            height: 380,
            width: 340,
            child: Stack(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Align(
                          alignment: Alignment.topRight,
                          child: CustomText(
                            text: 'التعليقات',
                            textColor: Colors.green,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.arrow_forward_ios_rounded),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: 15,
                        itemBuilder: (context, index) {
                          return const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    CustomText(text: 'نهى محمود'),
                                    // يمكنك استبدال النص بأسماء مختلفة
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        radius: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                CustomText(
                                    text:
                                        'الكيكة كانت لذيذة جداً وطازجة، شكراً على الخدمة الممتازة',fontSize: 12,)
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: CustomTextField(
                    prefixIcon: Icon(Icons.arrow_left),
                    controller: _commentController,
                    maxLines: 3,
                    hintText: '...اكتب تعليق',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ImageContainer extends StatelessWidget {
  final String imagePath;

  const ImageContainer({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Image.asset(
        imagePath,
        width: 160,
        height: 130,
        fit: BoxFit.cover,
      ),
    );
  }
}
