import 'package:get/get.dart';
import 'package:smart_menu/data/model/api_response/api_response.dart';
import 'package:smart_menu/data/model/app_update_model/app_update_model.dart';
import 'package:smart_menu/data/model/item_purchase_model/item_purchase_model.dart';
import 'package:smart_menu/data/model/shop/shop.dart';
import '../../../../data/network/dio_client.dart';
import '../../../../data/network/handle_error.dart';
import '../../../../presentation/controller/login_controller.dart';
import '../contract/shop_repository.dart';

class ShopRepositoryImpl implements ShopRepository {
  final DioClient _dioClient;

  ShopRepositoryImpl(this._dioClient);

  String getShopId() {
    return Get.find<LoginController>().myShop.shopId.toString();
  }

  @override
  Future<ApiResponse<Shop>?> getShopById(int id) async {
    try {
      final response = await _dioClient.getRequest('shop/$id');
      if (response.data != null) {
        final ApiResponse<Shop> apiResponse = ApiResponse<Shop>.fromJson(
          response.data,
          (json) => Shop.fromJson(json as Map<String, dynamic>),
        );
        return apiResponse;
      }
    } catch (e) {
      //? AppSnackBar.errorSnackBar('Error', e.toString());
      ErrorHandler.handleError(e, isDioError: false, page: 'shop_repo_impl', method: 'getShopById');
      return null;
    }
    return null;
  }

  @override
  Future<ApiResponse<Shop>?> getShopByPhone(String phone) async {
    try {
      final response = await _dioClient.getRequest('shop/getShopByPhone/$phone');
      if (response.data != null) {
        final ApiResponse<Shop> apiResponse = ApiResponse<Shop>.fromJson(
          response.data,
          (json) => Shop.fromJson(json as Map<String, dynamic>),
        );
        return apiResponse;
      }
    } catch (e) {
      //?  AppSnackBar.errorSnackBar('Error', e.toString());
      ErrorHandler.handleError(e, isDioError: false, page: 'shop_repo_impl', method: 'getShopByPhone');
      return null;
    }
    return null;
  }

  @override
  Future<ApiResponse<Shop>?> updateShop(dynamic body) async {
    try {
      final response = await _dioClient.updateData('shop/${getShopId()}',body);
      if (response.data != null) {
        final ApiResponse<Shop> apiResponse = ApiResponse<Shop>.fromJson(
          response.data,
              (json) => Shop.fromJson(json as Map<String, dynamic>),
        );
        return apiResponse;
      }
    } catch (e) {
      //? AppSnackBar.errorSnackBar('Error', e.toString());
      ErrorHandler.handleError(e, isDioError: false, page: 'shop_repo_impl', method: 'updateShop');
      return null;
    }
    return null;
  }

  @override
  Future<ApiResponse<Shop>?> initiateCreateShop(Shop shop,String otpType) async {
    try {
      final response = await _dioClient.insertWithBody('shop/initiateCreateShop/$otpType', shop.toJson());
      if (response.data != null) {
        final ApiResponse<Shop> apiResponse = ApiResponse<Shop>.fromJson(
          response.data,
          (json) => Shop.fromJson(json as Map<String, dynamic>),
        );
        return apiResponse;
      }
    } catch (e) {
      //? AppSnackBar.errorSnackBar('Error', e.toString());
      ErrorHandler.handleError(e, isDioError: false, page: 'shop_repo_impl', method: 'initiateCreateShop');
      return null;
    }
    return null;
  }

  @override
  Future<ApiResponse<Shop>?> verifyOTPAndCreateShop(Map<String, dynamic> otpData) async {
    try {
      final response = await _dioClient.insertWithBody('shop/verifyOTPAndCreateShop', otpData);
      if (response.data != null) {
        final ApiResponse<Shop> apiResponse = ApiResponse<Shop>.fromJson(
          response.data,
          (json) => Shop.fromJson(json as Map<String, dynamic>),
        );
        return apiResponse;
      }
    } catch (e) {
      //?  AppSnackBar.errorSnackBar('Error', e.toString());
      ErrorHandler.handleError(e, isDioError: false, page: 'shop_repo_impl', method: 'verifyOTPAndCreateShop');
      return null;
    }
    return null;
  }

  @override
  Future<ApiResponse<AppUpdateModel>?> getAppUpdate() async {
    try {
      final response = await _dioClient.getRequest('appUpdate',showSnack: false);
      if (response.data != null) {
        final ApiResponse<AppUpdateModel> apiResponse = ApiResponse<AppUpdateModel>.fromJson(
          response.data,
          (json) => AppUpdateModel.fromJson(json as Map<String, dynamic>),
        );
        return apiResponse;
      }
    } catch (e) {
      ErrorHandler.handleError(e, isDioError: false, page: 'shop_repo_impl', method: 'getAppUpdate');
      return null;
    }
    return null;
  }

  @override
  Future<ApiResponse<List<ItemPurchaseModel>>?> getAllPurchaseItem() async {
    try {
      final response = await _dioClient.getRequest('itemPurchase/');
      if (response.data != null) {
        final ApiResponse<List<ItemPurchaseModel>> apiResponse = ApiResponse<List<ItemPurchaseModel>>.fromJson(
          response.data,
          (json) => (json as List).map((item) => ItemPurchaseModel.fromJson(item)).toList(),
        );
        return apiResponse;
      }
    } catch (e) {
      //?  AppSnackBar.errorSnackBar('Error',e.toString());
      ErrorHandler.handleError(e, isDioError: false, page: 'shop_repo_impl', method: 'getAllPurchaseItem');
      return null;
    }
    return null;
  }
}
