import 'package:smart_menu/data/model/category/category.dart';
import 'package:smart_menu/data/model/item_purchase_model/item_purchase_model.dart';
import '../../../../data/model/api_response/api_response.dart';
import '../../../../data/model/app_update_model/app_update_model.dart';
import '../../../../data/model/shop/shop.dart';

abstract class ShopRepository {
  Future<ApiResponse<Shop>?> getShopById(int id);
  Future<ApiResponse<Shop>?> updateShop(dynamic body);
  Future<ApiResponse<Shop>?> getShopByPhone(String phone);
  Future<ApiResponse<Shop>?> initiateCreateShop(Shop shop,String otpType);
  Future<ApiResponse<Shop>?> verifyOTPAndCreateShop(Map<String,dynamic> otpData);
  Future<ApiResponse<AppUpdateModel>?>  getAppUpdate();
  Future<ApiResponse<List<ItemPurchaseModel>>?> getAllPurchaseItem();

}


