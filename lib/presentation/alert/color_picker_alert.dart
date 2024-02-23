import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_menu/constants/colors/app_colors.dart';
import 'package:smart_menu/presentation/controller/home_controller.dart';
import 'package:smart_menu/presentation/widget/common/buttons/app_rount_mini_btn.dart';
import 'package:smart_menu/presentation/widget/common/common_text/big_text.dart';

void colorPickerAlert({required BuildContext context, required Function onColorSelect, required Color initialColor}) {
  showAnimatedDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return GetBuilder<HomeController>(builder: (ctrl) {
        return AlertDialog(
          title: const Center(child: BigText(text: 'SELECT COLOR')),
          contentPadding: EdgeInsets.all(10.sp),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.sp),
          ),
          content: SizedBox(
            width: 0.9.sw,
            height: 0.7.sh,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ColorPicker(
                  color: initialColor,
                  onChanged: (value) {
                    //print(value);
                    onColorSelect(value);
                  },
                ),
              ],
            ),
          ),
        );
      });
    },
    animationType: DialogTransitionType.scale,
    curve: Curves.fastOutSlowIn,
    duration: const Duration(milliseconds: 900),
  );
}
