import 'package:get/get.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:smart_menu/data/model/food_gallery/food_gallery.dart';
import 'package:smart_menu/data/model/food_gallery_category/food_gallery_category.dart';
import 'package:smart_menu/domain/repository/network/contract/food_gallery_repository.dart';

import '../../data/model/api_response/api_response.dart';
import '../widget/snack_bar.dart';

class HomeController extends GetxController {
  FoodGalleryRepository foodGalleryRepository = Get.find<FoodGalleryRepository>();

  final List<FoodGalleryItem> _storedFoodGalleryFoods = [];
  final List<FoodGalleryItem> foodGalleryFoods = [];
  final List<FoodGalleryCategory> foodGalleryCategory = [];

  @override
  Future<void> onInit() async {
    await getGalleryCategory(showSnack: false);
    getFoodGallery(showSnack: false);
    super.onInit();
  }

  void clearCacheMemory() async {
    final cacheManager = CacheManager(
      Config(
        'my_cache',
        stalePeriod: const Duration(days: 7),
      ),
    );
    await cacheManager.emptyCache();
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
      AppSnackBar.errorSnackBar('Error', 'Something went to  wrong !');
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
      AppSnackBar.errorSnackBar('Error', 'Something went to  wrong !');
    } finally {
      update();
    }
  }


}
