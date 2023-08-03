import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_menu/presentation/view/home_page.dart';
import 'constants/colors/app_colors.dart';
import 'core/binding/login_binding.dart';
import 'core/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Digital Menu',
            theme: ThemeData(
              primaryColor: AppColors.mainColor,
              primarySwatch: Colors.amber,
            ),
            initialRoute: AppPages.HOME,
            initialBinding: LoginBinding(),
            unknownRoute: GetPage(name: '/notFount', page: () => const HomePage()),
            defaultTransition: Transition.cupertino,
            getPages: AppPages.routes,
          );
        });
  }
}

//flutter run --release
