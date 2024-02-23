import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../alert/color_picker_alert.dart';

class ColorCard extends StatelessWidget {
  final Color onColorSelection;
  final String text;
  final Function onColorSect;

  const ColorCard({Key? key, required this.onColorSelection, required this.text, required this.onColorSect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric( vertical: 10.h),
      child: GestureDetector(
        onTap: () {
          colorPickerAlert(context: context,onColorSelect: (val){
            onColorSect(val);
          }, initialColor: onColorSelection);
        },
        child: Container(
          decoration: BoxDecoration(
            color: onColorSelection,
            borderRadius: BorderRadius.circular(15.r),
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                text,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Text(
                'Click to change',
                style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
