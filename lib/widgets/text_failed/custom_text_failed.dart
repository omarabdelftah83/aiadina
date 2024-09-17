import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    this.hintText,
    this.keyboardType,
    this.isPassword = false,
    this.obscureText = false,
    this.isSelectable = false,
    this.onChanged,
    this.prefixIcon,
    this.errorText,
    this.controller,
    this.suffixIcon,
    this.minLines = 1,
    this.maxLines = 5,
    this.height = 50.0,
  }) : super(key: key);

  final bool isPassword;
  final bool isSelectable;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final Icon? prefixIcon;
  final String? errorText;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final int minLines;
  final int maxLines;
  final double height;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: widget.isPassword ? _obscureText : widget.obscureText,
        onChanged: widget.onChanged,
        maxLines: widget.isPassword ? 1 : widget.maxLines,
        minLines: widget.isPassword ? 1 : widget.minLines,
        style: const TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon != null
              ? Padding(
            padding: const EdgeInsetsDirectional.only(start: 12.0),
            child: Icon(
              size: 40,
              widget.prefixIcon!.icon,
              color: Colors.green,
            ),
          )
              : null,
          suffixIcon: widget.suffixIcon,
          errorText: widget.errorText == null || widget.errorText!.isEmpty
              ? null
              : widget.errorText,
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.grey[100],
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: .5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(
              color: Colors.green,
              width: 2.0,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
              vertical: 15.0, horizontal: 20.0),
          alignLabelWithHint: true,
        ),
        textAlign: TextAlign.right,
      ),
    );
  }
}
