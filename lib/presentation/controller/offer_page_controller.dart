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

  int tappedIndex = 0;

  //? to get by selected category
  int selectedCategory = -1;

  //? Category to show in UI
  final List<Category> _myCategory = [];

  List<Category> get myCategory => _myCategory;

  //? this will store all AllFood from the server
  //? not showing in UI or change
  final List<Food> _storedAllFoods = [];

  //? today food to show in UI
  final List<Food> _myAllFoods = [];
  List<Food> get myAllFoods => _myAllFoods;



  @override
  void onInit() async {
    getAllCategory();
    getAllFood();
    super.onInit();
  }

  @override
  void onClose() async {
    super.onInit();
  }

  getAllCategory() async {
    try {
      showLoadingCategoryLoading();
      ApiResponse<List<Category>>? apiResponse = await categoryRepository.getAllCategories();
      if (apiResponse != null) {
        if (apiResponse.error) {
          AppSnackBar.errorSnackBar('Error', apiResponse.message);
          return false;
        } else {
          _myCategory.clear();
          _myCategory.addAll(apiResponse.data ?? []);
          //? setting initial category
          if (_myCategory.isNotEmpty) {
            selectedCategory = _myCategory.first.id ?? -1;
          }
          // AppSnackBar.successSnackBar('Success', apiResponse.message);
          return true;
        }
      } else {
        AppSnackBar.errorSnackBar('Error', 'Something went to  wrong !');
        return false;
      }
    } catch (e) {
      AppSnackBar.errorSnackBar('Error', 'Something went to  wrong !');
    } finally {
      hideLoadingCategoryLoading();
      update();
    }
  }

  getAllFood({bool showSnack = true}) async {
    try {
      ApiResponse<List<Food>>? apiResponse = await foodRepository.getAllFood();
      if (apiResponse != null) {
        if (apiResponse.error) {
          AppSnackBar.errorSnackBar('Error', apiResponse.message);
          return false;
        } else {
          _storedAllFoods.clear();
          _myAllFoods.clear();
          _storedAllFoods.addAll(apiResponse.data ?? []);
          _myAllFoods.addAll(_storedAllFoods);
          showSnack == true ? AppSnackBar.successSnackBar('Success', apiResponse.message) : null;
          return true;
        }
      } else {
        AppSnackBar.errorSnackBar('Error', 'Something went to  wrong !');
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
    _myAllFoods.clear();
    _myAllFoods.addAll(filteredFoods);
    update();
  }

  //? to change tapped category
  setCategoryTappedIndex(int val, int catId) {
    // Assigning different negative values to the selected category for local cards
    if (val < 5) {
      switch (val) {
        case 0:
          selectedCategory = -100;
          break;
        case 1:
          selectedCategory = -200;
          break;
        case 2:
          selectedCategory = -300;
          break;
        case 3:
          selectedCategory = -400;
          break;
        case 4:
          selectedCategory = -500;
          break;
      }
    } else {
      // Update selected category for fetched categories
      selectedCategory = catId;
    }
    tappedIndex = val;
    //? filtering food
    filterFoods(selectedCategory);
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
