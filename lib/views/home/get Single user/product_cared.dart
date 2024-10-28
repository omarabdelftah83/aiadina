import 'package:flutter/material.dart';
import 'package:ourhands/models/get_single_user.dart';
import 'package:ourhands/widgets/app_text/AppText.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../utils/const.dart';
import 'comments_dialog.dart';
import 'product_card_image.dart';
import 'product_card_comments.dart';
import 'package:shimmer/shimmer.dart';

class ProductCard extends StatelessWidget {
  final Post item;
  final Function(String) onDelete;
  final bool isDeleting;
  final String currentUserId;

  const ProductCard({
    Key? key,
    required this.item,
    required this.onDelete,
    required this.isDeleting,
    required this.currentUserId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> imageUrls = item.images != null
        ? item.images!.map((image) => baseUrl + image.url!).toList()
        : [];
    final String ownerID = item.user?.id ?? '';

    return Stack(
      children: [
        isDeleting
            ? _buildShimmerEffect()
            : Card(
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
                      ProductCardImage(imageUrls: imageUrls),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: ProductCardComments(
                              onTap: () {
                                CommentsDialog.show(context, item.id!);
                              },
                            ),
                          ),
                          if (item.user != null && ownerID == currentUserId)
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.redAccent),
                              onPressed: () => onDelete(item.id!),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ],
    );
  }

  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Card(
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
              Container(
                width: double.infinity,
                height: 20.0,
                color: Colors.white,
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                height: 150.0,
                color: Colors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 80.0,
                    height: 20.0,
                    color: Colors.white,
                  ),
                  Container(
                    width: 40.0,
                    height: 40.0,
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
        const SizedBox(height: 5),
        CustomText(
          text: item.description ?? 'Product description',
          fontSize: 14,
          textAlign: TextAlign.end, 
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
