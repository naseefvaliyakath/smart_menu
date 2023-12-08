import 'package:get/get.dart';
import 'package:smart_menu/presentation/controller/customize_qr_stand_controller.dart';
import 'package:smart_menu/presentation/controller/food_menu_controller.dart';
import 'package:smart_menu/presentation/controller/offer_page_controller.dart';
import 'package:smart_menu/presentation/controller/web_menu_controller.dart';



class WebMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WebMenuController());
  }
}