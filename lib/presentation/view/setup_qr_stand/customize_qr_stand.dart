import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:smart_menu/constants/colors/app_colors.dart';
import 'package:smart_menu/presentation/widget/common/buttons/app_rount_mini_btn.dart';
import 'package:smart_menu/presentation/widget/common/common_text/big_text.dart';
import 'package:smart_menu/presentation/widget/common/common_text/mid_text.dart';
import '../../alert/single_txt_alert.dart';
import '../../controller/customize_qr_stand_controller.dart';

class CustomizeQRStandCard extends StatelessWidget {

  const CustomizeQRStandCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomizeQRStandController>(builder: (ctrl) {
      return Scaffold(
        appBar: AppBar(
          title: const BigText(text: 'Setup QR Code Stand', color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 0.9.sw,
                    height: 0.7.sh,
                    child: Card(
                      elevation: 5,
                      surfaceTintColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(
                            color: ctrl.isBorderVisible ? Colors.black : Colors.grey,
                            width: ctrl.isBorderVisible ? 2 : 1,
                          )),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Logo and Choose Logo Button
                              CircleAvatar(
                                backgroundImage: ctrl.logoImage != null
                                    ? FileImage(File(ctrl.logoImage!.path))
                                    : const AssetImage('assets/image/food_logo.png') as ImageProvider,
                                radius: 60,
                              ),
                              Visibility(
                                visible: !ctrl.isPreviewMode,
                                child: TextButton(
                                  onPressed: () => ctrl.pickLogoImage(),
                                  child: const Text('Choose Logo'),
                                ),
                              ),
                              // Restaurant Name and Edit Icon
                              Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20), // Adjust the padding to position the text
                                    child: BigText(text: ctrl.restaurantName, color: Colors.black),
                                  ),
                                  Positioned(
                                    bottom: -15,
                                    child: TextButton(
                                      onPressed: () {
                                        singleTxtAlert(
                                            context: context,
                                            hintText: 'Enter Shop Name',
                                            title: 'Shop Name',
                                            tCtrl: ctrl.shopNameCtrl,
                                            onTap: () {
                                              ctrl.changeRestaurantName();
                                              Get.back();
                                            });
                                      },
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                      ),
                                      child: Visibility(
                                        visible: !ctrl.isPreviewMode,
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.edit, size: 16),
                                            Text('Edit', style: TextStyle(fontSize: 14)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              // QR Code
                              QrImageView(
                                data: 'hello',
                                version: QrVersions.auto,
                                size: 250,
                                gapless: false,
                              ),
                              ctrl.isPreviewMode ? 20.verticalSpace : 0.verticalSpace,
                              Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: BigText(text: ctrl.scanMeText, color: Colors.red),
                                  ),
                                  Positioned(
                                    bottom: -15, // Adjust this value as needed
                                    child: TextButton(
                                      onPressed: () {
                                        singleTxtAlert(
                                            context: context,
                                            hintText: 'Enter Text ... ',
                                            title: 'Scanning Text',
                                            tCtrl: ctrl.scanTextCtrl,
                                            onTap: () {
                                              ctrl.changeScanMeText();
                                              Get.back();
                                            });
                                      },
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                      ),
                                      child: Visibility(
                                        visible: !ctrl.isPreviewMode,
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.edit, size: 16),
                                            Text('Edit', style: TextStyle(fontSize: 14)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Buttons
                  20.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AppRoundMiniBtn(onTap: () {
                        ctrl.toggleBorder();
                      }, text: 'Border  ', color: AppColors.mainColor),
                      AppRoundMiniBtn(onTap: () {ctrl.togglePreviewMode();}, text: 'Preview ', color: AppColors.mainColor),
                      AppRoundMiniBtn(onTap: () {ctrl.generatePdf(); }, text: 'Download', color: AppColors.mainColor),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
