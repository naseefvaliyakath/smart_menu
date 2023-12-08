import 'package:get/get.dart';
import 'package:smart_menu/presentation/controller/customize_qr_stand_controller.dart';
import 'package:smart_menu/presentation/controller/food_menu_controller.dart';
import 'package:smart_menu/presentation/controller/offer_page_controller.dart';



class CustomizeQrStandBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CustomizeQRStandController());
  }
}