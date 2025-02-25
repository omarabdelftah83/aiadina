import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/colors.dart';
import '../../utils/font_styles.dart';

class AuthTextFormField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType textInputType;
  final bool obSecureText;
  final IconData? suffixIcon;
  final VoidCallback? suffixTap;
  final String? Function(String?)? validator;
  final bool enabled;
  final String? hintText;
  final double height; // Add height parameter
  final double width; // Add width parameter
  final double borderRadius; // Add borderRadius parameter
  final Function(String)? onChanged; // Add onChanged parameter

  AuthTextFormField({
    required this.label,
    required this.controller,
    required this.textInputType,
    this.obSecureText = false,
    this.suffixIcon,
    this.suffixTap,
    this.validator,
    this.enabled = true,
    this.hintText,
    this.height = 55.0, // Default height
    this.width = double.infinity, // Default width
    this.borderRadius = 6.0,
    this.onChanged, // Initialize onChanged
  });

  @override
  _AuthTextFormFieldState createState() => _AuthTextFormFieldState();
}

class _AuthTextFormFieldState extends State<AuthTextFormField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obSecureText;
  }

  @override
  Widget build(BuildContext context) {
    double textFieldHeight = widget.height; // Initial height

    if (widget.validator != null) {
      final String? errorText = widget.validator!(widget.controller.text);
      if (errorText != null && errorText.isNotEmpty) {
        textFieldHeight = widget.height + 20.0; // Increase height if there's an error
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Text(
              widget.label,
              style: FontStyles.font14Weight400RightAligned.copyWith(
                color: AppColors.textColor,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          SizedBox(height: 10.h),
          SizedBox(
            width: widget.width,
            height: textFieldHeight,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                controller: widget.controller,
                keyboardType: widget.textInputType,
                obscureText: _obscureText,
                enabled: widget.enabled,
                onChanged: widget.onChanged, // Set onChanged
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  hintText: widget.hintText,
                  suffixIcon: widget.obSecureText
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.iconeye,
                          ),
                        )
                      : null,
                  isDense: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    borderSide: BorderSide(
                      width: 2,
                      color: AppColors.actionButton,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.iconeye),
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                  ),
                  errorStyle: const TextStyle(color: Colors.red),
                ),
                validator: widget.validator,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
