import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:smart_menu/constants/app_constant_names.dart';
import 'package:smart_menu/data/model/food_gallery/food_gallery.dart';
import 'package:smart_menu/data/model/food_gallery_category/food_gallery_category.dart';
import 'package:smart_menu/domain/repository/network/contract/food_gallery_repository.dart';
import 'package:smart_menu/presentation/view/startup_video_tutorial.dart';
import '../../data/model/api_response/api_response.dart';
import '../../data/network/handle_error.dart';
import '../widget/snack_bar.dart';

class HomeController extends GetxController {
  final storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ));
  FoodGalleryRepository foodGalleryRepository = Get.find<FoodGalleryRepository>();

  final List<FoodGalleryItem> _storedFoodGalleryFoods = [];
  final List<FoodGalleryItem> foodGalleryFoods = [];
  final List<FoodGalleryCategory> foodGalleryCategory = [];

  @override
  Future<void> onReady() async {
    Future.delayed(const Duration(milliseconds: 500), () async {
      await getGalleryCategory(showSnack: false);
      getFoodGallery(showSnack: false);
      showStartupVideo();
    });
    super.onReady();
  }

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  void clearCacheMemory() async {
    try {
      final cacheManager = CacheManager(
            Config(
              'my_cache',
              stalePeriod: const Duration(days: 7),
            ),
          );
      await cacheManager.emptyCache();
    } catch (e) {
      ErrorHandler.handleError(e, isDioError: false, page: 'home_controller', method: 'clearCacheMemory');
      return;
    }
  }

  getFoodGallery({bool showSnack = true}) async {
    try {
      ApiResponse<List<FoodGalleryItem>>? apiResponse = await foodGalleryRepository.getAllFoodGallery();
      if (apiResponse != null) {
        if (apiResponse.error) {
          AppSnackBar.errorSnackBar('Error', apiResponse.message);
          return false;
        } else {
          _storedFoodGalleryFoods.clear();
          _storedFoodGalleryFoods.addAll(apiResponse.data ?? []);
          if (foodGalleryCategory.isNotEmpty) {
            filterFoodGalleryByCategory(foodGalleryCategory.first.id ?? 0);
          } else {
            filterFoodGalleryByCategory(0);
          }
          showSnack == true ? AppSnackBar.successSnackBar('Success', apiResponse.message) : null;
          return true;
        }
      } else {
        //? AppSnackBar.errorSnackBar('Error', 'Something went to  wrong !');
        return false;
      }
    } catch (e) {
      ErrorHandler.handleError(e, isDioError: false, page: 'home_controller', method: 'getFoodGallery');
      return;
    } finally {
      update();
    }
  }

  void filterFoodGalleryByCategory(int category) {
    //? Filter the _storedFoodGalleryFoods list for items where the category matches the given category
    List<FoodGalleryItem> filteredList = _storedFoodGalleryFoods.where((item) => item.fdGallCatId == category).toList();
    //? Assign the filtered list to foodGalleryFoods
    foodGalleryFoods.clear();
    foodGalleryFoods.addAll(filteredList);
    update();
  }

  getGalleryCategory({bool showSnack = true}) async {
    try {
      ApiResponse<List<FoodGalleryCategory>>? apiResponse = await foodGalleryRepository.getAllGalleryCategory();
      if (apiResponse != null) {
        if (apiResponse.error) {
          AppSnackBar.errorSnackBar('Error', apiResponse.message);
          return false;
        } else {
          foodGalleryCategory.clear();
          foodGalleryCategory.addAll(apiResponse.data ?? []);
          showSnack == true ? AppSnackBar.successSnackBar('Success', apiResponse.message) : null;
          return true;
        }
      } else {
        //? AppSnackBar.errorSnackBar('Error', 'Something went to  wrong !');
        return false;
      }
    } catch (e) {
      ErrorHandler.handleError(e, isDioError: false, page: 'home_controller', method: 'getGalleryCategory');
      return;
    } finally {
      update();
    }
  }

  showStartupVideo() async {
    try {
      String? isVideoWatch = await storage.read(key: KEY_STARTUP_TUTORIAL);
      if (isVideoWatch == null || isVideoWatch == 'false') {
            Get.to(() => const StartupTutorialPage());
          }
    } catch (e) {
      ErrorHandler.handleError(e, isDioError: false, page: 'home_controller', method: 'showStartupVideo');
      return;
    }
  }


}
