import 'package:get/get.dart';
import 'package:smart_menu/domain/repository/network/contract/category_repository.dart';
import 'package:smart_menu/domain/repository/network/contract/food_gallery_repository.dart';
import 'package:smart_menu/domain/repository/network/contract/food_repository.dart';
import 'package:smart_menu/domain/repository/network/impl/category_repo_impl.dart';
import 'package:smart_menu/domain/repository/network/impl/food_repo_impl.dart';

import '../../data/network/dio_client.dart';
import '../../domain/repository/network/impl/food_gallery_repository_impl.dart';
import '../../presentation/controller/home_controller.dart';



class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<FoodGalleryRepository>(FoodGalleryRepositoryImpl(Get.find()), permanent: true);
    Get.put<FoodRepository>(FoodRepositoryImpl(Get.find()), permanent: true);
    Get.put<CategoryRepository>(CategoryRepositoryImpl(Get.find()), permanent: true);
    Get.put<HomeController>(HomeController(), permanent: true);
  }
}
