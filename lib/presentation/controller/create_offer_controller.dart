import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Response;

import '../../data/model/food/food.dart';


class CreateOfferController extends GetxController {
  final foodFormKey = GlobalKey<FormState>();
  File? imageFile;

  //? text-editing controllers
  late TextEditingController fdNameTD;
  late TextEditingController fdDescriptionTD;
  late TextEditingController fdPriceTD;
  late TextEditingController fdFullPriceTD;
  late TextEditingController fdThreeBiTwoPrsTD;
  late TextEditingController fdHalfPriceTD;
  late TextEditingController fdQtrPriceTD;

  bool isLoading = false;
  Food? food;

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
        food = arguments['food'];
        update();
      }
    } catch (e) {
      print(e.toString());
    }
  }


  clearFields() {
    fdNameTD.text = '';
    fdDescriptionTD.text = '';
    fdPriceTD.text = '';
    fdFullPriceTD.text = '';
    fdThreeBiTwoPrsTD.text = '';
    fdHalfPriceTD.text = '';
    fdQtrPriceTD.text = '';
    update();
  }


  initTxtCtrl() {
    fdNameTD = TextEditingController();
    fdDescriptionTD = TextEditingController();
    fdPriceTD = TextEditingController();
    fdFullPriceTD = TextEditingController();
    fdThreeBiTwoPrsTD = TextEditingController();
    fdHalfPriceTD = TextEditingController();
    fdQtrPriceTD = TextEditingController();
  }

  disposeTxtCtrl() {
    fdNameTD.dispose();
    fdDescriptionTD.dispose();
    fdFullPriceTD.dispose();
    fdThreeBiTwoPrsTD.dispose();
    fdHalfPriceTD.dispose();
    fdQtrPriceTD.dispose();
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
