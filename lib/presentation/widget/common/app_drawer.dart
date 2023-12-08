import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smart_menu/core/routes/app_pages.dart';
import 'package:smart_menu/presentation/view/profile_page.dart';
import '../../../constants/colors/app_colors.dart';
import '../../view/startup_video_tutorial.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              'Hello...',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.sp,
              ),
            ),
            accountEmail: Text(
              'Welcome',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: AppColors.titleColor,
              child: ClipOval(
                child: Image.asset(
                  'assets/image/user.png',
                  width: 80.sp,
                  height: 80.sp,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: const BoxDecoration(color: AppColors.textGrey),
          ),
          ListTile(
            leading: Icon(Icons.home, size: 20.sp),
            title: Text('Home', style: TextStyle(fontSize: 16.sp)),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.person, size: 20.sp),
            title: Text('Profile', style: TextStyle(fontSize: 16.sp)),
            onTap: () {
              Navigator.pop(context);
              Get.to(ProfilePage());
            },
          ),
          ListTile(
            leading: Icon(Icons.contact_support, size: 20.sp),
            title: Text('Contact Us', style: TextStyle(fontSize: 16.sp)),
            onTap: () {
              Navigator.pop(context);
            },
          ),

          ListTile(
            leading: Icon(Icons.price_change_rounded, size: 20.sp),
            title: Text('Pricing', style: TextStyle(fontSize: 16.sp)),
            onTap: () {
              Navigator.pop(context);
              Get.toNamed(AppPages.PAYMENT_MODE_PAGE);

            },
          ),
        ],
      ),
    );
  }
}
