import 'package:get/get.dart';
import 'package:smart_menu/presentation/controller/add_food_controller.dart';
import 'package:smart_menu/presentation/controller/food_menu_controller.dart';
import 'package:smart_menu/presentation/controller/payment_modes_controller.dart';



class PaymentModeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PaymentModesController());
  }
}