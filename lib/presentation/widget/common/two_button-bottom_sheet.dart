import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'buttons/round_border_button.dart';  // Make sure this import is correctly pointing to your RoundBorderButton widget

class FlexibleBtnBottomSheet {
  static void bottomSheet({
    required String b1Name,
    required String b2Name,
    String? b3Name,
    String? b4Name,
    String? b5Name,
    String? b6Name,
    String? b7Name, // Added b7Name parameter
    required Function b1Function,
    required Function b2Function,
    Function? b3Function,
    Function? b4Function,
    Function? b5Function,
    Function? b6Function,
    Function? b7Function, // Added b7Function parameter
  }) {
    int buttonCount = 2 + (b3Name != null ? 1 : 0) + (b4Name != null ? 1 : 0) + (b5Name != null ? 1 : 0) + (b6Name != null ? 1 : 0) + (b7Name != null ? 1 : 0); // Updated button count
    double buttonHeight = 60.h;
    double buttonSpacing = 30.h;
    double totalHeight = (buttonCount * buttonHeight) + ((buttonCount - 1) * buttonSpacing) + 100.h;

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
              if (b3Name != null && b3Function != null)
                SizedBox(height: buttonSpacing),
              if (b3Name != null && b3Function != null)
                RoundBorderButton(
                  text: b3Name,
                  textColor: Colors.white,
                  onTap: b3Function,
                ),
              if (b4Name != null && b4Function != null)
                SizedBox(height: buttonSpacing),
              if (b4Name != null && b4Function != null)
                RoundBorderButton(
                  text: b4Name,
                  textColor: Colors.white,
                  onTap: b4Function,
                ),
              if (b5Name != null && b5Function != null)
                SizedBox(height: buttonSpacing),
              if (b5Name != null && b5Function != null)
                RoundBorderButton(
                  text: b5Name,
                  textColor: Colors.white,
                  onTap: b5Function,
                ),
              if (b6Name != null && b6Function != null)
                SizedBox(height: buttonSpacing),
              if (b6Name != null && b6Function != null)
                RoundBorderButton(
                  text: b6Name,
                  textColor: Colors.white,
                  onTap: b6Function,
                ),
              // Added Button 7
              if (b7Name != null && b7Function != null)
                SizedBox(height: buttonSpacing),
              if (b7Name != null && b7Function != null)
                RoundBorderButton(
                  text: b7Name,
                  textColor: Colors.white,
                  onTap: b7Function,
                ),
            ],
          ),
        ),
      ),
      enterBottomSheetDuration: const Duration(milliseconds: 500),
      exitBottomSheetDuration: const Duration(milliseconds: 500),
    );
  }
}
