import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smart_menu/presentation/controller/login_controller.dart';
import '../../constants/colors/app_colors.dart';
import '../alert/single_txt_alert.dart';
import '../widget/common/buttons/edit_name_btn.dart';
import '../widget/info_tile.dart';
import '../widget/profile_header.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (ctrl) {
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
              ProfileHeader(
                shopName: '${ctrl.myShop.shopName}',
                onTap: () {
                  singleTxtAlert(
                      context: Get.context!,
                      hintText: 'Enter New Name ....',
                      title: 'Edit Shop Name',
                      tCtrl: ctrl.shopNameEditController,
                      formKey: ctrl.shopNameEditFormKey,
                      onTap: () {
                        ctrl.updateShopDetails('shopName');
                      });
                },
              ),
              Padding(
                padding: EdgeInsets.all(10.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoTile(title:'Phone Number',value: '${ctrl.myShop.phoneNumber}', icon:Icons.phone,
                        trailing: IconButton(
                          icon: const Icon(Icons.edit, color: Colors.black54),
                          onPressed: () {
                            singleTxtAlert(
                              context: Get.context!,
                              hintText: 'Enter Phone Number ....',
                              title: 'Edit Phone Number',
                              formKey: ctrl.shopPhoneEditFormKey,
                              tCtrl: ctrl.shopPhoneEditController,
                              usePhoneValidator: true,
                              onTap: () {
                                ctrl.updateShopDetails('phoneNumber');
                              },
                            );
                          },
                        )),
                    InfoTile(title:'Email', value:'${ctrl.myShop.email}', icon:Icons.mail,
                        trailing: IconButton(
                          icon: const Icon(Icons.edit, color: Colors.black54),
                          onPressed: () {
                            singleTxtAlert(
                              context: Get.context!,
                              hintText: 'Enter New Email ....',
                              title: 'Edit Email',
                              tCtrl: ctrl.shopEmailEditController,
                              useEmailValidator: true,
                              formKey: ctrl.shopEmailEditFormKey,
                              onTap: () {
                                ctrl.updateShopDetails('email');
                              },
                            );
                          },
                        )),
                    InfoTile(title: 'App Status',value: '${ctrl.myShop.status}',icon: Icons.info_outline),
                    InfoTile(title:'Expiry Date', value:formatDate('${ctrl.myShop.expiryDate}'), icon:Icons.date_range),
                    InfoTile(title:'Your Plan', value:'${ctrl.myShop.plan} Plan',icon: Icons.play_circle_outline_sharp),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }





  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    // Example format: "26 November 2023, 21:24"
    return DateFormat('dd MMMM yyyy, HH:mm').format(dateTime);
  }
}
