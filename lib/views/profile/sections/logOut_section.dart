import 'package:ourhands/widgets/custom/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:ourhands/utils/colors.dart';
import 'package:ourhands/utils/dimensions.dart';
import '../../../Bindings/service_locator.dart';
import '../../../utils/font_styles.dart';
import '../../../utils/strings.dart';
import '../../../controllers/auth_conntroller/login_screen_controller.dart';
import '../../../widgets/app_text/AppText.dart';

class LogOutSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  final LoginController loginController = getIt<LoginController>();

    return InkWell(
      onTap: () {
        logOutDialog(context, loginController);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomText(
            text: 'تسجيل الخروج',
            textColor: AppColors.redColor,
          ),
          IconButton(
            onPressed: () {
              logOutDialog(context, loginController);
            },
            icon: Icon(Icons.logout, color: AppColors.redColor),
          ),
        ],
      ),
    );
  }
}

void logOutDialog(BuildContext context, LoginController loginController) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        child: Container(
          height: 200,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Strings.logOut,
                style: FontStyles.font18Weight500Action,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                Strings.confirmLogOut,
                style: FontStyles.font16Weight400Text,
                textAlign: TextAlign.center,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: Strings.cancel,
                          onTap: () => Navigator.pop(context),
                        ),
                      ),
                      const SizedBox(width: Dimensions.paddingSizeSmall),
                      Expanded(
                        child: CustomButton(
                          borderColor: AppColors.redColor,
                          showBorder: true,
                          color: Colors.white,
                          textStyle: FontStyles.font18Weightred,
                          text: Strings.logOut,
                          onTap: () async {
                            Navigator.pop(context); // Close the dialog first
                            await loginController.logOut(); // Call the logOut method
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
