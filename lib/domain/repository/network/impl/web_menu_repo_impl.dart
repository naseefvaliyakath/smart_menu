import 'package:get/get.dart';
import 'package:smart_menu/data/model/category/category.dart';
import 'package:smart_menu/data/model/web_menu/web_menu.dart';
import 'package:smart_menu/presentation/controller/login_controller.dart';
import '../../../../data/model/api_response/api_response.dart';
import '../../../../data/network/dio_client.dart';
import '../../../../data/network/handle_error.dart';
import '../../../../presentation/widget/snack_bar.dart';
import '../contract/category_repository.dart';
import '../contract/web_menu_repository.dart';

class WebMenuRepositoryImpl implements WebMenuRepository {
  final DioClient _dioClient;

  WebMenuRepositoryImpl(this._dioClient);

  String getShopId() {
    return Get.find<LoginController>().myShop.shopId.toString();
  }

  @override
  Future<ApiResponse<WebMenu>?> getWebMenu(int id) async {
    try {
      final response = await _dioClient.getRequest('webMenu/${getShopId()}');
      if (response.data != null) {
        final ApiResponse<WebMenu> apiResponse =
            ApiResponse<WebMenu>.fromJson(response.data, (json) => WebMenu.fromJson(json as Map<String, dynamic>));
        return apiResponse;
      }
    } catch (e) {
      //? AppSnackBar.errorSnackBar('Error',e.toString());
      ErrorHandler.handleError(e, isDioError: false, page: 'web_menu_repo_impl', method: 'getWebMenu');
      return null;
    }
    return null;
  }

  @override
  Future<ApiResponse<WebMenu>?> updateWebMenu(WebMenu webMenu) async {
    try {
      final Map<String, dynamic> formDataMap = webMenu.toJson();

      final response = await _dioClient.updateData('webMenu', formDataMap);

      if (response.data != null) {
        final ApiResponse<WebMenu> apiResponse = ApiResponse<WebMenu>.fromJson(
          response.data,
          (json) => WebMenu.fromJson(json as Map<String, dynamic>),
        );

        return apiResponse;
      }
    } catch (e) {
    //?  AppSnackBar.errorSnackBar('Error', e.toString());
      ErrorHandler.handleError(e, isDioError: false, page: 'web_menu_repo_impl', method: 'updateWebMenu');
      return null;
    }
    return null;
  }
}
