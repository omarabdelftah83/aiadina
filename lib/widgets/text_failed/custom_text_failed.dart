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
    this.minLines = 1, // Minimum lines
    this.maxLines = 5, // Maximum lines
    this.height = 50.0, // Default height for the TextField
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
  final double height; // New height property

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
      height: widget.height, // Set the height of the TextField
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: widget.isPassword ? _obscureText : widget.obscureText,
        onChanged: widget.onChanged,
        maxLines: widget.isPassword ? 1 : widget.maxLines,
        minLines: widget.isPassword ? 1 : widget.minLines,
        decoration: InputDecoration(
          prefixIcon: widget.isPassword
              ? IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          )
              : widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          errorText: widget.errorText == null || widget.errorText!.isEmpty
              ? null
              : widget.errorText,
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          contentPadding: const EdgeInsets.symmetric(
              vertical: 15.0, horizontal: 20.0), // Adjust padding
          alignLabelWithHint: true,
        ),
        textAlign: TextAlign.right, // Align text and hint text to the right
      ),
    );
  }
}
