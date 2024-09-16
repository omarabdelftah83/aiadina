import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  MyButton({ this.color,  this.title,  this.onPressed});

  final Color? color;
  final String? title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        width: double.infinity,
        child: Material(
          color: color,
          borderRadius: BorderRadius.circular(30),
          child: MaterialButton(
            onPressed: onPressed,
            height: 42,
            minWidth: 200,
            child: Text(
              title!,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
