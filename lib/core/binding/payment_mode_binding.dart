import 'package:get/get.dart';
import 'package:smart_menu/domain/repository/network/contract/payment_repository.dart';
import 'package:smart_menu/domain/repository/network/impl/payment_repo_impl.dart';
import 'package:smart_menu/presentation/controller/razor_pay_controller.dart';



class PaymentModeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PaymentRepository>(PaymentRepositoryImpl(Get.find()), permanent: true);
    Get.lazyPut(() => RazorPayController());
  }
}