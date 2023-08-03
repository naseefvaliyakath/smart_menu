import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/colors/app_colors.dart';

class NotificationIcon extends StatelessWidget {
  final Function onTap;
  const NotificationIcon({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      splashColor: AppColors.mainColor_2,
      onTap: () {
       onTap();
      },
      child: Container(
        padding: EdgeInsets.all(8.sp),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), border: Border.all(color: Colors.grey)),
        child: Center(
          child: Badge(
            backgroundColor: Colors.red,
            child: Icon(
              Icons.notification_add_outlined,
              size: 24.sp,
            ),
          ),
        ),
      ),
    );
  }
}
