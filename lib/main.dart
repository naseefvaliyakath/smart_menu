import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_menu/presentation/controller/login_controller.dart';
import 'package:smart_menu/presentation/view/home_page.dart';
import 'constants/colors/app_colors.dart';
import 'core/binding/login_binding.dart';
import 'core/routes/app_pages.dart';
import 'data/network/dio_client.dart';
import 'domain/repository/network/contract/shop_repository.dart';
import 'domain/repository/network/impl/shop_repo_impl.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  Get.put<DioClient>(DioClient(), permanent: true);
  Get.put<ShopRepository>(ShopRepositoryImpl(Get.find()), permanent: true);
  Get.put<LoginController>(LoginController(), permanent: true);
  await Get.find<LoginController>().checkIsAuthenticated();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return ScreenUtilInit(
        designSize: const Size(411, 843),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          final isAuthenticated = Get.find<LoginController>().isAuthenticated;
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Digital Menu',
            theme: ThemeData(
              primaryColor: AppColors.mainColor,
              primarySwatch: Colors.amber,
            ),
            initialRoute:isAuthenticated ? AppPages.HOME : AppPages.LOGIN_PAGE,
            initialBinding: LoginBinding(),
            unknownRoute: GetPage(name: '/notFount', page: () => const HomePage()),
            defaultTransition: Transition.cupertino,
            getPages: AppPages.routes,
          );
        });
  }
}

//flutter run --release
