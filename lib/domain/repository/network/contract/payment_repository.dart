import '../../../../data/model/api_response/api_response.dart';
import '../../../../data/model/payment_order_razor_pay/payment_order_razor_pay.dart';
import '../../../../data/model/plan/plan.dart';
import '../../../../data/model/plan_payment_response/plan_payment_response.dart';

abstract class PaymentRepository {
  Future<ApiResponse<PlanPaymentResponse>?> checkTransactionIsSuccess(Map<String,dynamic> body);
  Future<ApiResponse<PaymentOrderRazorPay>?> createOrder(Plan plan, String currency);
}

