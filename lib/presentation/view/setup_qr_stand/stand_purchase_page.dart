import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_menu/constants/colors/app_colors.dart';
import 'package:smart_menu/presentation/controller/customize_qr_stand_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class StandPurchasePage extends StatelessWidget {
  const StandPurchasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomizeQRStandController>(builder: (ctrl) {
      // Filter the items to only include those with name 'stand'
      var standItems = ctrl.purchaseItems.where((item) => item.name == 'stand').toList();

      return Scaffold(
        appBar: AppBar(
          title: const Text('Purchase Instructions'),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset('assets/image/acrlic_stant_purchase.jpeg', height: 200.h),
                ),
                20.verticalSpace,
                Text(
                  'Acrylic Stand Purchase Guide',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.mainColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                10.verticalSpace,
                Text(
                  'Size: A6 or 4x6 inches',
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.grey[800],
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
                20.verticalSpace,
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 18.sp, // Make sure to import 'package:flutter_screenutil/flutter_screenutil.dart' for .sp to work
                      color: Colors.black, // Default text color
                    ),
                    children: [
                      TextSpan(
                        text: 'You need to purchase ',
                      ),
                      TextSpan(
                        text: 'A6 or 4x6 inches Acrylic Table Stand',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      TextSpan(
                        text: ' , You can purchase from below link or local stores',
                      ),
                    ],
                  ),
                ),
                30.verticalSpace,
                // Displaying each filtered item as a Card
                for (var entry in standItems.asMap().entries)
                  Card(
                    color: AppColors.mainColor,
                    child: ListTile(
                      leading: const Icon(Icons.shopping_cart, color: Colors.white),
                      title: Text(
                        'Purchase Link ${entry.key + 1}', // Incrementing the key for display
                        style: const TextStyle(color: Colors.white),
                      ),
                      onTap: () => _launchURL(entry.value.link),
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
