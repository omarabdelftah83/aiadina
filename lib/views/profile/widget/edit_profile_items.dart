import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileTextFieldAndLabel extends StatefulWidget {
  final String? label;
  final String? text;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? customIcon; // خاصية جديدة لتلقي الأيقونة المخصصة
  final Widget? suffixIcon;
  final bool isPassword;
  final bool isSelectable;
  final Icon? prefixIcon;
  final String? errorText;
  final String? hintText;
  final bool obscureText;

  const EditProfileTextFieldAndLabel({
    super.key,
    this.label,
    this.controller,
    this.keyboardType,
    this.text,
    this.customIcon,
    this.suffixIcon,
    this.isPassword = false,
    this.isSelectable = false,
    this.prefixIcon,
    this.errorText,
    this.hintText,
    this.obscureText = false,
  });

  @override
  _EditProfileTextFieldAndLabelState createState() =>
      _EditProfileTextFieldAndLabelState();
}

class _EditProfileTextFieldAndLabelState
    extends State<EditProfileTextFieldAndLabel> {
  bool _isEditing = false;
  late TextEditingController _localController;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;

    _localController =
        widget.controller ?? TextEditingController(text: widget.text ?? '');
  }

  void _toggleEdit() {
    setState(() {
      if (_isEditing) {
        // Update _currentText with the value from the controller when exiting edit mode
        widget.controller?.text = _localController.text;
      }
      _isEditing = !_isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        _toggleEdit(); // Toggle edit mode
                      },
                      icon: Icon(
                        _isEditing ? Icons.check : Icons.edit_sharp,
                        color: _isEditing ? Colors.green : Colors.black54,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      widget.label ?? '',
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: widget.customIcon ??
                          const Icon(Icons.phone_android, color: Colors.green),
                    ),
                  ],
                ),
                _isEditing
                    ? TextFormField(
                        controller: _localController,
                        keyboardType: widget.keyboardType,
                        obscureText: widget.isPassword ? _obscureText : false,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 12.h),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: widget.isPassword
                              ? IconButton(
                                  icon: Icon(
                                    _obscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                )
                              : widget.prefixIcon,
                          suffixIcon: widget.suffixIcon,
                          errorText: widget.errorText == null ||
                                  widget.errorText!.isEmpty
                              ? null
                              : widget.errorText,
                          hintText: widget.hintText,
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          alignLabelWithHint: true,
                        ),
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: Text(
                                  _obscureText
                                      ? '' * _localController.text.length : '',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
