import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_menu/constants/dummy_models.dart';
import '../../core/routes/app_pages.dart';
import '../widget/common/app_drawer.dart';
import '../widget/common/common_text/heading_rich_text.dart';
import '../widget/common/dashboard_card.dart';
import '../widget/common/notification_icon.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                          onPressed: () {},
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
                      return DashBoardCard(
                        title: dashboardTitle[index],
                        subTitle: dashboardSubTitle[index],
                        imagePath: 'assets/image/${dashboardImg[index]}',
                        onTap: () {
                          //? food menu
                          if (index == 0) {
                            Get.toNamed(AppPages.FOOD_MENU_PAGE);
                          } else if (index == 1) {
                            Get.toNamed(AppPages.ADD_FOOD_PAGE);
                          }else if (index == 3) {
                            Get.toNamed(AppPages.OFFER_PAGE);
                          }
                        },
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
  }
}
