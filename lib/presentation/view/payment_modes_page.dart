import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_menu/constants/colors/app_colors.dart';
import 'package:smart_menu/presentation/controller/payment_modes_controller.dart';
import 'package:smart_menu/presentation/controller/razor_pay_controller.dart';
import '../widget/common/buttons/razorpay_btn.dart';
import '../widget/common/buttons/stripe_btn.dart';
import '../widget/common/common_text/big_text.dart';
import '../widget/common/plan_expard_message_txt.dart';

class PaymentModesPage extends StatelessWidget {
  const PaymentModesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RazorPayController>(builder: (ctrl) {
      return Scaffold(
        appBar: AppBar(
          title: const BigText(text: 'Upgrade Plan', color: Colors.black),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: Column(
                children: [
                  // Plan Card
                  Card(
                    elevation: 4,
                    shadowColor: Colors.deepPurple,
                    surfaceTintColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 100.h,
                            width: double.maxFinite,
                            child: Image.network(
                              ctrl.myPlan.isNotEmpty
                                  ? '${ctrl.myPlan.first.imgLink}'
                                  : 'https://mobizate.com/assetsUpload/place_holder.jpeg',
                              fit: BoxFit.contain,
                            ),
                          ),
                          10.verticalSpace,
                          Text(
                            ctrl.myPlan.isNotEmpty ? (ctrl.myPlan.first.planName ?? '') : '',
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.mainColor,
                            ),
                          ),
                          10.verticalSpace,
                          Text(
                            ctrl.myPlan.isNotEmpty ? ('Rs : ${ctrl.myPlan.first.price}' ?? '') : '',
                            style: TextStyle(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            ctrl.myPlan.isNotEmpty
                                ? ('VALIDITY : ${ctrl.myPlan.first.durationMonths} MONTH' ?? '')
                                : '',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.green,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            ctrl.myPlan.isNotEmpty ? (ctrl.myPlan.first.description ?? '') : '',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  PlanExpiredMessage(
                    expiryFate: ctrl.myShop.expiryDate,
                    planName: ctrl.myShop.plan,
                    visible: !ctrl.checkAppIsExpired(),
                  ),
                  // Payment Buttons
                  RazorPayPaymentButton(
                    disabled: !ctrl.checkAppIsExpired(),
                    onTap: () => ctrl.openCheckout(ctrl.myPlan.first),
                    // onTap: () => ctrl.checkTransactionIsSuccess(email: 'naseefvs1@gmail.com', itemId: 3, transactionId: 'pay_NdL6773ot5L2m3'),
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
