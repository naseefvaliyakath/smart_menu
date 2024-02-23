import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:smart_menu/data/model/food/food.dart';
import 'package:smart_menu/data/model/web_menu/web_menu.dart';
import 'package:smart_menu/domain/repository/network/contract/web_menu_repository.dart';
import 'package:smart_menu/presentation/controller/login_controller.dart';

import '../../data/model/api_response/api_response.dart';
import '../../data/model/category/category.dart';
import '../../data/network/handle_error.dart';
import '../../domain/repository/network/contract/category_repository.dart';
import '../../domain/repository/network/contract/food_repository.dart';
import '../alert/renew_plan_alert.dart';
import '../widget/snack_bar.dart';

class WebMenuController extends GetxController {
  final GlobalKey showcaseWebMenuColorSelect = GlobalKey();
  final GlobalKey showcaseWebMenuToggle = GlobalKey();
  final GlobalKey showcaseWebMenuSave = GlobalKey();
  final GlobalKey showcaseWebMenuDesign = GlobalKey();
  WebMenuRepository webMenuRepository = Get.find<WebMenuRepository>();

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
  bool isSelectedDesign1 = true;

  WebMenu? webMenu;

  //? to show full screen loading
  bool isLoading = false;

  @override
  void onInit() async {
    getWebMenuConfig();
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
    }
    else if (type == 'isSelectedDesign1') {
      isSelectedDesign1 = status;
    }else {}
    update();
  }

  getWebMenuConfig() async {
    try {
      int shopId = Get.find<LoginController>().myShop.shopId ?? 0;
      showLoading();
      ApiResponse<WebMenu>? apiResponse = await webMenuRepository.getWebMenu(shopId);
      if (apiResponse != null) {
        if (apiResponse.error) {
          AppSnackBar.errorSnackBar('Error', apiResponse.message);
          return false;
        } else {
          webMenu = apiResponse.data;
          initialToggleAndColorSetting(webMenu);
        }
      } else {
       //? AppSnackBar.errorSnackBar('Errors', 'Something went to  wrong !');
        return false;
      }
    } catch (e) {
      ErrorHandler.handleError(e, isDioError: false, page: 'web_menu_controller', method: 'getWebMenuConfig');
      return;
    } finally {
      hideLoading();
      update();
    }
  }

  updateWebMenuConfig() async {
    try {
      WebMenu? webMenuToUpdate = webMenu;
      if (webMenuToUpdate != null) {
        //? setting items
        webMenuToUpdate.showAllFood = showAllFood.toString();
        webMenuToUpdate.showAvailableFood = showAvailableFood.toString();
        webMenuToUpdate.showOfferFood = showOfferFood.toString();
        webMenuToUpdate.showTodayFood = showTodayFood.toString();
        webMenuToUpdate.showQuickFood = showQuickFood.toString();
        webMenuToUpdate.showFoodPrice = showFoodPrice.toString();
        webMenuToUpdate.showFoodDescription = showFoodDescription.toString();
        webMenuToUpdate.cardDesign = isSelectedDesign1 ? 1 : 2;

        webMenuToUpdate.mainColor = colorToString(mainColor);
        webMenuToUpdate.secondColor = colorToString(secondColor);
        webMenuToUpdate.titleColor = colorToString(titleColor);
      }else{
        AppSnackBar.errorSnackBar('Error', 'Something went to  wrong !');
        return;
      }

      showLoading();
      ApiResponse<WebMenu>? apiResponse = await webMenuRepository.updateWebMenu(webMenuToUpdate);
      if (apiResponse != null) {
        if (apiResponse.error) {
          checkAndRenewPlanAlert(apiResponse.message);
          AppSnackBar.errorSnackBar('Error', apiResponse.message);
          return false;
        } else {
          AppSnackBar.successSnackBar('Success', apiResponse.message);
        }
      } else {
        AppSnackBar.errorSnackBar('Error', 'Something went to  wrong !');
        return false;
      }
    } catch (e) {
      ErrorHandler.handleError(e, isDioError: false, page: 'web_menu_controller', method: 'updateWebMenuConfig');
      return;
    } finally {
      hideLoading();
      update();
    }
  }

  initialToggleAndColorSetting(WebMenu? webMenu) {
    if (webMenu != null) {
      showAllFood = stringToBool(webMenu.showAllFood);
      showAvailableFood = stringToBool(webMenu.showAvailableFood);
      showOfferFood = stringToBool(webMenu.showOfferFood);
      showTodayFood = stringToBool(webMenu.showTodayFood);
      showQuickFood = stringToBool(webMenu.showQuickFood);
      showFoodPrice = stringToBool(webMenu.showFoodPrice);
      showFoodDescription = stringToBool(webMenu.showFoodDescription);
      isSelectedDesign1 = webMenu.cardDesign == 1 ? true : false;

      mainColor = stringToColor(webMenu.mainColor ?? '0xfff25f27');
      secondColor = stringToColor(webMenu.secondColor ?? '0xFFf9c920');
      titleColor = stringToColor(webMenu.titleColor ?? '0xff0c0c0c');
    }
    update();
  }

  showLoading() {
    isLoading = true;
    update();
  }

  hideLoading() {
    isLoading = false;
    update();
  }

  bool stringToBool(String? str) {
    if (str == null) {
      return true;
    }
    return str.toLowerCase() == 'true';
  }

  Color stringToColor(String colorString) {
    //? Remove the '#' symbol if it's present
    colorString = colorString.replaceAll('#', '');
    //? Add '0xff' prefix if it's not present
    if (!colorString.startsWith('0xff')) {
      colorString = '0xff$colorString';
    }
    return Color(int.parse(colorString));
  }

  String colorToString(Color color) {
    String colorStr = color.value.toRadixString(16).padLeft(8, '0');
    return '0xff$colorStr';
  }
}
