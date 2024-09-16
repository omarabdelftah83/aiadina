import 'package:flutter/material.dart';

class CustomPaddingApp extends StatelessWidget {
  final double horizontal, vertical;

  final Widget child;

  const CustomPaddingApp(
      {super.key,
        this.vertical = 70,
        this.horizontal = 16,
        required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: child,
    );
  }
}
