import 'package:flutter/material.dart';
import 'package:ourhands/utils/font_styles.dart';
import 'package:ourhands/utils/images.dart';
import 'package:ourhands/utils/strings.dart';

void showCustomDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        child: Container(
          height: 260,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: ModalRoute.of(context)!.animation!,
                curve: Curves.easeOut,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AssetImages.alert),
                const SizedBox(height: 20),
                FittedBox(
                  child: Text(
                    Strings.alerText,
                    style: FontStyles.font16WeightBoldText,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );

  // إغلاق الـ Dialog بعد 3 ثواني
  Future.delayed(Duration(seconds: 2), () {
    Navigator.of(context).pop();
    print("Dialog closed"); // لطباعة رسالة عند الإغلاق
  });
}
