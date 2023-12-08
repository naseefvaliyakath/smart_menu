import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:smart_menu/constants/colors/app_colors.dart';

class ProfileMenuWithToggle extends StatelessWidget {
  const ProfileMenuWithToggle({
    Key? key,
    required this.text,
    required this.icon,
    required this.press,
    required this.onToggle,
    required this.subtitle,
    required this.toggleSts,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final Function press;
  final Function(bool) onToggle;
  final String subtitle;
  final bool toggleSts;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.black54,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
          backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: () {
          press();
        },
        child: Row(
          children: [
            Icon(icon, size: 24.sp,),
            SizedBox(width: 20.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(text, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                  5.verticalSpace,
                  Text(subtitle, style: TextStyle(fontSize: 8.sp, color: Colors.grey)),
                ],
              ),
            ),
            Switch(
              activeTrackColor: AppColors.mainColor,
              value: toggleSts,
              onChanged: (value) {
                print(value);
                onToggle(value);
              },
            )
          ],
        ),
      ),
    );
  }
}
