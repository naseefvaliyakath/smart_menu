import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/colors/app_colors.dart';
import 'common/buttons/edit_name_btn.dart';

class ProfileHeader extends StatelessWidget {
  final String shopName;
  final Function onTap;

  const ProfileHeader({
    Key? key,
    required this.shopName,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.r)),
      ),
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.titleColor,
            radius: 50,
            child: ClipOval(
              child: Image.asset(
                'assets/image/user.png',
                width: 100.sp,
                height: 100.sp,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$shopName',
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              EditNameButton(onTap: () {
onTap();
              }),
            ],
          ),
        ],
      ),
    );
  }
}
