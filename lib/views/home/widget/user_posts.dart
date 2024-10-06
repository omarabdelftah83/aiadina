import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../models/search_response_model.dart';
import '../../../utils/const.dart';
import '../../../utils/images.dart';

class UserPosts extends StatelessWidget {
  final List<Post> posts; // Changed to Post type

  UserPosts({required this.posts});

  @override
  Widget build(BuildContext context) {
    return SizedBox(  // Set a specific height for the UserPosts widget
      height: 100,  // Adjust the height as needed
      child: posts.isNotEmpty
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: posts.length,
              itemBuilder: (context, index) {
                // Use null-aware operator to handle nullable image URL
                final String imageUrl = baseUrl + (posts[index].image?.url ?? ''); // Default to an empty string if null
                print('Image URL: $imageUrl'); // Debugging image URL

                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: SizedBox(
                    width: 80,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
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
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          );
                        },
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
}
