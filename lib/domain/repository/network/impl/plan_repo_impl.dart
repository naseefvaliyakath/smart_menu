import 'package:get/get.dart';
import 'package:smart_menu/data/model/plan/plan.dart';
import 'package:smart_menu/presentation/controller/login_controller.dart';
import '../../../../data/model/api_response/api_response.dart';
import '../../../../data/network/dio_client.dart';
import '../../../../data/network/handle_error.dart';
import '../contract/plan_repository.dart';

class PlanRepositoryImpl implements PlanRepository {
  final DioClient _dioClient;

  PlanRepositoryImpl(this._dioClient);

  String getShopId() {
    return Get.find<LoginController>().myShop.shopId.toString();
  }

  @override
  Future<ApiResponse<List<Plan>>?> getAllPlans() async {
    try {
      final response = await _dioClient.getRequest('plan',showSnack: false);
      if (response.data != null) {
        final ApiResponse<List<Plan>> apiResponse = ApiResponse<List<Plan>>.fromJson(
          response.data,
          (json) => (json as List).map((item) => Plan.fromJson(item)).toList(),
        );
        return apiResponse;
      }
    } catch (e) {
      //?  AppSnackBar.errorSnackBar('Error',e.toString());
      ErrorHandler.handleError(e, isDioError: false, page: 'plan_repo_impl', method: 'getAllPlans');
      return null;
    }
    return null;
  }

  @override
  Future<ApiResponse<Plan>?> getPlanById(int id) async {
    try {
      final response = await _dioClient.getRequest('plan/$id');
      if (response.data != null) {
        final ApiResponse<Plan> apiResponse =
            ApiResponse<Plan>.fromJson(response.data, (json) => Plan.fromJson(json as Map<String, dynamic>));
        return apiResponse;
      }
    } catch (e) {
      //? AppSnackBar.errorSnackBar('Error', e.toString());
      ErrorHandler.handleError(e, isDioError: false, page: 'plan_repo_impl', method: 'getPlanById');
      return null;
    }
    return null;
  }


}
