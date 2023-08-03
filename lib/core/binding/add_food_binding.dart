import 'package:get/get.dart';
import 'package:smart_menu/presentation/controller/add_food_controller.dart';
import 'package:smart_menu/presentation/controller/food_menu_controller.dart';



class AddFoodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddFoodController());
  }
}