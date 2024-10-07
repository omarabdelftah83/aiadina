import 'package:flutter/material.dart';

class FullImageDialog extends StatelessWidget {
  final String imageUrl;

  const FullImageDialog({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width * 0.9,
        child: InteractiveViewer(
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Center(
                child: ErrorPlaceholder(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.5,
                  message: 'Failed to load image',
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}


class ErrorPlaceholder extends StatelessWidget {
  final double width;
  final double height;
  final String message;

  const ErrorPlaceholder({
    required this.width,
    required this.height,
    this.message = 'No Image Available',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.broken_image,
              color: Colors.grey[400],
              size: 40.0,
            ),
           
          ],
        ),
      ),
    );
  }
}