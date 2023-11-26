import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Response;
import 'package:smart_menu/core/routes/app_pages.dart';
import 'package:smart_menu/domain/repository/network/contract/category_repository.dart';
import 'package:smart_menu/presentation/controller/login_controller.dart';
import 'package:smart_menu/presentation/widget/snack_bar.dart';
import '../../constants/app_constant_names.dart';
import '../../constants/url.dart';
import '../../data/model/api_response/api_response.dart';
import '../../data/model/category/category.dart';
import '../../data/model/food/food.dart';
import '../../domain/repository/network/contract/food_repository.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class AddFoodController extends GetxController {
  final foodFormKey = GlobalKey<FormState>();
  FoodRepository foodRepository = Get.find<FoodRepository>();
  CategoryRepository categoryRepository = Get.find<CategoryRepository>();

  //? to store image file
  File? file;
  File? imageFile;

  //?to store the img link of food gallery
  String? galleryImgLink;

  //? text-editing controllers
  late TextEditingController fdNameTD;
  late TextEditingController fdDescriptionTD;
  late TextEditingController fdPriceTD;
  late TextEditingController fdFullPriceTD;
  late TextEditingController fdThreeBiTwoPrsTD;
  late TextEditingController fdHalfPriceTD;
  late TextEditingController fdQtrPriceTD;

  //?focus Nodes
   FocusNode nameFocusNode = FocusNode();
   FocusNode descriptionFocusNode= FocusNode();
   FocusNode priceFocusNode= FocusNode();
   FocusNode fullPriceFocusNode= FocusNode();
   FocusNode threeBiTwoPrsFocusNode= FocusNode();
   FocusNode halfPriceFocusNode= FocusNode();
   FocusNode qtrPriceFocusNode= FocusNode();

  //? category name controller for adding new category
  late TextEditingController categoryNameTD;

  //? Category to show in UI
  final List<Category> _myCategory = [];

  List<Category> get myCategory => _myCategory;

  //? to show and hide multiple price text field on toggle price btn
  bool priceToggle = false;

  //? to show full screen loading
  bool isLoading = false;

  //? for category update need other loader , so after catch isLoading become false so in ctr.list.length may make error
  bool isLoadingCategory = false;

  //? to show loading when add new category
  bool addCategoryLoading = false;

  //? to change tapped color of category card
  //? it wil updated in setCategoryTappedIndex() method
  int tappedIndex = 0;

  //? to get by selected category
  int selectedCategory = -1;

  //? to show add category card and text-field
  bool addCategoryToggle = false;

  Food? foodToUpdate;
  bool isUpdate = false;

  //? to check image is crated by cache in food update
  //? if its true in food update method then no file will send to server
  bool isCacheImageFile = false;

  @override
  Future<void> onInit() async {
    initTxtCtrl();
    handleFoodArguments();
    getAllCategory();
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
        foodToUpdate = arguments['food'];
        isUpdate = foodToUpdate == null ? false : true;
        setFoodDetailsIfUpdate(foodToUpdate);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void loadImage(String? url) async {
    try {
      if (url == null || url == IMG_LINK || url == '') {
        imageFile = null;
      } else {
        File file = await DefaultCacheManager().getSingleFile(url);
        imageFile = file;
        isCacheImageFile = true;
      }
      update();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> submitFood() async {
    try {
      if (foodFormKey.currentState!.validate()) {
        if (selectedCategory == -1) {
          AppSnackBar.errorSnackBar('Error', 'Pleas select a category');
          return false;
        }
        Food food = Food(
          isUpdate ? (foodToUpdate?.id ?? 0) : 0,
          Get.find<LoginController>().myShop.shopId,
          fdNameTD.text,
          fdDescriptionTD.text,
          selectedCategory,
          priceToggle ? (double.tryParse(fdFullPriceTD.text) ?? 0) : (double.tryParse(fdPriceTD.text) ?? 0),
          fdThreeBiTwoPrsTD.text.isEmpty ? 0 : (double.tryParse(fdThreeBiTwoPrsTD.text) ?? 0),
          fdHalfPriceTD.text.isEmpty ? 0 : (double.tryParse(fdHalfPriceTD.text) ?? 0),
          fdQtrPriceTD.text.isEmpty ? 0 : (double.tryParse(fdQtrPriceTD.text) ?? 0),
          0, //? offer price set in server side
          0, //? offer price set in server side
          0, //? offer price set in server side
          0, //? offer price set in server side
          'No Offer',  //? offer name will set when offer creating
          priceToggle.toString(),
          0,
          isUpdate ? (galleryImgLink ?? (foodToUpdate?.fdImg ?? IMG_LINK)) : galleryImgLink,
          isUpdate ? (foodToUpdate?.fdIsToday ?? 'false') : 'false',
          isUpdate ? (foodToUpdate?.fdIsQuick ?? 'false') : 'false',
          isUpdate ? (foodToUpdate?.fdIsAvailable ?? 'true') : 'true',
          isUpdate ? (foodToUpdate?.fdIsSpecial ?? 'false') : 'false',
          isUpdate ? (foodToUpdate?.offer ?? 'false') : 'false',
          DateTime.now().toString(),
          DateTime.now().toString(),
        );
        showLoading();
        ApiResponse<Food>? apiResponse;
        if (!isUpdate) {
          //? add new food
          apiResponse = await foodRepository.addFood(food, file);

        } else {
          //? update food
          apiResponse = await foodRepository.updateFood(food, file);
        }
        if (apiResponse != null) {
          if (apiResponse.error) {
            AppSnackBar.errorSnackBar('Error', apiResponse.message);
            return false;
          } else {
            AppSnackBar.successSnackBar('Success', apiResponse.message);
            clearFields();
            if (isUpdate) {
              Get.offNamed(AppPages.FOOD_MENU_PAGE, arguments: {'from': 'update'});
            }
            return true;
          }
        } else {
          AppSnackBar.errorSnackBar('Error', 'Something went to  wrong !');
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

  setFoodDetailsIfUpdate(Food? food) async {
    try {
      if (food != null) {
            loadImage(foodToUpdate?.fdImg);
            priceToggle = bool.parse(food.fdIsLoos ?? 'false');
            fdNameTD.text = food.fdName ?? 'Error';
            fdDescriptionTD.text = food.foodDescription ?? 'Error';
            fdPriceTD.text = food.fdFullPrice.toString();
            fdFullPriceTD.text = food.fdFullPrice.toString();
            fdThreeBiTwoPrsTD.text = food.fdThreeBiTwoPrsPrice.toString();
            fdHalfPriceTD.text = food.fdHalfPrice.toString();
            fdQtrPriceTD.text = food.fdQtrPrice.toString();
            update();
          }
    } catch (e) {
      AppSnackBar.errorSnackBar('Error', e.toString());
    }
  }

  //////! category section !//////

  //? to change tapped category
  setCategoryTappedIndex(int val, int catId) {
    tappedIndex = val;
    //? update selected category on tapping
    selectedCategory = catId;
    update();
  }

  //? to add category widget show and hide
  setAddCategoryToggle(bool val) {
    addCategoryToggle = val;
    update();
  }

  //?insert category
  Future insertCategory() async {
    try {
      if (categoryNameTD.text.isNotEmpty) {
        Category category = Category(
          0,
          categoryNameTD.text,
          Get.find<LoginController>().myShop.shopId,
          DateTime.now().toString(),
          DateTime.now().toString(),
        );
        showAddCategoryLoading();
        ApiResponse<Category>? apiResponse = await categoryRepository.addCategory(category);
        if (apiResponse != null) {
          if (apiResponse.error) {
            AppSnackBar.errorSnackBar('Error', apiResponse.message);
            return false;
          } else {
            AppSnackBar.successSnackBar('Success', apiResponse.message);
            categoryNameTD.clear();
            getAllCategory();
            return true;
          }
        } else {
        //?  AppSnackBar.errorSnackBar('Error', 'Something went to  wrong !');
          return false;
        }
      } else {
        AppSnackBar.errorSnackBar('Error', 'Pleas Enter Name');
      }
    } catch (e) {
      return;
    } finally {
      hideAddCategoryLoading();
      update();
    }
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
            if (isUpdate) {
              int? index = _myCategory.indexWhere((cat) => cat.id == (foodToUpdate?.fdCategory ?? 0));
              //? If category is not found, set tappedIndex to 0, otherwise set it to the found index
              tappedIndex = index == -1 ? 0 : index;
              selectedCategory = foodToUpdate?.fdCategory ?? -1;
            } else {
              selectedCategory = _myCategory.first.id ?? -1;
            }
          }
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

  //? to delete the food
  deleteCategory({required int catId}) async {
    try {
      showLoadingCategoryLoading();
      ApiResponse<Category>? apiResponse = await categoryRepository.deleteCategory(catId);
      if (apiResponse != null) {
        if (apiResponse.error) {
          AppSnackBar.errorSnackBar('Error', apiResponse.message);
          return false;
        } else {
          AppSnackBar.successSnackBar('Success', apiResponse.message);
          getAllCategory();
          return true;
        }
      } else {
       //? AppSnackBar.errorSnackBar('Error', 'Something went to  wrong !');
        return false;
      }
    } catch (e) {
      rethrow;
      AppSnackBar.errorSnackBar('Error', 'Something went to  wrong !');
    } finally {
      hideLoadingCategoryLoading();
      update();
    }
  }




  //? updating the price toggle when toggle btn click
  setPriceToggle(bool val) {
    priceToggle = val;
    update();
  }

  //?to clear value after toggle off
  void clearLoosPrice() {
    if (!priceToggle) {
      fdFullPriceTD.text = '';
      fdThreeBiTwoPrsTD.text = '';
      fdHalfPriceTD.text = '';
      fdQtrPriceTD.text = '';
    }
  }

  //? to clear text-field and file after success insert
  clearFields() {
    fdNameTD.text = '';
    fdDescriptionTD.text = '';
    fdPriceTD.text = '';
    fdFullPriceTD.text = '';
    fdThreeBiTwoPrsTD.text = '';
    fdHalfPriceTD.text = '';
    fdQtrPriceTD.text = '';
    priceToggle = false;
    file = null;
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
    //? category name controller for adding new category
    categoryNameTD = TextEditingController();
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

  showAddCategoryLoading() {
    addCategoryLoading = true;
    update();
  }

  hideAddCategoryLoading() {
    addCategoryLoading = false;
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
