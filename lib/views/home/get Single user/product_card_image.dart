import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../utils/images.dart';

class ProductCardImage extends StatelessWidget {
  final List<String> imageUrls;

  const ProductCardImage({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return imageUrls.isNotEmpty
        ? SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                final String imageUrl = imageUrls[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      showFullImage(context, imageUrls[index]);
                    },
                    child: Image.network(
                      imageUrl,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else { 
                          return Center(
                            child: Lottie.asset(
                              AssetImages.loading,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          );
                        }
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(child: Icon(Icons.error));
                      },
                    ),
                  ),
                );
              },
            ),
          )
        : Center(
            child: Lottie.asset(
              AssetImages.noData,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          );
  }

  void showFullImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FullImageDialog(imageUrl: imageUrl);
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
      height: 100,
      width: 100,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          imagePath,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            } else {
              return Center(
                child: Lottie.asset(
                  AssetImages.loading,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              );
            }
          },
          errorBuilder: (context, error, stackTrace) {
            return const Center(child: Icon(Icons.error));
          },
        ),
      ),
    );
  }
}

class FullImageDialog extends StatelessWidget {
  final String imageUrl;

  const FullImageDialog({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Image.network(
        imageUrl,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return Center(
              child: Lottie.asset(
                AssetImages.loading,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            );
          }
        },
        errorBuilder: (context, error, stackTrace) {
          return const Center(child: Icon(Icons.error));
        },
      ),
    );
  }
}
