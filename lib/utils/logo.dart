import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width - 150,
      height: MediaQuery.sizeOf(context).height / 27,
      decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/logo.png'))),
    );
  }
}