import 'package:get/get.dart';
import 'package:smart_menu/presentation/controller/create_offer_controller.dart';
import 'package:smart_menu/presentation/controller/food_menu_controller.dart';
import 'package:smart_menu/presentation/controller/offer_page_controller.dart';



class CreateOfferPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateOfferController());
  }
}