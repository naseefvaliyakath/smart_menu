import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:smart_menu/presentation/widget/common/conditional_wrapper.dart';
import '../../constants/app_constant_names.dart';
import '../../constants/url.dart';
import '../../core/routes/app_pages.dart';
import '../controller/offer_page_controller.dart';
import '../controller/show_case_controller.dart';
import '../widget/common/loading_page.dart';
import '../widget/common/show_case_widget.dart';
import '../widget/common/two_button-bottom_sheet.dart';
import '../widget/food_offer_card.dart';

class OfferPage extends StatelessWidget {
  final GlobalKey showcaseOfferFoodPageCard = GlobalKey();
   OfferPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(onFinish: () {
      //? after finish tour setting 'showcaseAddFoodPage' as false
      Get.find<ShowcaseController>().setShowcase(KEY_SHOWCASE_OFFER_FOOD_SCREEN_ITEM);
    }, builder: Builder(
      builder: (context) {
        OfferPageController ctrl1 = Get.find<OfferPageController>();
        if (!Get.find<ShowcaseController>().showcaseOfferFoodPageItem) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ShowCaseWidget.of(context).startShowCase([showcaseOfferFoodPageCard]);
          });
        }
        return Scaffold(
          body: GetBuilder<OfferPageController>(
            builder: (ctrl) {
              return RefreshIndicator(
                onRefresh: () async {
                  HapticFeedback.mediumImpact();
                  ctrl.getAllOfferFood();
                },
                child: ctrl.isLoading
                    ? const MyLoading()
                    : SafeArea(
                        child: CustomScrollView(
                          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
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
                              titleTextStyle:
                                  TextStyle(fontSize: 26.sp, color: Colors.black, fontWeight: FontWeight.w600),
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
                              backgroundColor: const Color(0xfffafafa),
                            ),
                            // Replace SliverGrid with SliverList
                            ctrl.myAllFoods.isEmpty
                                ? SliverToBoxAdapter(
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.only(top: 20), // Adjust the padding as needed
                                      child: Text(ctrl.isLoading ? '' : 'No Offers available'),
                                    ),
                                  )
                                : SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                      (BuildContext context, int index) {
                                        return ConditionalWrapper(
                                          condition: ctrl.myAllFoods.isNotEmpty && index == 0,
                                          wrapper: (Widget child) {
                                            return MyShowCase(
                                              showcaseKey: showcaseOfferFoodPageCard,
                                              description: 'Click To Edit & Remove Offer',
                                              targetPadding: 5,
                                              child: child,
                                            );
                                          },
                                          child: InkWell(
                                            onTap: () {
                                              FlexibleBtnBottomSheet.bottomSheet(
                                                context: context,
                                                b1Name: 'Edit Offer',
                                                b2Name: 'Remove Offer',
                                                b3Name: 'Close',
                                                b1Function: () {
                                                  Navigator.pop(context);
                                                  Get.toNamed(
                                                    AppPages.CREATEOFFER_PAGE,
                                                    arguments: {'food': ctrl.myAllFoods[index]},
                                                  );
                                                },
                                                b2Function: () {
                                                  ctrl.removeOffer(ctrl.myAllFoods[index]);
                                                },
                                                b3Function: () {
                                                  Navigator.pop(context);
                                                },
                                              );
                                            },
                                            onLongPress: () {},
                                            child: OfferFoodCard(
                                              img: ctrl.myAllFoods[index].fdImg ?? IMG_LINK,
                                              name: ctrl.myAllFoods[index].fdName ?? 'Error',
                                              price: ctrl.myAllFoods[index].fdFullPrice ?? 0,
                                              priceThreeByTwo: ctrl.myAllFoods[index].fdThreeBiTwoPrsPrice ?? 0,
                                              priceHalf: ctrl.myAllFoods[index].fdHalfPrice ?? 0,
                                              priceQuarter: ctrl.myAllFoods[index].fdQtrPrice ?? 0,
                                              fullPrsTagName: ctrl.myAllFoods[index].fullPrsName ?? 'Full',
                                              threeByTwoPrsName: ctrl.myAllFoods[index].thrByToPrsName ?? '3/4',
                                              halfPrsName: ctrl.myAllFoods[index].halfPrsName ?? 'Half',
                                              quarterPrsName: ctrl.myAllFoods[index].qtrPrsName ?? 'Quarter',
                                              fdIsLoos: ctrl.myAllFoods[index].fdIsLoos ?? 'false',
                                              offerPrice: ctrl.myAllFoods[index].fdOffFullPrice ?? 0,
                                              offerPriceThreeByTwo: ctrl.myAllFoods[index].fdOffThreeByTwoPrice ?? 0,
                                              offerPriceHalf: ctrl.myAllFoods[index].fdOffHalfPrice ?? 0,
                                              offerPriceQuarter: ctrl.myAllFoods[index].fdOffQtrPrice ?? 0,
                                              offerName: ctrl.myAllFoods[index].offerName ?? 'No offer',
                                            ),
                                          ),
                                        );
                                      },
                                      childCount: ctrl.myAllFoods.length,
                                    ),
                                  ),
                          ],
                        ),
                      ),
              );
            },
          ),
        );
      },
    ));
  }
}
