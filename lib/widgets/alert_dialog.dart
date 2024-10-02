import 'package:flutter/material.dart';
import 'package:ourhands/utils/colors.dart';
import 'package:ourhands/utils/dimensions.dart';
import 'package:ourhands/utils/font_styles.dart';
import 'package:ourhands/utils/images.dart';
import 'package:ourhands/widgets/custom/custom_button.dart';
import '../utils/strings.dart';

void showCustomDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        child: Container(
          height: 260,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: ModalRoute.of(context)!.animation!,
                curve: Curves.easeOut,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AssetImages.alert), 
                const SizedBox(height: 20),
                FittedBox(
                  child: Text(
                    Strings.alerText, 
                    style: FontStyles.font16WeightBoldText,
                    textAlign: TextAlign.center,
                  ),
                ),
               
              ],
            ),
          ),
        ),
      );
    },
  );
}


void logOutDialog(BuildContext context) {
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
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: ModalRoute.of(context)!.animation!,
                curve: Curves.easeOut,
              ),
            ),
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
                  textDirection:TextDirection.rtl ,
                  child: Padding(
                    padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                    child: Row(
                      children: [
                        Expanded(child: CustomButton(text: Strings.cancel, onTap: () => Navigator.pop(context),)),
                      const SizedBox(width: Dimensions.paddingSizeSmall),  
                              Expanded(child: CustomButton(
                                borderColor: 
                                AppColors.redColor,
                                 showBorder: true,
                                 color: Colors.white,
                                 textStyle: FontStyles.font18Weightred,
                                text: Strings.logOut, onTap: () => Navigator.pop(context),))
                    
                      ],
                    ),
                  ),
                )
               
              ],
            ),
          ),
        ),
      );
    },
  );
}