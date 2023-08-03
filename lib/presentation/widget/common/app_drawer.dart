import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/colors/app_colors.dart';


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

            },
          ),
          ListTile(
            leading: Icon(Icons.add_business_rounded, size: 20.sp),
            title: Text('Products', style: TextStyle(fontSize: 16.sp)),
            onTap: () {
              Navigator.pop(context);

            },
          ),

        ],
      ),
    );
  }
}
