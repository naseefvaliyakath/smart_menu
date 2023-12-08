import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pay/pay.dart';
import 'package:smart_menu/constants/colors/app_colors.dart';
import 'package:smart_menu/presentation/controller/payment_modes_controller.dart';

import '../../payment_configurations.dart';
import '../widget/common/buttons/round_border_button.dart';
import '../widget/common/buttons/stripe_btn.dart';
import '../widget/common/common_text/big_text.dart';

class PaymentModesPage extends StatelessWidget {
  const PaymentModesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentModesController>(builder: (ctrl) {
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
                            width: 100.w,
                            child: Image.asset(
                              'assets/image/silver.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          10.verticalSpace,
                          Text(
                            'Silver Plan',
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.mainColor,
                            ),
                          ),
                          10.verticalSpace,
                          Text(
                            'Rs 1999',
                            style: TextStyle(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            'Unlock premium features with the Silver Plan, including unlimited access, ad-free experience, exclusive content, and more!',
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

                  // Payment Buttons
                  StripePaymentButton(
                    onTap: () => ctrl.initPaymentSheet(),
                  ),
                  SizedBox(height: 15.h),
                  if (Platform.isAndroid) ...[
                    GooglePayButton(
                      paymentConfiguration: PaymentConfiguration.fromJsonString(defaultGooglePay),
                      paymentItems: const [
                        PaymentItem(
                          label: 'Total',
                          amount: '199',
                          status: PaymentItemStatus.final_price,
                        )
                      ],
                      type: GooglePayButtonType.pay,
                      margin: const EdgeInsets.only(top: 15.0),
                      onPaymentResult: (result) => debugPrint('Payment Result $result'),
                      loadingIndicator: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
