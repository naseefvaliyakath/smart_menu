import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:smart_menu/data/model/food/food.dart';

import '../../core/routes/app_pages.dart';
import '../../data/model/api_response/api_response.dart';
import '../../data/model/category/category.dart';
import '../../data/network/handle_error.dart';
import '../../domain/repository/network/contract/category_repository.dart';
import '../../domain/repository/network/contract/food_repository.dart';
import '../alert/renew_plan_alert.dart';
import '../widget/snack_bar.dart';

class OfferPageController extends GetxController {
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
    getAllOfferFood(showSnack: false);
    super.onInit();
  }

  @override
  void onClose() async {
    super.onInit();
  }

  getAllOfferFood({bool showSnack = true}) async {
    try {
      isLoading = true;
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
          update();
          showSnack == true ? AppSnackBar.successSnackBar('Success', apiResponse.message) : null;
          return true;
        }
      } else {
        //? AppSnackBar.errorSnackBar('Error', 'Something went to  wrong !');
        return false;
      }
    } catch (e) {
      ErrorHandler.handleError(e, isDioError: false, page: 'offer_page_controller', method: 'getAllOfferFood');
      return;
    } finally {
      isLoading = false;
      update();
    }
  }

  removeOffer(Food food) async {
    try {
      //? if already offer , user want to remove (Button showing remove offer)
      if (food.offer == 'true') {
        Food foodToUpdate = Food.copy(food);
        foodToUpdate.offer = 'false';
        foodToUpdate.offerName = 'No Offer';
        foodToUpdate.fdOffFullPrice = foodToUpdate.fdFullPrice;
        foodToUpdate.fdOffThreeByTwoPrice = foodToUpdate.fdThreeBiTwoPrsPrice;
        foodToUpdate.fdOffHalfPrice = foodToUpdate.fdHalfPrice;
        foodToUpdate.fdOffQtrPrice = foodToUpdate.fdQtrPrice;
        ApiResponse<Food>? apiResponse = await foodRepository.updateOfferFields(foodToUpdate);
        if (apiResponse != null) {
          if (apiResponse.error) {
            AppSnackBar.errorSnackBar('Error', apiResponse.message);
            Navigator.pop(Get.context!);
            checkAndRenewPlanAlert(apiResponse.message);
            return false;
          } else {
            AppSnackBar.successSnackBar('Success', apiResponse.message);
            getAllOfferFood(showSnack: false);
            Navigator.pop(Get.context!);
            return true;
          }
        } else {
          //? AppSnackBar.errorSnackBar('Error', 'Something went to  wrong !');
          return false;
        }
      }
    } catch (e) {
      ErrorHandler.handleError(e, isDioError: false, page: 'offer_page_controller', method: 'removeOffer');
      return;
    } finally {
      update();
    }
  }
}
