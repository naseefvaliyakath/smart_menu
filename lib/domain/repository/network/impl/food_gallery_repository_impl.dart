import 'package:dio/dio.dart';
import 'package:smart_menu/data/model/food_gallery/food_gallery.dart';
import 'package:smart_menu/data/model/food_gallery_category/food_gallery_category.dart';
import 'package:smart_menu/domain/repository/network/contract/food_gallery_repository.dart';
import '../../../../data/model/api_response/api_response.dart';
import '../../../../data/network/dio_client.dart';
import '../../../../data/network/handle_error.dart';
import '../../../../presentation/widget/snack_bar.dart';

class FoodGalleryRepositoryImpl implements FoodGalleryRepository {
  final DioClient _dioClient;

  FoodGalleryRepositoryImpl(this._dioClient);

  @override
  Future<ApiResponse<List<FoodGalleryItem>>?> getAllFoodGallery() async {
    try {
      Response response = await _dioClient.getRequest('foodGallery',showSnack: false);
      if (response.data != null) {
        final ApiResponse<List<FoodGalleryItem>> apiResponse = ApiResponse<List<FoodGalleryItem>>.fromJson(
          response.data,
          (json) => (json as List).map((item) => FoodGalleryItem.fromJson(item)).toList(),
        );
        return apiResponse;
      }
      return null;
    } catch (e) {
      ErrorHandler.handleError(e, isDioError: false, page: 'food_gallery_repo_impl', method: 'getAllFoodGallery');
      return null;
    }
  }

  @override
  Future<ApiResponse<List<FoodGalleryItem>>?> getAllFoodByGalleryCategory({String? catName = ''}) async {
    try {
      final response = await _dioClient.getRequest('foodGallery/foodByGalleryCategory?category=$catName');
      if (response.data != null) {
        final ApiResponse<List<FoodGalleryItem>> apiResponse = ApiResponse<List<FoodGalleryItem>>.fromJson(
          response.data,
          (json) => (json as List).map((item) => FoodGalleryItem.fromJson(item)).toList(),
        );
        return apiResponse;
      }
    } catch (e) {
      //? AppSnackBar.errorSnackBar('Error', e.toString());
      ErrorHandler.handleError(e, isDioError: false, page: 'food_gallery_repo_impl', method: 'getAllFoodByGalleryCategory');
      return null;
    }
    return null;
  }

  @override
  Future<ApiResponse<List<FoodGalleryCategory>>?> getAllGalleryCategory() async {
    try {
      final response = await _dioClient.getRequest('foodGallery/galleryCategory',showSnack: false);
      if (response.data != null) {
        final ApiResponse<List<FoodGalleryCategory>> apiResponse = ApiResponse<List<FoodGalleryCategory>>.fromJson(
          response.data,
          (json) => (json as List).map((item) => FoodGalleryCategory.fromJson(item)).toList(),
        );
        return apiResponse;
      }
    } catch (e) {
      //?  AppSnackBar.errorSnackBar('Error',e.toString());
      ErrorHandler.handleError(e, isDioError: false, page: 'food_gallery_repo_impl', method: 'getAllGalleryCategory');
      return null;
    }
    return null;
  }
}
