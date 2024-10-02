import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/colors.dart';
import '../../utils/font_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double? width;
  final double? height;
  final bool isLoading;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final bool showBorder;
  final double borderRadius;
  final TextStyle? textStyle; 

  const CustomButton({
    super.key,
    this.width,
    this.height,
    this.isLoading = false,
    this.color,
    this.textColor,
    this.borderColor,
    this.showBorder = false,
    this.borderRadius = 8.0,
    required this.text,
    required this.onTap,
    this.textStyle, 
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
                  style: textStyle ?? FontStyles.font18Weight500White.copyWith(
                    color: textColor ?? Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
