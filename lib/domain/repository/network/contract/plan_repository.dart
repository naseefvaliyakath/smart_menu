import 'package:smart_menu/data/model/category/category.dart';
import 'package:smart_menu/data/model/plan/plan.dart';
import '../../../../data/model/api_response/api_response.dart';

abstract class PlanRepository {
  Future<ApiResponse<List<Plan>>?> getAllPlans();
  Future<ApiResponse<Plan>?> getPlanById(int id);
}

