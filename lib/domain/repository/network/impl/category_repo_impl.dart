import 'package:get/get.dart';
import 'package:smart_menu/data/model/category/category.dart';
import 'package:smart_menu/presentation/controller/login_controller.dart';
import '../../../../data/model/api_response/api_response.dart';
import '../../../../data/network/dio_client.dart';
import '../../../../presentation/widget/snack_bar.dart';
import '../contract/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final DioClient _dioClient;
  CategoryRepositoryImpl(this._dioClient);

  String getShopId() {
    return Get.find<LoginController>().myShop.shopId.toString();
  }

  @override
  Future<ApiResponse<List<Category>>?> getAllCategories() async {
    try {
      final response = await _dioClient.getRequest('category/${getShopId()}');
      final ApiResponse<List<Category>> apiResponse = ApiResponse<List<Category>>.fromJson(
        response.data,
            (json) => (json as List).map((item) => Category.fromJson(item)).toList(),
      );
      return apiResponse;
    } catch (e) {
     //?  AppSnackBar.errorSnackBar('Error',e.toString());
      return null;
    }
  }


  @override
  Future<ApiResponse<Category>?> getCategoryById(int id) async {
    try {
      final response = await _dioClient.getRequest('category/$id/${getShopId()}');
      final ApiResponse<Category> apiResponse = ApiResponse<Category>.fromJson(
          response.data,
              (json) => Category.fromJson(json as Map<String, dynamic>)
      );
      return apiResponse;
    } catch (e) {
      AppSnackBar.errorSnackBar('Error',e.toString());
      return null;
    }
  }

  @override
  Future<ApiResponse<Category>?> addCategory(Category category) async {
    try {
      final Map<String, dynamic> formDataMap = category.toJson();

      final response = await _dioClient.insertWithBody('category', formDataMap);

      final ApiResponse<Category> apiResponse = ApiResponse<Category>.fromJson(
        response.data,
            (json) => Category.fromJson(json as Map<String, dynamic>),
      );

      return apiResponse;
    } catch (e) {
      AppSnackBar.errorSnackBar('Error', e.toString());
      return null;
    }
  }


  @override
  Future<ApiResponse<Category>?> deleteCategory(int id) async {
    try {
      final response = await _dioClient.delete('category/${id.toString()}/${getShopId()}');

      final ApiResponse<Category> apiResponse = ApiResponse<Category>.fromJson(
        response.data,
            (json) => Category.fromJson(json as Map<String, dynamic>),
      );

      return apiResponse;
    } catch (e) {
      AppSnackBar.errorSnackBar('Error', e.toString());
      return null;
    }
  }





}
