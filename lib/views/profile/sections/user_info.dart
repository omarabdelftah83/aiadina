import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/update_data_user.dart';

class UserInfoSection extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final String userId;

  UserInfoSection({
    required this.nameController,
    required this.phoneController,
    required this.emailController,
    required this.userId,
  });

  @override
  _UserInfoSectionState createState() => _UserInfoSectionState();
}

class _UserInfoSectionState extends State<UserInfoSection> {
  String? _selectedField;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _saveProfileChanges() async {
    if (_formKey.currentState!.validate()) {
      String? name = _selectedField == 'name' ? widget.nameController.text : null;
      String? phone = _selectedField == 'phone' ? widget.phoneController.text : null;
      String? email = _selectedField == 'email' ? widget.emailController.text : null;

      bool success = await UserService().updateUser(
        userId: widget.userId,
        name: name!,
        phone: phone!,
        email: email!,
      );

      if (success) {
        Get.snackbar('Success', 'Profile updated successfully!', snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('Error', 'Failed to update profile.', snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          DropdownButtonFormField<String>(
            value: _selectedField,
            items: [
              DropdownMenuItem(value: 'name', child: Text('Change Name')),
              DropdownMenuItem(value: 'phone', child: Text('Change Phone')),
              DropdownMenuItem(value: 'email', child: Text('Change Email')),
            ],
            onChanged: (String? value) {
              setState(() {
                _selectedField = value;
              });
            },
          ),
          if (_selectedField != null)
            TextFormField(
              controller: _selectedField == 'name'
                  ? widget.nameController
                  : _selectedField == 'phone'
                  ? widget.phoneController
                  : widget.emailController,
              decoration: InputDecoration(labelText: _selectedField == 'name' ? 'Name' : _selectedField == 'phone' ? 'Phone' : 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a value';
                }
                return null;
              },
            ),
          ElevatedButton(
            onPressed: _selectedField != null ? _saveProfileChanges : null,
            child: Text('Save Changes'),
          ),
        ],
      ),
    );
  }
}