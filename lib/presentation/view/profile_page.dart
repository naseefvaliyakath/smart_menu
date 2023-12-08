import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smart_menu/presentation/controller/login_controller.dart';
import '../../constants/colors/app_colors.dart';

class ProfilePage extends StatelessWidget {
  final LoginController ctrl = Get.find<LoginController>();

  ProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(fontSize: 24.sp, color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: AppColors.mainColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _headerSection(),
            _infoSection(),
          ],
        ),
      ),
    );
  }

  Widget _headerSection() {
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
          Text(
            '${ctrl.myShop.shopName}',
            style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _infoSection() {
    return Padding(
      padding: EdgeInsets.all(20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _infoTile('Phone Number', '${ctrl.myShop.phoneNumber}', Icons.phone),
          _infoTile('App Status', '${ctrl.myShop.status}', Icons.info_outline),
          _infoTile('Expiry Date', formatDate('${ctrl.myShop.expiryDate}'), Icons.date_range),
          _infoTile('Your Plan', '${ctrl.myShop.plan} Plan', Icons.play_circle_outline_sharp),
        ],
      ),
    );
  }

  Widget _infoTile(String title, String value, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueGrey),
      title: Text(title, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500)),
      subtitle: Text(
        value,
        style: TextStyle(fontSize: 16.sp, color: Colors.grey.shade600),
      ),
    );
  }

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    // Example format: "26 November 2023, 21:24"
    return DateFormat('dd MMMM yyyy, HH:mm').format(dateTime);
  }
}
