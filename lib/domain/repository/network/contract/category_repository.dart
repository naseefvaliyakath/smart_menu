import 'package:smart_menu/data/model/category/category.dart';
import '../../../../data/model/api_response/api_response.dart';

abstract class CategoryRepository {
  Future<ApiResponse<List<Category>>?> getAllCategories();
  Future<ApiResponse<Category>?> getCategoryById(int id);
  Future<ApiResponse<Category>?> addCategory(Category category);
  Future<ApiResponse<Category>?> deleteCategory(int id);
}

