

import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../widgets/alert_dialog.dart';
import '../../../widgets/app_text/AppText.dart';

class LogOutSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomText(
          text: 'تسجيل الخروج',
          textColor: AppColors.redColor,
        ),
        IconButton(
          onPressed: () {
            logOutDialog(context);
          },
          icon: Icon(Icons.logout, color: AppColors.redColor),
        ),
      ],
    );
  }
}
