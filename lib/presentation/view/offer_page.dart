import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../constants/app_constant_names.dart';
import '../../constants/colors/app_colors.dart';
import '../../constants/url.dart';
import '../../core/routes/app_pages.dart';
import '../controller/food_menu_controller.dart';
import '../controller/offer_page_controller.dart';
import '../widget/common/catogory_card.dart';
import '../widget/common/food_card.dart';
import '../widget/common/loading_page.dart';
import '../widget/common/shimming_effect.dart';
import '../widget/common/two_button-bottom_sheet.dart';
import '../widget/food_offer_card.dart';
import 'create_offer_page.dart';

class OfferPage extends StatelessWidget {
  const OfferPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OfferPageController>(builder: (ctrl) {
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
                          'MANAGE OFFER',
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
                        padding: EdgeInsets.all(0.sp),
                        sliver: SliverGrid(
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: MediaQuery.of(context).size.width, // changes made here
                            mainAxisSpacing: 0.sp,
                            crossAxisSpacing: 5.sp,
                            childAspectRatio: 1 / 1,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  FlexibleBtnBottomSheet.bottomSheet(
                                    b1Name:  'Edit Offer',
                                    b2Name:  'Remove Offer',
                                    b3Name: 'Close',
                                    b1Function: () {
                                      Navigator.pop(context);
                                      Get.toNamed(
                                        AppPages.CREATEOFFER_PAGE,
                                        arguments: {'food': ctrl.myAllFoods[index]},
                                      );
                                    },
                                    b2Function: () {
                                      Navigator.pop(context);
                                    },
                                    b3Function: () {
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                                onLongPress: () {},
                                child: OfferFoodCard(
                                  img: ctrl.myAllFoods[index].fdImg ?? IMG_LINK,
                                  name: 'Burger with cream',
                                  price: 100,
                                  offerPrice: 50,
                                  offerName: 'Buy one get 1',
                                  priceThreeByTwo: 80,
                                  priceHalf: 70,
                                  priceQuarter: 60,
                                  fdIsLoos: 'true',
                                  offerPriceThreeByTwo: 10,
                                  offerPriceHalf: 20,
                                  offerPriceQuarter: 30,
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
