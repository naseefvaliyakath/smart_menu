import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_menu/constants/colors/app_colors.dart';
import 'package:smart_menu/presentation/controller/customize_qr_stand_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class FinalizeQrStandPage extends StatelessWidget {

  const FinalizeQrStandPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomizeQRStandController>(builder: (ctrl) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Finalize QR Stand'),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0), // Adjust the radius for desired roundness
                      child: Image.asset('assets/image/my-qr-stand.png', height: 200.h),
                    ),
                  ),
                  20.verticalSpace,
                  Center(
                    child: Text(
                      'Put QR Code In Stand',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.mainColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  10.verticalSpace,
                  Text(
                    'Just insert the printed QR code in side the stand ',
                    textAlign:TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.grey[800],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  20.verticalSpace,
                  Text(
                    'Now you are all set! Place the stand on your table to give your hotel or restaurant a more professional look. You can change your menu, prices, items, etc., anytime from admin app, and customers can see the updates immediately when they scan the QR codes.',
                    textAlign:TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
