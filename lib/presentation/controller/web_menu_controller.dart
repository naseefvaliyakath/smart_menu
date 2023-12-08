import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:smart_menu/data/model/food/food.dart';

import '../../data/model/api_response/api_response.dart';
import '../../data/model/category/category.dart';
import '../../domain/repository/network/contract/category_repository.dart';
import '../../domain/repository/network/contract/food_repository.dart';
import '../widget/snack_bar.dart';

class WebMenuController extends GetxController {
  Color mainColor = Color(0xfff5460f);
  Color secondColor = Color(0xff236fd5);
  Color titleColor = Color(0xff23d571);

  bool showAllFood = true;
  bool showAvailableFood = true;
  bool showOfferFood = true;
  bool showTodayFood = true;
  bool showQuickFood = true;
  bool showFoodPrice = true;
  bool showFoodDescription = true;

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onClose() async {
    super.onInit();
  }

  updateSelectedColor(String type, Color selectedColor) {
    if (type == 'mainColor') {
      mainColor = selectedColor;
    } else if (type == 'secondColor') {
      secondColor = selectedColor;
    } else if (type == 'titleColor') {
      titleColor = selectedColor;
    } else {}
    update();
  }

  void updateToggleButtons(String type, bool status) {
    if (type == 'showAllFood') {
      showAllFood = status;
    } else if (type == 'showAvailableFood') {
      showAvailableFood = status;
    } else if (type == 'showOfferFood') {
      showOfferFood = status;
    } else if (type == 'showTodayFood') {
      showTodayFood = status;
    } else if (type == 'showQuickFood') {
      showQuickFood = status;
    } else if (type == 'showFoodPrice') {
      showFoodPrice = status;
    } else if (type == 'showFoodDescription') {
      showFoodDescription = status;
    } else {}
    update();
  }
}
