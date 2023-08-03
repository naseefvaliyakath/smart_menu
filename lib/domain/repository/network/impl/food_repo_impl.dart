import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smart_menu/data/model/food/food.dart';
import '../../../../data/model/api_response/api_response.dart';
import '../../../../data/network/dio_client.dart';
import '../../../../presentation/widget/snack_bar.dart';
import '../contract/food_repository.dart';

class FoodRepositoryImpl implements FoodRepository {
  final DioClient _dioClient;

  FoodRepositoryImpl(this._dioClient);

  @override
  Future<ApiResponse<List<Food>>?> getAllFood() async {
    try {
      final response = await _dioClient.getRequest('food');
      final ApiResponse<List<Food>> apiResponse = ApiResponse<List<Food>>.fromJson(
        response.data,
            (json) => (json as List).map((item) => Food.fromJson(item)).toList(),
      );
      return apiResponse;
    } catch (e) {
      AppSnackBar.errorSnackBar('Error',e.toString());
      return null;
    }
  }

  @override
  Future<ApiResponse<Food>?> getFoodById(int id) async {
    try {
      final response = await _dioClient.getRequestWithBody('food/${id.toString()}', {'id': id});
      final ApiResponse<Food> apiResponse = ApiResponse<Food>.fromJson(
          response.data,
              (json) => Food.fromJson(json as Map<String, dynamic>)
      );
      return apiResponse;
    } catch (e) {
      AppSnackBar.errorSnackBar('Error',e.toString());
      return null;
    }
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

      final response = await _dioClient.postMultipart('food', formData);

      final ApiResponse<Food> apiResponse = ApiResponse<Food>.fromJson(
        response.data,
            (json) => Food.fromJson(json as Map<String, dynamic>),
      );

      return apiResponse;
    } catch (e) {
      AppSnackBar.errorSnackBar('Error', e.toString());
      return null;
    }
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

      final response = await _dioClient.putMultipart('food', formData);

      final ApiResponse<Food> apiResponse = ApiResponse<Food>.fromJson(
        response.data,
            (json) => Food.fromJson(json as Map<String, dynamic>),
      );

      return apiResponse;
    } catch (e) {
      AppSnackBar.errorSnackBar('Error', e.toString());
      return null;
    }
  }


  @override
  Future<ApiResponse<Food>?> deleteFood(int id) async {
    try {
      final response = await _dioClient.delete('food/$id');
      final ApiResponse<Food> apiResponse = ApiResponse<Food>.fromJson(
        response.data,
            (json) => Food.fromJson(json as Map<String, dynamic>),
      );
      return apiResponse;
    } catch (e) {
      AppSnackBar.errorSnackBar('Error', e.toString());
      return null;
    }
  }



  @override
  Future<ApiResponse<Food>?> updateSelectedFields(Food food) async {
    try {
      final response = await _dioClient.updateData('food/updateSelected', {
        'id': food.id,
        'fdIsToday': food.fdIsToday,
        'fdIsAvailable': food.fdIsAvailable,
        'fdIsSpecial': food.fdIsSpecial,
        'offer': food.offer,
        'fdIsQuick': food.fdIsQuick,
      });
      final ApiResponse<Food> apiResponse = ApiResponse<Food>.fromJson(
        response.data,
            (json) => Food.fromJson(json as Map<String, dynamic>),
      );
      return apiResponse;
    } catch (e) {
      AppSnackBar.errorSnackBar('Error', e.toString());
      return null;
    }
  }


}
