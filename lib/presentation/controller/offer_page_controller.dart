import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:smart_menu/data/model/food/food.dart';

import '../../data/model/api_response/api_response.dart';
import '../../data/model/category/category.dart';
import '../../domain/repository/network/contract/category_repository.dart';
import '../../domain/repository/network/contract/food_repository.dart';
import '../widget/snack_bar.dart';

class OfferPageController extends GetxController {
  final foodFormKey = GlobalKey<FormState>();
  FoodRepository foodRepository = Get.find<FoodRepository>();
  CategoryRepository categoryRepository = Get.find<CategoryRepository>();

  //? for show full screen loading
  bool isLoading = false;
  bool isLoadingCategory = false;



  //? this will store all AllFood from the server
  //? not showing in UI or change
  final List<Food> _storedAllFoods = [];

  //? today food to show in UI
  final List<Food> _myAllOfferFoods = [];
  List<Food> get myAllFoods => _myAllOfferFoods;



  @override
  void onInit() async {
    getAllOfferFood();
    super.onInit();
  }

  @override
  void onClose() async {
    super.onInit();
  }



  getAllOfferFood({bool showSnack = true}) async {
    try {
      ApiResponse<List<Food>>? apiResponse = await foodRepository.getOfferFood();
      if (apiResponse != null) {
        if (apiResponse.error) {
          AppSnackBar.errorSnackBar('Error', apiResponse.message);
          return false;
        } else {
          _storedAllFoods.clear();
          _myAllOfferFoods.clear();
          _storedAllFoods.addAll(apiResponse.data ?? []);
          _myAllOfferFoods.addAll(_storedAllFoods);
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



  void filterFoods(int category) {
    List<Food> filteredFoods = [];

    if (category < -99) {
      switch (category) {
        case -100: // All foods
          filteredFoods = List.from(_storedAllFoods);
          break;
        case -200: // Special foods
          filteredFoods = _storedAllFoods.where((food) => food.fdIsSpecial == 'true').toList();
          break;
        case -300: // Today's foods
          filteredFoods = _storedAllFoods.where((food) => food.fdIsToday == 'true').toList();
          break;
        case -400: // Available foods
          filteredFoods = _storedAllFoods.where((food) => food.fdIsAvailable == 'true').toList();
          break;
        case -500: // Quick foods
          filteredFoods = _storedAllFoods.where((food) => food.fdIsQuick == 'true').toList();
          break;
        default:
          filteredFoods = [];
      }
    } else {
      // Categories from server
      filteredFoods = _storedAllFoods.where((food) => food.fdCategory == category).toList();
    }
    _myAllOfferFoods.clear();
    _myAllOfferFoods.addAll(filteredFoods);
    update();
  }



  showLoadingCategoryLoading() {
    isLoadingCategory = true;
    update();
  }

  hideLoadingCategoryLoading() {
    isLoadingCategory = false;
    update();
  }


  
}
