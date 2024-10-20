import 'package:flutter/material.dart';
import 'package:ourhands/models/get_single_user.dart';
import 'package:ourhands/widgets/app_text/AppText.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../utils/const.dart';
import 'comments_dialog.dart';
import 'product_card_image.dart';
import 'product_card_comments.dart';

class ProductCard extends StatelessWidget {
  final Post item;
  const ProductCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Map each image URL from the images list
    final List<String> imageUrls = item.images != null
        ? item.images!.map((image) => baseUrl + image.url!).toList()
        : [];

    print('Full Image URLs: $imageUrls'); // Debugging: printing the image URLs

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
            _buildHeader(),
            const SizedBox(height: 8),
            // Pass the list of image URLs to the ProductCardImage widget
            ProductCardImage(imageUrls: imageUrls),
            ProductCardComments(onTap: () {
              CommentsDialog.show(context, item.id!);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: formatTimeAgo(item.createdAt),
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        CustomText(
          text: item.title ?? 'Product Name',
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }

  String formatTimeAgo(String? createdAt) {
    if (createdAt == null) return 'منذ يوم';
    final DateTime dateTime = DateTime.parse(createdAt);
    return timeago.format(dateTime);
  }
}
