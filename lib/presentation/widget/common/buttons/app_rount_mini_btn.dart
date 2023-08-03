import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppRoundMiniBtn extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color color;

  const AppRoundMiniBtn({
    Key? key,
    required this.onTap,
    required this.text, required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 24.sp),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 15.sp,color: Colors.white),
      ),
    );
  }
}
