import 'package:get/get.dart';
import 'package:smart_menu/domain/repository/network/contract/shop_repository.dart';
import 'package:smart_menu/domain/repository/network/impl/shop_repo_impl.dart';
import 'package:smart_menu/presentation/controller/login_controller.dart';
import '../../constants/app_constant_names.dart';
import '../../data/network/dio_client.dart';

class LoginBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    Get.put<DioClient>(DioClient(), permanent: true);
    Get.put<ShopRepository>(ShopRepositoryImpl(Get.find()), permanent: true);
    Get.lazyPut(() => LoginController());
  }
}
