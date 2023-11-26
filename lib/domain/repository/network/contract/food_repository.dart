
import 'dart:io';

import 'package:smart_menu/data/model/food/food.dart';
import '../../../../data/model/api_response/api_response.dart';

abstract class FoodRepository {
  Future<ApiResponse<List<Food>>?> getAllFood();
  Future<ApiResponse<List<Food>>?> getOfferFood();
  Future<ApiResponse<Food>?> getFoodById(int id);
  Future<ApiResponse<Food>?> addFood(Food food,File? img);
  Future<ApiResponse<Food>?> updateFood(Food food, File? img);
  Future<ApiResponse<Food>?> deleteFood(int id,String imgName);
  Future<ApiResponse<Food>?> updateSelectedFields( Food updates);
  Future<ApiResponse<Food>?> updateOfferFields( Food updates);

}
