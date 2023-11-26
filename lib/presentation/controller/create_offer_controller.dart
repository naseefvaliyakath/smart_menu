import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Response;
import 'package:smart_menu/presentation/controller/offer_page_controller.dart';
import '../../constants/app_constant_names.dart';
import '../../core/routes/app_pages.dart';
import '../../data/model/api_response/api_response.dart';
import '../../data/model/food/food.dart';
import '../../domain/repository/network/contract/food_repository.dart';
import '../widget/snack_bar.dart';


class CreateOfferController extends GetxController {
  final offerFormKey = GlobalKey<FormState>();
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
      print(e.toString());
    }
  }


  Future<bool> updateOffer() async {
    try {
      if (offerFormKey.currentState!.validate()) {
        //? only the offer details need correct value , other values not update
        Food food = Food(
          offerFood?.id ?? 0,
          MY_SHOP_ID,
          'name',
          'description',
          0,
          0,
          0,
          0,
          0,
          fdOffFullPriceTD.text.isEmpty ? offerFood?.fdOffFullPrice : (double.tryParse(fdOffFullPriceTD.text) ?? 0),
          fdOffThreeBiTwoPrsTD.text.isEmpty ? offerFood?.fdOffThreeByTwoPrice : (double.tryParse(fdOffThreeBiTwoPrsTD.text) ?? 0),
          fdOffHalfPriceTD.text.isEmpty ? offerFood?.fdOffHalfPrice : (double.tryParse(fdOffHalfPriceTD.text) ?? 0),
          fdOffQtrPriceTD.text.isEmpty ? offerFood?.fdOffQtrPrice : (double.tryParse(fdOffQtrPriceTD.text) ?? 0),
          fdOffNameTD.text,
          'false',
          0,
          '',
          'false',
          'false',
          'true',
          'false',
          'true',
          DateTime.now().toString(),
          DateTime.now().toString(),
        );
        showLoading();
        ApiResponse<Food>? apiResponse = await foodRepository.updateOfferFields(food);
        if (apiResponse != null) {
          if (apiResponse.error) {
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
      AppSnackBar.errorSnackBar('Error', e.toString());
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
