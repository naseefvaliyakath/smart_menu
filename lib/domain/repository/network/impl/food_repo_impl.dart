import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:smart_menu/data/model/food/food.dart';
import '../../../../data/model/api_response/api_response.dart';
import '../../../../data/network/dio_client.dart';
import '../../../../data/network/handle_error.dart';
import '../../../../presentation/controller/login_controller.dart';
import '../../../../presentation/widget/snack_bar.dart';
import '../contract/food_repository.dart';

class FoodRepositoryImpl implements FoodRepository {
  final DioClient _dioClient;

  FoodRepositoryImpl(this._dioClient);

  String getShopId() {
    return Get.find<LoginController>().myShop.shopId.toString();
  }

  @override
  Future<ApiResponse<List<Food>>?> getAllFood() async {
    try {
      final response = await _dioClient.getRequest('food/${getShopId()}');
      if (response.data != null) {
        final ApiResponse<List<Food>> apiResponse = ApiResponse<List<Food>>.fromJson(
          response.data,
          (json) => (json as List).map((item) => Food.fromJson(item)).toList(),
        );
        return apiResponse;
      }
    } catch (e) {
      //? AppSnackBar.errorSnackBar('Error',e.toString());
      ErrorHandler.handleError(e, isDioError: false, page: 'food_repo_impl', method: 'getAllFood');
      return null;
    }
    return null;
  }

  @override
  Future<ApiResponse<Food>?> getFoodById(int id) async {
    try {
      final response = await _dioClient.getRequestWithBody('food/${id.toString()}/${getShopId()}', {'id': id});
      if (response.data != null) {
        final ApiResponse<Food> apiResponse =
            ApiResponse<Food>.fromJson(response.data, (json) => Food.fromJson(json as Map<String, dynamic>));
        return apiResponse;
      }
    } catch (e) {
      //? AppSnackBar.errorSnackBar('Error', e.toString());
      ErrorHandler.handleError(e, isDioError: false, page: 'food_repo_impl', method: 'getFoodById');
      return null;
    }
    return null;
  }

  @override
  Future<ApiResponse<Food>?> addFood(Food food, File? imageFile) async {
    try {
      final Map<String, dynamic> formDataMap = food.toJson();

      if (imageFile != null) {
        String fileName = imageFile.path.split('/').last;
        formDataMap['fdImg'] = await MultipartFile.fromFile(imageFile.path, filename: fileName);
      }

      final formData = FormData.fromMap(formDataMap);

      final response = await _dioClient.postMultipart('food/${getShopId()}', formData);
      if (response.data != null) {
        final ApiResponse<Food> apiResponse = ApiResponse<Food>.fromJson(
          response.data,
          (json) => Food.fromJson(json as Map<String, dynamic>),
        );
        return apiResponse;
      }
    } catch (e) {
      //? AppSnackBar.errorSnackBar('Error', e.toString());
      ErrorHandler.handleError(e, isDioError: false, page: 'food_repo_impl', method: 'addFood');
      return null;
    }
    return null;
  }

  @override
  Future<ApiResponse<Food>?> updateFood(Food food, File? imageFile) async {
    try {
      final Map<String, dynamic> formDataMap = food.toJson();

      if (imageFile != null) {
        String fileName = imageFile.path.split('/').last;
        formDataMap['fdImg'] = await MultipartFile.fromFile(imageFile.path, filename: fileName);
      }

      final formData = FormData.fromMap(formDataMap);

      final response = await _dioClient.putMultipart('food/${getShopId()}', formData);
      if (response.data != null) {
        final ApiResponse<Food> apiResponse = ApiResponse<Food>.fromJson(
          response.data,
          (json) => Food.fromJson(json as Map<String, dynamic>),
        );

        return apiResponse;
      }
    } catch (e) {
      //? AppSnackBar.errorSnackBar('Error', e.toString());
      ErrorHandler.handleError(e, isDioError: false, page: 'food_repo_impl', method: 'updateFood');
      return null;
    }
    return null;
  }

  @override
  Future<ApiResponse<Food>?> deleteFood(int id, String imgName) async {
    try {
      //? for food delete we pass image name also to delete image from server
      final response = await _dioClient.delete('food/$id/${getShopId()}/$imgName');
      if (response.data != null) {
        final ApiResponse<Food> apiResponse = ApiResponse<Food>.fromJson(
          response.data,
          (json) => Food.fromJson(json as Map<String, dynamic>),
        );
        return apiResponse;
      }
    } catch (e) {
      //? AppSnackBar.errorSnackBar('Error', e.toString());
      ErrorHandler.handleError(e, isDioError: false, page: 'food_repo_impl', method: 'deleteFood');
      return null;
    }
    return null;
  }

  @override
  Future<ApiResponse<Food>?> updateSelectedFields(Food food) async {
    try {
      final response = await _dioClient.updateData('food/updateSelected', {
        'id': food.id,
        'fdIsToday': food.fdIsToday,
        'fdIsAvailable': food.fdIsAvailable,
        'fdIsHide': food.fdIsHide,
        'offer': food.offer,
        'fdIsQuick': food.fdIsQuick,
        'shopId': food.shopId,
      });
      if (response.data != null) {
        final ApiResponse<Food> apiResponse = ApiResponse<Food>.fromJson(
          response.data,
          (json) => Food.fromJson(json as Map<String, dynamic>),
        );
        return apiResponse;
      }
    } catch (e) {
      //? AppSnackBar.errorSnackBar('Error', e.toString());
      ErrorHandler.handleError(e, isDioError: false, page: 'food_repo_impl', method: 'updateSelectedFields');
      return null;
    }
    return null;
  }

  @override
  Future<ApiResponse<Food>?> updateOfferFields(Food updates) async {
    try {
      final response = await _dioClient.updateData('food/updateOffer', {
        'id': updates.id,
        'offer': updates.offer,
        'fdOffFullPrice': updates.fdOffFullPrice,
        'fdOffThreeByTwoPrice': updates.fdOffThreeByTwoPrice,
        'fdOffHalfPrice': updates.fdOffHalfPrice,
        'fdOffQtrPrice': updates.fdOffQtrPrice,
        'offerName': updates.offerName,
        'shopId': updates.shopId,
      });
      if (response.data != null) {
        final ApiResponse<Food> apiResponse = ApiResponse<Food>.fromJson(
          response.data,
          (json) => Food.fromJson(json as Map<String, dynamic>),
        );
        return apiResponse;
      }
    } catch (e) {
      //? AppSnackBar.errorSnackBar('Error', e.toString());
      ErrorHandler.handleError(e, isDioError: false, page: 'food_repo_impl', method: 'updateOfferFields');
      return null;
    }
    return null;
  }

  @override
  Future<ApiResponse<List<Food>>?> getOfferFood() async {
    try {
      final response = await _dioClient.getRequest('food/offerFood/${getShopId()}');
      if (response.data != null) {
        final ApiResponse<List<Food>> apiResponse = ApiResponse<List<Food>>.fromJson(
          response.data,
          (json) => (json as List).map((item) => Food.fromJson(item)).toList(),
        );
        return apiResponse;
      }
    } catch (e) {
      //? AppSnackBar.errorSnackBar('Error', e.toString());
      ErrorHandler.handleError(e, isDioError: false, page: 'food_repo_impl', method: 'getOfferFood');
      return null;
    }
    return null;
  }
}
