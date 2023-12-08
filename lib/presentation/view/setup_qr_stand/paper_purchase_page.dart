import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_menu/constants/colors/app_colors.dart';
import 'package:smart_menu/presentation/controller/customize_qr_stand_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class PaperPurchasePage extends StatelessWidget {

  const PaperPurchasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomizeQRStandController>(builder: (ctrl) {
      var paperItems = ctrl.purchaseItems.where((item) => item.name == 'paper').toList();
      return Scaffold(
        appBar: AppBar(
          title: const Text('Printing Instructions'),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
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
                Text(
                  'QR Code Stand Printing Guide',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.mainColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                10.verticalSpace,
                Text(
                  'Print and Prepare Your QR Code Stand',
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.grey[800],
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
                20.verticalSpace,
                Text(
                  'Please print the downloaded PDF and carefully cut out the QR code stand design. You can paste this design onto your acrylic stand. For printing, you may use regular paper or opt for sticker paper for enhanced quality and ease of application.',
                  style: TextStyle(fontSize: 18.sp),
                  textAlign: TextAlign.center,
                ),
                30.verticalSpace,
                for (int i = 0; i < paperItems.length; i++)
                  Card(
                    color: AppColors.mainColor,
                    child: ListTile(
                      leading: const Icon(Icons.shopping_cart, color: Colors.white),
                      title: Text(
                        'Sticker Paper Link ${i + 1}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      onTap: () => _launchURL(paperItems[i].link),
                    ),
                  ),
                20.verticalSpace,
              ],
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
