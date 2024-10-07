import 'package:flutter/material.dart';
import 'package:ourhands/widgets/app_text/AppText.dart';

class ContactInfoRow extends StatelessWidget {
  final String label;
  final dynamic icon;
  final double? iconSize;
  final Color? iconColor;

  const ContactInfoRow({
    Key? key,
    required this.label,
    this.icon,
    this.iconSize = 24,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          fontSize: 12,
          text: label,
          textColor: Colors.grey,
        ),
        const SizedBox(width: 8),
        icon is String
            ? Image.asset(
          icon,
          width: iconSize,
          height: iconSize,
        )
            : IconButton(
          onPressed: () {},
          icon: Icon(
            icon,
            size: iconSize,
            color: iconColor,
          ),
        ),
      ],
    );
  }
}