import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  final int rating;
  final ValueChanged<int> onRatingUpdate;
  final double size;

  const RatingWidget({
    super.key,
    required this.rating,
    required this.onRatingUpdate,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () => onRatingUpdate(index + 1),
          child: Icon(
            Icons.star_rounded,
            color: index < rating ? Colors.amber : Colors.grey,
            size: size,
          ),
        );
      }),
    );
  }
}