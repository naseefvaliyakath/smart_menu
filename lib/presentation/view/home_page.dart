import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:smart_menu/constants/dummy_models.dart';
import 'package:smart_menu/presentation/controller/login_controller.dart';
import 'package:smart_menu/presentation/widget/common/show_case_widget.dart';
import '../../constants/app_constant_names.dart';
import '../../core/routes/app_pages.dart';
import '../controller/show_case_controller.dart';
import '../widget/common/app_drawer.dart';
import '../widget/common/common_text/heading_rich_text.dart';
import '../widget/common/dashboard_card.dart';
import '../widget/common/notification_icon.dart';

class HomePage extends StatelessWidget {
  final GlobalKey showcaseAddFoodCard = GlobalKey();
  final GlobalKey showcaseMenuCard = GlobalKey();
  final GlobalKey showcaseOfferFood = GlobalKey();
  final GlobalKey showcaseMenuBookWeb = GlobalKey();
  final GlobalKey showcaseQrCode = GlobalKey();
  final GlobalKey showcaseSettings = GlobalKey();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(onFinish: () {
      //? after finish tour setting 'showcaseAddFoodPage' as false
      Get.find<ShowcaseController>().setShowcase(KEY_SHOWCASE_HOME_PAGE);
    }, builder: Builder(builder: (context) {
      return Scaffold(
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final availableHeight = constraints.maxHeight - 16; // Deduct padding
              final cardHeight = availableHeight / 3; // Divide by number of rows
              final cardWidth = MediaQuery.of(context).size.width / 2; // Divide by number of columns

              return Column(
                children: [
                  10.verticalSpace,
                  Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                            icon: Icon(
                              Icons.menu,
                              size: 34.sp,
                            )),
                        const HeadingRichText(name: 'Digital Menu'),
                        NotificationIcon(
                          onTap: () async {},
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: GridView.count(
                      padding: EdgeInsets.all(16.sp),
                      crossAxisCount: 2,
                      childAspectRatio: cardWidth / cardHeight,
                      mainAxisSpacing: 16.w,
                      crossAxisSpacing: 16.w,
                      children: List.generate(6, (index) {
                        return MyShowCase(
                          showcaseKey: index == 0
                              ? showcaseAddFoodCard
                              : index == 1
                                  ? showcaseMenuCard
                                  : index == 2
                                      ? showcaseOfferFood
                                      : index == 3
                                          ? showcaseMenuBookWeb
                                          : index == 4
                                              ? showcaseQrCode
                                              : showcaseSettings,
                          description: homePageShowCaseDescription[index],
                          title: homePageShowCaseTitle[index],
                          targetPadding: 5,
                          child: DashBoardCard(
                            title: dashboardTitle[index],
                            subTitle: dashboardSubTitle[index],
                            imagePath: 'assets/image/${dashboardImg[index]}',
                            onTap: () async {
                              //? show showcase at first time if any tab is click
                              bool show = !Get.find<ShowcaseController>().showcaseHomePage ?? false;
                              if (show) {
                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                  ShowCaseWidget.of(context).startShowCase([
                                    showcaseAddFoodCard,
                                    showcaseMenuCard,
                                    showcaseOfferFood,
                                    showcaseMenuBookWeb,
                                    showcaseQrCode,
                                  ]);
                                });
                              } else {
                                //? food menu
                                if (index == 0) {
                                  Get.toNamed(AppPages.ADD_FOOD_PAGE);
                                } else if (index == 1) {
                                  Get.toNamed(AppPages.FOOD_MENU_PAGE);
                                } else if (index == 2) {
                                  Get.toNamed(AppPages.OFFER_PAGE);
                                } else if (index == 3) {
                                  Get.toNamed(AppPages.WEB_MENU_PAGE);
                                } else if (index == 4) {
                                  Get.toNamed(AppPages.QR_CODE_PAGE);
                                } else if (index == 5) {
                                  const storage = FlutterSecureStorage();
                                  // await storage.delete(key: KEY_TOKEN);
                                  Get.find<LoginController>().checkAppUpdate();
                                }
                              }
                            },
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        drawer: const AppDrawer(),
      );
    }));
  }
}
