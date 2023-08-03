import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'buttons/round_border_button.dart';

class FlexibleBtnBottomSheet {
  static void bottomSheet({
    required String b1Name,
    required String b2Name,
    String? b3Name,
    String? b4Name,
    String? b5Name,
    String? b6Name,
    required Function b1Function,
    required Function b2Function,
    Function? b3Function,
    Function? b4Function,
    Function? b5Function,
    Function? b6Function,
  }) {
    int buttonCount = 2 + (b3Name != null ? 1 : 0) + (b4Name != null ? 1 : 0) + (b5Name != null ? 1 : 0) + (b6Name != null ? 1 : 0);
    double buttonHeight = 60.h; // change this to your button's height
    double buttonSpacing = 30.h; // change this to your spacing
    double totalHeight = (buttonCount * buttonHeight) + ((buttonCount - 1) * buttonSpacing) + 100.h; // adding padding

    Get.bottomSheet(
      Container(
        height: totalHeight,
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 50.h,
        ),
        decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.r),
                topRight: Radius.circular(50.r))),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Button 1
              RoundBorderButton(
                text: b1Name,
                textColor: Colors.white,
                onTap: b1Function,
              ),
              SizedBox(height: buttonSpacing),
              // Button 2
              RoundBorderButton(
                text: b2Name,
                textColor: Colors.white,
                onTap: b2Function,
              ),
              // Check if b3Name and b3Function are not null before adding Button 3
              if (b3Name != null && b3Function != null)
                SizedBox(height: buttonSpacing),
              if (b3Name != null && b3Function != null)
                RoundBorderButton(
                  text: b3Name,
                  textColor: Colors.white,
                  onTap: b3Function,
                ),
              // Check if b4Name and b4Function are not null before adding Button 4
              if (b4Name != null && b4Function != null)
                SizedBox(height: buttonSpacing),
              if (b4Name != null && b4Function != null)
                RoundBorderButton(
                  text: b4Name,
                  textColor: Colors.white,
                  onTap: b4Function,
                ),
              // Check if b5Name and b5Function are not null before adding Button 5
              if (b5Name != null && b5Function != null)
                SizedBox(height: buttonSpacing),
              if (b5Name != null && b5Function != null)
                RoundBorderButton(
                  text: b5Name,
                  textColor: Colors.white,
                  onTap: b5Function,
                ),
              // Check if b6Name and b6Function are not null before adding Button 6
              if (b6Name != null && b6Function != null)
                SizedBox(height: buttonSpacing),
              if (b6Name != null && b6Function != null)
                RoundBorderButton(
                  text: b6Name,
                  textColor: Colors.white,
                  onTap: b6Function,
                ),
            ],
          ),
        ),
      ),
      enterBottomSheetDuration: const Duration(milliseconds: 300),
      exitBottomSheetDuration: const Duration(milliseconds: 300),
    );
  }
}
