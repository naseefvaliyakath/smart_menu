import 'package:get/get.dart';
import 'package:smart_menu/presentation/controller/food_menu_controller.dart';



class FoodMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FoodMenuController());
  }
}