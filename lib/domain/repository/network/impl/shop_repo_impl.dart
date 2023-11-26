import 'package:smart_menu/data/model/api_response/api_response.dart';
import 'package:smart_menu/data/model/app_update_model/app_update_model.dart';
import 'package:smart_menu/data/model/shop/shop.dart';
import '../../../../data/network/dio_client.dart';
import '../../../../presentation/widget/snack_bar.dart';
import '../contract/shop_repository.dart';

class ShopRepositoryImpl implements ShopRepository {
  final DioClient _dioClient;

  ShopRepositoryImpl(this._dioClient);

  @override
  Future<ApiResponse<Shop>?> getShopById(int id) async {
    try {
      final response = await _dioClient.getRequest('shop/$id');
      final ApiResponse<Shop> apiResponse = ApiResponse<Shop>.fromJson(
        response.data,
            (json) => Shop.fromJson(json as Map<String, dynamic>),
      );
      return apiResponse;
    } catch (e) {
      AppSnackBar.errorSnackBar('Error', e.toString());
      return null;
    }
  }

  @override
  Future<ApiResponse<Shop>?> getShopByPhone(String phone) async {
    try {
      final response = await _dioClient.getRequest('shop/getShopByPhone/$phone');
      final ApiResponse<Shop> apiResponse = ApiResponse<Shop>.fromJson(
        response.data,
            (json) => Shop.fromJson(json as Map<String, dynamic>),
      );
      return apiResponse;
    } catch (e) {
      AppSnackBar.errorSnackBar('Error', e.toString());
      return null;
    }
  }

  @override
  Future<ApiResponse<Shop>?> initiateCreateShop(Shop shop) async {
    try {
      final response = await _dioClient.insertWithBody('shop/initiateCreateShop', shop.toJson());
      final ApiResponse<Shop> apiResponse = ApiResponse<Shop>.fromJson(
        response.data,
            (json) => Shop.fromJson(json as Map<String, dynamic>),
      );
      return apiResponse;
    } catch (e) {
      AppSnackBar.errorSnackBar('Error', e.toString());
      return null;
    }
  }

  @override
  Future<ApiResponse<Shop>?> verifyOTPAndCreateShop(Map<String, dynamic> otpData) async {
    try {
      final response = await _dioClient.insertWithBody('shop/verifyOTPAndCreateShop', otpData);
      final ApiResponse<Shop> apiResponse = ApiResponse<Shop>.fromJson(
        response.data,
            (json) => Shop.fromJson(json as Map<String, dynamic>),
      );
      return apiResponse;
    } catch (e) {
      AppSnackBar.errorSnackBar('Error', e.toString());
      return null;
    }
  }


  @override
  Future<ApiResponse<AppUpdateModel>?>  getAppUpdate() async {
    try {
      final response = await _dioClient.getRequest('appUpdate');
      final ApiResponse<AppUpdateModel> apiResponse = ApiResponse<AppUpdateModel>.fromJson(
        response.data,
            (json) => AppUpdateModel.fromJson(json as Map<String, dynamic>),
      );
      return apiResponse;
    } catch (e) {
      return null;
    }
  }

}
