import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_menu/constants/app_constant_names.dart';
import 'package:smart_menu/core/routes/app_pages.dart';
import '../../constants/colors/app_colors.dart';
import '../../constants/url.dart';
import '../controller/food_menu_controller.dart';
import '../widget/common/catogory_card.dart';
import '../widget/common/food_card.dart';
import '../widget/common/loading_page.dart';
import '../widget/common/shimming_effect.dart';
import '../widget/common/two_button-bottom_sheet.dart';

class FoodMenuPage extends StatelessWidget {
  const FoodMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>?;
    if (arguments != null && arguments.containsKey('from') && (arguments['from'] == 'update')) {
      Get.find<FoodMenuController>().getAllFood(showSnack: false);
    }
    return Scaffold(
      body: GetBuilder<FoodMenuController>(builder: (ctrl) {
        return RefreshIndicator(
          onRefresh: () async {
            //? to vibrate
            HapticFeedback.mediumImpact();
            ctrl.getAllCategory();
            ctrl.getAllFood();
          },
          child: ctrl.isLoading
              ? const MyLoading()
              : SafeArea(
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    primary: false,
                    slivers: <Widget>[
                      SliverAppBar(
                        floating: true,
                        pinned: true,
                        snap: true,
                        title: const Text(
                          'Manage Menu',
                          overflow: TextOverflow.fade,
                          softWrap: false,
                        ),
                        titleTextStyle: TextStyle(fontSize: 26.sp, color: Colors.black, fontWeight: FontWeight.w600),
                        actions: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.settings,
                                size: 24.sp,
                              )),
                        ],
                        leading: BackButton(
                          onPressed: () {
                            Get.back();
                          },
                        ),
                        //? search bar and sort icon

                        bottom: PreferredSize(
                          preferredSize: Size.fromHeight(60.h),
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.0.w, right: 10.w),
                            child: SizedBox(
                              height: 60.h,
                              child: ctrl.isLoadingCategory == true
                                  ? const ShimmingEffect()
                                  : ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: ctrl.myCategory.length + 5,
                                      itemBuilder: (BuildContext ctx, index) {
                                        if (index < 5) {
                                          // Local categories
                                          String text = '';
                                          switch (index) {
                                            case 0:
                                              text = "All";
                                              break;
                                            case 1:
                                              text = "Special";
                                              break;
                                            case 2:
                                              text = "Available";
                                              break;
                                            case 3:
                                              text = "Quick";
                                              break;
                                            case 4:
                                              text = "Offer";
                                              break;
                                          }
                                          return CategoryCard(
                                            onTap: () {
                                              ctrl.setCategoryTappedIndex(
                                                  index, -1); // Pass -1 as id for local categories
                                            },
                                            color: ctrl.tappedIndex == index ? AppColors.mainColor_2 : Colors.white,
                                            text: text,
                                            onLongTap: () async {},
                                            indexForColour: index,
                                          );
                                        } else {
                                          // Fetched categories
                                          final categoryIndex = index - 5; // Adjust index for fetched categories
                                          return CategoryCard(
                                            onTap: () {
                                              ctrl.setCategoryTappedIndex(
                                                  index, ctrl.myCategory[categoryIndex].id ?? -1);
                                            },
                                            color: ctrl.tappedIndex == index ? AppColors.mainColor_2 : Colors.white,
                                            text: ctrl.myCategory[categoryIndex].name ?? COMMON_CATEGORY,
                                            onLongTap: () async {},
                                          );
                                        }
                                      },
                                    ),
                            ),
                          ),
                        ),
                        backgroundColor: const Color(0xfffafafa),
                      ),
                      //? body section
                      SliverPadding(
                        padding: EdgeInsets.all(20.sp),
                        sliver: SliverGrid(
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200.0.sp,
                            mainAxisSpacing: 18.sp,
                            crossAxisSpacing: 18.sp,
                            childAspectRatio: 2 / 2.5,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  FlexibleBtnBottomSheet.bottomSheet(
                                    context: context,
                                    b1Name: ctrl.myAllFoods[index].fdIsToday == 'false'
                                        ? 'Add To Today'
                                        : 'Remove From Today',
                                    b2Name: ctrl.myAllFoods[index].fdIsAvailable == 'false'
                                        ? 'Add To Available'
                                        : 'Remove From Available',
                                    b3Name: ctrl.myAllFoods[index].fdIsHide == 'false' ? 'Hide Food' : 'Visible Food',
                                    b4Name: ctrl.myAllFoods[index].fdIsQuick == 'false'
                                        ? 'Add To Quick'
                                        : 'Remove From Quick',
                                    b5Name: ctrl.myAllFoods[index].offer == 'false' ? 'Set Offer' : 'Remove Offer',
                                    b6Name: 'Edit Food',
                                    b7Name: 'Delete Food',
                                    b1Function: () {
                                      ctrl.updateSelectedField(ctrl.myAllFoods[index], field: 'today');
                                      Navigator.pop(context);
                                    },
                                    b2Function: () {
                                      ctrl.updateSelectedField(ctrl.myAllFoods[index], field: 'available');
                                      Navigator.pop(context);
                                    },
                                    b3Function: () {
                                      ctrl.updateSelectedField(ctrl.myAllFoods[index], field: 'hide');
                                      Navigator.pop(context);
                                    },
                                    b4Function: () {
                                      ctrl.updateSelectedField(ctrl.myAllFoods[index], field: 'quick');
                                      Navigator.pop(context);
                                    },
                                    b5Function: () {
                                      ctrl.setAndRemoveOffer(ctrl.myAllFoods[index]);
                                    },
                                    b6Function: () {
                                      Navigator.pop(context);
                                      Get.offNamed(
                                        AppPages.ADD_FOOD_PAGE,
                                        arguments: {
                                          'food': ctrl.myAllFoods[index],
                                        },
                                      );
                                    },
                                    b7Function: () async {
                                      Navigator.pop(context);
                                      ctrl.deleteFood(
                                          ctrl.myAllFoods[index].id ?? 0, ctrl.myAllFoods[index].fdImg ?? '');
                                    },
                                  );
                                },
                                onLongPress: () {},
                                child: FoodCard(
                                  img: ctrl.myAllFoods[index].fdImg ?? IMG_LINK,
                                  name: ctrl.myAllFoods[index].fdName ?? 'Error',
                                  price: ctrl.myAllFoods[index].fdFullPrice ?? 0,
                                  priceThreeByTwo: ctrl.myAllFoods[index].fdThreeBiTwoPrsPrice ?? 0,
                                  priceHalf: ctrl.myAllFoods[index].fdHalfPrice ?? 0,
                                  priceQuarter: ctrl.myAllFoods[index].fdQtrPrice ?? 0,
                                  fullPrsTagName: ctrl.myAllFoods[index].fullPrsName ?? 'Full',
                                  threeByTwoPrsName: ctrl.myAllFoods[index].thrByToPrsName ??'3/4',
                                  halfPrsName: ctrl.myAllFoods[index].halfPrsName ?? 'Half',
                                  quarterPrsName: ctrl.myAllFoods[index].qtrPrsName ?? 'Quarter',
                                  today: ctrl.myAllFoods[index].fdIsToday ?? 'false',
                                  available: ctrl.myAllFoods[index].fdIsAvailable ?? 'false',
                                  quick: ctrl.myAllFoods[index].fdIsQuick ?? 'false',
                                  hide: ctrl.myAllFoods[index].fdIsHide ?? 'false',
                                  offer: ctrl.myAllFoods[index].offer ?? 'false',
                                  fdIsLoos: ctrl.myAllFoods[index].fdIsLoos ?? 'false',
                                ),
                              );
                            },
                            childCount: ctrl.myAllFoods.length,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        );
      }),
    );
  }
}
