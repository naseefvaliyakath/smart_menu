import 'package:get/get.dart';
import 'package:smart_menu/presentation/controller/food_menu_controller.dart';
import 'package:smart_menu/presentation/controller/offer_page_controller.dart';



class OfferPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OfferPageController());
  }
}