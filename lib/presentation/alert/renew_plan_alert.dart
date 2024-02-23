import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_menu/presentation/alert/update_notice_alert.dart';
import '../../core/routes/app_pages.dart';

checkAndRenewPlanAlert(String message) {
  if (message == 'Shop subscription has expired or deactivated.') {
    showNoticeUpdateAlert(
        message: 'Your plan has deactivated \n click to renew plan',
        context: Get.context!,
        onTap: () {
          Navigator.pop(Get.context!);
          Get.toNamed(AppPages.PAYMENT_MODE_PAGE);
        },
        type: 'notice',
        forced: false);
    return;
  }
}
