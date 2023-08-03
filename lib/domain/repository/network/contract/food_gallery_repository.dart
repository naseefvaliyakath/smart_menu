import 'package:smart_menu/data/model/food_gallery/food_gallery.dart';
import 'package:smart_menu/data/model/food_gallery_category/food_gallery_category.dart';
import '../../../../data/model/api_response/api_response.dart';


abstract class FoodGalleryRepository {
  Future<ApiResponse<List<FoodGalleryItem>>?> getAllFoodGallery();
  Future<ApiResponse<List<FoodGalleryCategory>>?> getAllGalleryCategory();
  //? currently local sorting only using
  Future<ApiResponse<List<FoodGalleryItem>>?> getAllFoodByGalleryCategory({String? catName});
}