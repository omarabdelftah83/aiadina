import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/colors.dart';
import '../../utils/font_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double? width;
  final double? height; // New parameter for height
  final bool isLoading;
  final Color? color;
  final Color? textColor;
  final Color? borderColor; // Border color
  final bool showBorder; // New field to show/hide the border
  final double borderRadius; // New parameter for border radius

  const CustomButton({
    super.key,
    this.width,
    this.height, // Initialize height
    this.isLoading = false,
    this.color, 
    this.textColor, 
    this.borderColor, // Initialize the border color
    this.showBorder = false, // Default to no border
    this.borderRadius = 8.0,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: width ?? MediaQuery.of(context).size.width,
        height: height ?? 50.h, 
        decoration: BoxDecoration(
          color: color ?? AppColors.actionButton, 
          borderRadius: BorderRadius.circular(borderRadius), 
          border: showBorder
              ? Border.all(
                  color: borderColor ?? Colors.transparent, 
                  width: 1.0, 
                )
              : null, 
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
                  height: 24.h,
                  width: 24.h,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.0,
                  ),
                )
              : Text(
                  text,
                  style: FontStyles.font18Weight500White.copyWith(
                    color: textColor ?? Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
