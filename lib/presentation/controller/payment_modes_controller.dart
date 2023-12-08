import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart' hide Response;
import '../../data/network/dio_client.dart';
import 'login_controller.dart';


class PaymentModesController extends GetxController {


  @override
  void onInit() async {

    super.onInit();
  }

  @override
  void onClose() async {
    super.onInit();
  }

  Future<void> initPaymentSheet() async {
    try {
      DioClient dioClient = Get.find<DioClient>();
      Response response = await dioClient.insertWithBody('shop/payment-sheet', {});
      final data = await response.data;

      final paymentIntent = data['paymentIntent'];
      final ephemeralKey = data['ephemeralKey'];
      final customer = data['customer'];
      final publishableKey = data['publishableKey'];


      Stripe.publishableKey = publishableKey;
      BillingDetails billingDetails =  BillingDetails(
        address: Address(
          country: 'IN',
          city: '${Get.find<LoginController>().myShop.district}',
          line1: 'addr1',
          line2: 'addr2',
          postalCode: '680681',
          state: 'kerala',
          // Other address details
        ),
        // Other billing details
      );
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          customFlow: false,
          merchantDisplayName: 'MOBIZATE',
          paymentIntentClientSecret: paymentIntent,
          customerEphemeralKeySecret: ephemeralKey,
          customerId: customer,
          style: ThemeMode.light,
          billingDetails: billingDetails,
          googlePay: const PaymentSheetGooglePay(
            merchantCountryCode: 'IN',
            currencyCode: 'inr',
            testEnv: true,
          ),
        ),
      );

      await Stripe.instance.presentPaymentSheet().then((value) {
        print('success');
      }).onError((error, stackTrace) {
        if (error is StripeException) {
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(content: Text('${error.error.localizedMessage}')),
          );
        } else {
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(content: Text('Stripe Error: $error')),
          );
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text('Error initializing payment: $e')),
      );
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }


}
