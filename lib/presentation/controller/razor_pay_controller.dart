import 'dart:developer';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:smart_menu/data/model/shop/shop.dart';
import 'package:smart_menu/domain/repository/network/contract/payment_repository.dart';
import 'package:smart_menu/domain/repository/network/contract/plan_repository.dart';
import 'package:smart_menu/presentation/controller/login_controller.dart';
import '../../data/model/api_response/api_response.dart';
import '../../data/model/payment_order_razor_pay/payment_order_razor_pay.dart';
import '../../data/model/plan/plan.dart';
import '../../data/model/plan_payment_response/plan_payment_response.dart';
import '../../data/network/handle_error.dart';
import '../../data/network/report_error.dart';
import '../widget/snack_bar.dart';

class RazorPayController extends GetxController {
  PaymentRepository paymentRepository = Get.find<PaymentRepository>();
  PlanRepository planRepository = Get.find<PlanRepository>();
  bool paymentSuccess = false;
  bool paymentFailed = false;
  late Razorpay _razorpay;

  //? Category to show in UI
  final List<Plan> _myPlan = [];

  List<Plan> get myPlan => _myPlan;
  Shop myShop = Get.find<LoginController>().myShop;

  @override
  void onInit() {
    _razorpay = Razorpay();
    getAllPlans();
    super.onInit();
  }

  getAllPlans() async {
    try {
      ApiResponse<List<Plan>>? apiResponse = await planRepository.getAllPlans();
      if (apiResponse != null) {
        if (apiResponse.error) {
          AppSnackBar.errorSnackBar('Error', apiResponse.message);
          return false;
        } else {
          _myPlan.clear();
          _myPlan.addAll(apiResponse.data ?? []);
          return true;
        }
      } else {
        AppSnackBar.errorSnackBar('Error', 'Something went to  wrong !');
        return false;
      }
    } catch (e) {
      ErrorHandler.handleError(e, isDioError: false, page: 'razor_pay_controller', method: 'getAllPlans');
      return;
    } finally {
      update();
    }
  }

  void openCheckout(Plan plan) async {
    try {
      String currency = 'INR';
      ApiResponse<PaymentOrderRazorPay>? orderRazorPayResponse = await createOrder(plan, currency);
      if (orderRazorPayResponse == null) {
        AppSnackBar.errorSnackBar('Error', 'Something went wrong');
        return;
      } else {
        if (orderRazorPayResponse.error) {
          AppSnackBar.errorSnackBar('Error', orderRazorPayResponse.message);
          return;
        } else {
          PaymentOrderRazorPay? order = orderRazorPayResponse.data;
          if (order != null && order.status == 'created') {
            var options = {
              'key': order.key,
              'amount': order.amount,
              'name': plan.planName,
              "currency": order.currency,
              "order_id": order.id,
              'description': plan.description,
              'send_sms_hash': true,
              "prefill": {
                "email": Get.find<LoginController>().myShop.email,
                "contact": Get.find<LoginController>().myShop.phoneNumber
              },
              "theme": {'color': '#FFC107'},
              "image": 'https://store.rapidflutter.com/digitalAssetUpload/rapidlogo.png',
            };
            _razorpay.open(options);
            _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
            _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
          }
        }
      }
    } catch (e) {
      AppSnackBar.errorSnackBar('Error', e.toString());
      ErrorReporting.reportError(errorMessage: e.toString(), method: 'openCheckout', page: 'razorpay_controller');
      return;
    }
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    try {
      if (paymentSuccess == false) {
        paymentSuccess = true;
        log('Success Response: $response');
        checkTransactionIsSuccess(
            email: myShop.email ?? '', itemId: _myPlan.first.planId ?? 0, transactionId: response.paymentId ?? '');
        //? AppSnackBar.successSnackBar('Success', 'SUCCESS: ${response.paymentId!}');
      }
    } catch (e) {
      ErrorReporting.reportError(
          errorMessage: e.toString(), method: '_handlePaymentSuccess', page: 'razorpay_controller');
      return;
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    try {
      if (paymentFailed == false) {
        paymentFailed = true;
        log('Error Response: $response');
        AppSnackBar.errorSnackBar('Error', 'ERROR: ${response.code} - ${response.message!}');
      }
    } catch (e) {
      ErrorReporting.reportError(
          errorMessage: e.toString(), method: '_handlePaymentError', page: 'razorpay_controller');
      return;
    }
  }

  Future<ApiResponse<PaymentOrderRazorPay>?> createOrder(Plan plan, String currency) async {
    try {
      ApiResponse<PaymentOrderRazorPay>? apiResponse = await paymentRepository.createOrder(plan, currency);

      if (apiResponse != null) {
        if (apiResponse.error) {
          AppSnackBar.errorSnackBar('Error', apiResponse.message);
        } else {
          return apiResponse;
          //? AppSnackBar.successSnackBar('Success', apiResponse.message);
        }
      } else {
        AppSnackBar.errorSnackBar('Errors', 'Something went to  wrong !');
      }
    } catch (e) {
      AppSnackBar.errorSnackBar('Error', e.toString());
      ErrorReporting.reportError(errorMessage: e.toString(), method: 'createOrder', page: 'razorpay_controller');
      return null;
    }
    return null;
  }

  Future<ApiResponse<PlanPaymentResponse>?> checkTransactionIsSuccess(
      {required String email, required int itemId, required String transactionId}) async {
    try {
      Map<String, dynamic> body = {
        'email': email,
        'itemID': itemId,
        'PaymentID': transactionId,
        'shopId': myShop.shopId
      };
      ApiResponse<PlanPaymentResponse>? apiResponse = await paymentRepository.checkTransactionIsSuccess(body);
      if (apiResponse != null) {
        if (apiResponse.error) {
          AppSnackBar.errorSnackBar('Error', apiResponse.message);
        } else {
          AppSnackBar.successSnackBar('Success', apiResponse.message);
          doThePlanRenewThinks();
        }
      } else {
        AppSnackBar.errorSnackBar('Error', 'Something went to  wrong !');
      }
    } catch (e) {
      AppSnackBar.errorSnackBar('Error', e.toString());
      ErrorReporting.reportError(errorMessage: e.toString(), method: 'checkTransactionIsSuccess', page: 'razorpay_controller');
      return null;
    }
    return null;
  }

  doThePlanRenewThinks() async {
    await Get.find<LoginController>().updateShopInfoEveryTime();
    //? update shop
    myShop = Get.find<LoginController>().myShop;
    checkAppIsExpired();
    update();
  }

  bool checkAppIsExpired() {
    return (daysUntilExpiry(myShop.expiryDate ?? DateTime.now().toString())) == 0;
  }

  int daysUntilExpiry(String dateString) {
    DateTime serverDate = DateTime.parse(dateString);
    DateTime currentDate = DateTime.now().toUtc();

    // Calculate the difference in days
    int difference = serverDate.difference(currentDate).inDays;

    // Check if the date is already expired
    if (difference < 0) {
      return 0; // Expired
    } else {
      return difference; // Days remaining
    }
  }
}
