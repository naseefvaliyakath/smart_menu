import 'package:get/get.dart';
import 'package:smart_menu/domain/repository/network/contract/payment_repository.dart';
import 'package:smart_menu/presentation/controller/login_controller.dart';
import '../../../../data/model/api_response/api_response.dart';
import '../../../../data/model/payment_order_razor_pay/payment_order_razor_pay.dart';
import '../../../../data/model/plan/plan.dart';
import '../../../../data/model/plan_payment_response/plan_payment_response.dart';
import '../../../../data/network/dio_client.dart';
import '../../../../data/network/handle_error.dart';


class PaymentRepositoryImpl implements PaymentRepository {
  final DioClient _dioClient;

  PaymentRepositoryImpl(this._dioClient);

  String getShopId() {
    return Get.find<LoginController>().myShop.shopId.toString();
  }


  @override
  Future<ApiResponse<PaymentOrderRazorPay>?> createOrder(Plan plan, String currency) async {
    try {
      Map<String, dynamic> body = {"planId": plan.planId, "currency": currency , 'shopId':getShopId()};
      final response = await _dioClient.insertWithBody('payment/createOrder', body);
      if (response.data != null) {
        final ApiResponse<PaymentOrderRazorPay> apiResponse = ApiResponse<PaymentOrderRazorPay>.fromJson(
          response.data,
          (json) => PaymentOrderRazorPay.fromJson(json as Map<String, dynamic>),
        );

        return apiResponse;
      }
    } catch (e) {
      //? AppSnackBar.errorSnackBar('Error', e.toString());
      ErrorHandler.handleError(e, isDioError: false, page: 'payment_repo_impl', method: 'createOrder');
      return null;
    }
    return null;
  }


  @override
  Future<ApiResponse<PlanPaymentResponse>?> checkTransactionIsSuccess(Map<String,dynamic> body) async {
    try {
      final response = await _dioClient.insertWithBody('payment/checkTransaction', body);
      if (response.data != null) {
        final ApiResponse<PlanPaymentResponse> apiResponse = ApiResponse<PlanPaymentResponse>.fromJson(
          response.data,
              (json) => PlanPaymentResponse.fromJson(json as Map<String, dynamic>),
        );

        return apiResponse;
      }
    } catch (e) {
      //? AppSnackBar.errorSnackBar('Error', e.toString());
      ErrorHandler.handleError(e, isDioError: false, page: 'payment_repo_impl', method: 'createOrder');
      return null;
    }
    return null;
  }

}
