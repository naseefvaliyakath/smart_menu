import 'package:get/get.dart';
import 'package:smart_menu/domain/repository/network/contract/category_repository.dart';
import 'package:smart_menu/domain/repository/network/contract/food_gallery_repository.dart';
import 'package:smart_menu/domain/repository/network/contract/food_repository.dart';
import 'package:smart_menu/domain/repository/network/contract/plan_repository.dart';
import 'package:smart_menu/domain/repository/network/contract/web_menu_repository.dart';
import 'package:smart_menu/domain/repository/network/impl/category_repo_impl.dart';
import 'package:smart_menu/domain/repository/network/impl/food_repo_impl.dart';
import 'package:smart_menu/domain/repository/network/impl/plan_repo_impl.dart';
import 'package:smart_menu/domain/repository/network/impl/web_menu_repo_impl.dart';
import 'package:smart_menu/presentation/controller/show_case_controller.dart';
import '../../domain/repository/network/impl/food_gallery_repository_impl.dart';
import '../../presentation/controller/home_controller.dart';



class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ShowcaseController>(ShowcaseController(), permanent: true);
    Get.put<FoodGalleryRepository>(FoodGalleryRepositoryImpl(Get.find()), permanent: true);
    Get.put<FoodRepository>(FoodRepositoryImpl(Get.find()), permanent: true);
    Get.put<CategoryRepository>(CategoryRepositoryImpl(Get.find()), permanent: true);
    Get.put<WebMenuRepository>(WebMenuRepositoryImpl(Get.find()), permanent: true);
    Get.put<PlanRepository>(PlanRepositoryImpl(Get.find()), permanent: true);
    Get.put<HomeController>(HomeController(), permanent: true);
  }
}
