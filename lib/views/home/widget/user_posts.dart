import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/const.dart';
import '../../../utils/images.dart';

class UserPosts extends StatelessWidget {
  final List<String> images;

  UserPosts({required this.images});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: images.isNotEmpty
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              itemBuilder: (context, index) {
                final String imageUrl = baseUrl + images[index];
                print('Image URL: $imageUrl');

                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: SizedBox(
                    width: 80,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: InkWell(
                        onTap: () {
                          showFullImage(context, imageUrl);
                        },
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Lottie.asset(
                                AssetImages.noData,
                                width: 80,
                                height: 80,
                              ),
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: Lottie.asset(
                                AssetImages.loading,
                                width: 250,
                                height: 250,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Lottie.asset(
                AssetImages.noData,
                width: 250,
                height: 250,
              ),
            ),
    );
  }

  void showFullImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Center(
                child: Lottie.asset(
                  AssetImages.noData,
                  width: 250,
                  height: 250,
                ),
              );
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: Lottie.asset(
                  AssetImages.loading,
                  width: 250,
                  height: 250,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
