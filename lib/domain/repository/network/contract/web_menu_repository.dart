import 'package:smart_menu/data/model/category/category.dart';
import 'package:smart_menu/data/model/web_menu/web_menu.dart';
import '../../../../data/model/api_response/api_response.dart';

abstract class WebMenuRepository {
  Future<ApiResponse<WebMenu>?> getWebMenu(int shopId);
  Future<ApiResponse<WebMenu>?> updateWebMenu(WebMenu webMenu);
}

