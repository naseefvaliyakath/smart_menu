import 'dart:io';
import 'package:flutter/material.dart' hide ThemeMode;
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:smart_menu/presentation/controller/login_controller.dart';
import 'package:smart_menu/presentation/controller/offer_page_controller.dart';
import '../../core/routes/app_pages.dart';
import '../../data/model/api_response/api_response.dart';
import '../../data/model/food/food.dart';
import '../../data/network/handle_error.dart';
import '../../domain/repository/network/contract/food_repository.dart';
import '../alert/renew_plan_alert.dart';
import '../widget/snack_bar.dart';

class CreateOfferController extends GetxController {
  GlobalKey<FormState>  offerFormKey = GlobalKey<FormState>();
  FoodRepository foodRepository = Get.find<FoodRepository>();
  File? imageFile;

  //? text-editing controllers
  late TextEditingController fdOffNameTD;
  late TextEditingController fdOffFullPriceTD;
  late TextEditingController fdOffThreeBiTwoPrsTD;
  late TextEditingController fdOffHalfPriceTD;
  late TextEditingController fdOffQtrPriceTD;

  bool isLoading = false;
  Food? offerFood;

  @override
  Future<void> onInit() async {
    initTxtCtrl();
    handleFoodArguments();
    super.onInit();
  }

  @override
  void onClose() {
    disposeTxtCtrl();
  }

  void handleFoodArguments() {
    try {
      final arguments = Get.arguments as Map<String, dynamic>?;
      if (arguments != null && arguments.containsKey('food')) {
        offerFood = arguments['food'];
        update();
      }
    } catch (e) {
      ErrorHandler.handleError(e, isDioError: false, page: 'create_offer_controller', method: 'handleFoodArguments');
      return;
    }
  }

  Future<bool> updateOffer() async {
    try {
      if (offerFormKey.currentState!.validate()) {
        //? only the offer details need correct value , other values not update
        Food food =Food(
          id: offerFood?.id ?? 0,
          shopId: Get.find<LoginController>().myShop.shopId,
          fdName: 'name',
          foodDescription: 'description',
          fdCategory: 0,
          fdFullPrice: 0,
          fdThreeBiTwoPrsPrice: 0,
          fdHalfPrice: 0,
          fdQtrPrice: 0,
          fullPrsName: 'Full', // Note: Comment indicates NO EFFECT
          thrByToPrsName: '3/4', // Note: Comment indicates NO EFFECT
          halfPrsName: 'Half', // Note: Comment indicates NO EFFECT
          qtrPrsName: 'Quarter', // Note: Comment indicates NO EFFECT
          fdOffFullPrice: fdOffFullPriceTD.text.isEmpty ? offerFood?.fdOffFullPrice : (double.tryParse(fdOffFullPriceTD.text) ?? 0),
          fdOffThreeByTwoPrice: fdOffThreeBiTwoPrsTD.text.isEmpty ? offerFood?.fdOffThreeByTwoPrice : (double.tryParse(fdOffThreeBiTwoPrsTD.text) ?? 0),
          fdOffHalfPrice: fdOffHalfPriceTD.text.isEmpty ? offerFood?.fdOffHalfPrice : (double.tryParse(fdOffHalfPriceTD.text) ?? 0),
          fdOffQtrPrice: fdOffQtrPriceTD.text.isEmpty ? offerFood?.fdOffQtrPrice : (double.tryParse(fdOffQtrPriceTD.text) ?? 0),
          offerName: fdOffNameTD.text,
          fdIsLoos: 'false',
          cookTime: 0,
          fdImg: '',
          fdIsToday: 'false',
          fdIsQuick: 'false',
          fdIsAvailable: 'true',
          fdIsHide: 'false',
          offer: 'true',
          createdAt: DateTime.now().toString(),
          updatedAt: DateTime.now().toString(),
        );

        showLoading();
        ApiResponse<Food>? apiResponse = await foodRepository.updateOfferFields(food);
        if (apiResponse != null) {
          if (apiResponse.error) {
            checkAndRenewPlanAlert(apiResponse.message);
            AppSnackBar.errorSnackBar('Error', apiResponse.message);
            return false;
          } else {
            AppSnackBar.successSnackBar('Success', apiResponse.message);
            if (Get.isRegistered<OfferPageController>()) {
              Get.find<OfferPageController>().getAllOfferFood(showSnack: false);
            }
            Get.offNamed(AppPages.OFFER_PAGE);
            return true;
          }
        } else {
          //?  AppSnackBar.errorSnackBar('Error', 'Something went to  wrong !');
          return false;
        }
      } else {
        AppSnackBar.errorSnackBar('Error', 'Form not validated');
        return false;
      }
    } catch (e) {
      ErrorHandler.handleError(e, isDioError: false, page: 'create_offer_controller', method: 'updateOffer');
      return false;
    } finally {
      hideLoading();
    }
  }

  clearFields() {
    fdOffNameTD.text = '';
    fdOffFullPriceTD.text = '';
    fdOffThreeBiTwoPrsTD.text = '';
    fdOffHalfPriceTD.text = '';
    fdOffQtrPriceTD.text = '';
    update();
  }

  initTxtCtrl() {
    fdOffNameTD = TextEditingController();
    fdOffFullPriceTD = TextEditingController();
    fdOffThreeBiTwoPrsTD = TextEditingController();
    fdOffHalfPriceTD = TextEditingController();
    fdOffQtrPriceTD = TextEditingController();
  }

  disposeTxtCtrl() {
    fdOffNameTD.dispose();
    fdOffFullPriceTD.dispose();
    fdOffThreeBiTwoPrsTD.dispose();
    fdOffHalfPriceTD.dispose();
    fdOffQtrPriceTD.dispose();
  }

  showLoading() {
    isLoading = true;
    update();
  }

  hideLoading() {
    isLoading = false;
    update();
  }


}
