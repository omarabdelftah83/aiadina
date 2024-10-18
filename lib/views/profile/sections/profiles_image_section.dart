import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:ourhands/utils/images.dart';
import '../../../utils/colors.dart';
import '../../../services/profile_image_service.dart';
import '../../../utils/const.dart';

class ProfileImageSection extends StatefulWidget {
  final String? imagePath;
  final ValueChanged<String?> onImageChanged;

  const ProfileImageSection({Key? key, this.imagePath, required this.onImageChanged}) : super(key: key);

  @override
  _ProfileImageSectionState createState() => _ProfileImageSectionState();
}

class _ProfileImageSectionState extends State<ProfileImageSection> {
  bool _isLoading = false;
  String? _currentImagePath;

  @override
  void initState() {
    super.initState();
    // Set the initial image path
    _currentImagePath = widget.imagePath;
  }

  Future<void> _pickImage(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _isLoading = true;
      });

      final ProfileImageService profileImageService = ProfileImageService();
      String? newImagePath = await profileImageService.changeProfileImage(image.path);

      setState(() {
        _isLoading = false;
      });

      if (newImagePath != null) {
        setState(() {
          _currentImagePath = newImagePath; // تحديث مسار الصورة بالرابط الجديد
        });
        widget.onImageChanged(newImagePath);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('فشل في تغيير الصورة'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.actionButton,
              width: 1,
            ),
          ),
          child: ClipOval(
            child: _currentImagePath != null && _currentImagePath!.isNotEmpty
                ? Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                      baseUrl+  _currentImagePath!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.person_3_rounded,
                            size: 80,
                            color: AppColors.actionButton,
                          );
                        },
                      ),
                      if (_isLoading)
                        Center(
                          child: Lottie.asset(
                            AssetImages.loading,
                            fit: BoxFit.cover,
                          ),
                        ),
                    ],
                  )
                : Icon(
                    Icons.person_3_rounded,
                    size: 80,
                    color: AppColors.actionButton,
                  ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: InkWell(
            onTap: () => _pickImage(context),
            child: Icon(
              Icons.camera_alt,
              color: AppColors.actionButton,
              size: 25,
            ),
          ),
        ),
      ],
    );
  }
}
