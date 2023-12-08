import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'package:smart_menu/core/routes/app_pages.dart';
import 'package:smart_menu/presentation/view/setup_qr_stand/paper_purchase_page.dart';
import 'package:smart_menu/presentation/view/setup_qr_stand/stand_purchase_page.dart';
import 'package:smart_menu/presentation/widget/common/common_text/big_text.dart';
import '../../widget/common/image_tile.dart';



class StepsForQrStand extends StatelessWidget {
  final ScreenshotController screenshotController = ScreenshotController();

  StepsForQrStand({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const BigText(text: 'Make QR Code Stand', color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            ImageTile(
              index: '1',
              imageUrl: 'assets/image/qr_code.png',
              title: 'Design QR Code Design',
              subtitle: 'Click to create your QR Code design',
              onTap: () {
                Get.toNamed(AppPages.CUSTOMIZE_QR_STAND_PAGE);
              },
            ),
            ImageTile(
              index: '2',
              imageUrl: 'assets/image/acrilic_stand.png',
              title: 'Buy Table Stand',
              subtitle: 'Click to find QR Table stand purchase link',
              onTap: () {
                Get.toNamed(AppPages.STAND_PURCHASE_PAGE);
              },
            ),
            ImageTile(
              index: '3',
              imageUrl: 'assets/image/qr-stand.png',
              title: 'Past your QR Code Design In Stand',
              subtitle: 'Click to learn how to print and past design',
              onTap: () {
                Get.toNamed(AppPages.PAPER_PURCHASE_PAGE);
              },
            ),
          ],
        ),
      ),
    );
  }


}
