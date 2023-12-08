import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_menu/constants/url.dart';
import 'package:smart_menu/presentation/controller/offer_page_controller.dart';
import 'package:smart_menu/presentation/widget/common/common_text/mid_text.dart';
import 'package:smart_menu/presentation/widget/common/common_text/small_text.dart';
import '../../constants/colors/app_colors.dart';
import '../controller/create_offer_controller.dart';
import '../widget/common/buttons/round_border_button.dart';
import '../widget/common/common_text/big_text.dart';
import '../widget/common/common_text/heading_rich_text.dart';
import '../widget/common/loading_page.dart';
import '../widget/common/my_toggle_switch.dart';
import '../widget/common/network_img_card.dart';
import '../widget/common/notification_icon.dart';
import '../widget/common/text_field_widget.dart';
import '../widget/food_offer_card.dart';

class CreateOfferPage extends StatelessWidget {
  const CreateOfferPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CreateOfferController>(builder: (ctrl) {
        return ctrl.isLoading == true
            ? const MyLoading()
            : RefreshIndicator(
                onRefresh: () async {},
                child: GestureDetector(
                  onTap: () {
                    //? close keyboard on outside click in ios
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: SafeArea(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                        Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Form(
                            key: ctrl.offerFormKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //? heading , notification icon and back btn
                                Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      //? back arrow and heading text
                                      Flexible(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            BackButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                            ),
                                            15.horizontalSpace,
                                            const HeadingRichText(name: 'Set Offer'),
                                          ],
                                        ),
                                      ),
                                      //? notification icon
                                      NotificationIcon(onTap: () {}),
                                    ],
                                  ),
                                ),
                                15.verticalSpace,
                                OfferFoodCard(
                                  img: ctrl.offerFood?.fdImg ?? IMG_LINK,
                                  name: ctrl.offerFood?.fdName ?? 'Error',
                                  price: ctrl.offerFood?.fdFullPrice ?? 0,
                                  priceThreeByTwo:ctrl.offerFood?.fdThreeBiTwoPrsPrice ?? 0,
                                  priceHalf: ctrl.offerFood?.fdHalfPrice ?? 0,
                                  priceQuarter: ctrl.offerFood?.fdQtrPrice ?? 0,
                                  fullPrsTagName: ctrl.offerFood?.fullPrsName ?? 'Full',
                                  threeByTwoPrsName: ctrl.offerFood?.thrByToPrsName ?? '3/4',
                                  halfPrsName: ctrl.offerFood?.halfPrsName ?? 'Half',
                                  quarterPrsName: ctrl.offerFood?.qtrPrsName ?? 'Quarter',
                                  fdIsLoos: ctrl.offerFood?.fdIsLoos ?? 'false',
                                  offerPrice: ctrl.offerFood?.fdOffFullPrice ?? 0,
                                  offerPriceThreeByTwo: ctrl.offerFood?.fdOffThreeByTwoPrice ?? 0,
                                  offerPriceHalf:ctrl.offerFood?.fdOffHalfPrice ?? 0,
                                  offerPriceQuarter: ctrl.offerFood?.fdOffQtrPrice ?? 0,
                                  offerName: ctrl.offerFood?.offerName ?? 'No offer',
                                ),
                                20.verticalSpace,
                                //? food name text-field
                                BigText(
                                  text: 'Offer Name ',
                                  size: 14.sp,
                                  color: AppColors.mainColor_2,
                                ),
                                5.verticalSpace,
                                TextFieldWidget(
                                  hintText: 'Enter Your Offer Name ....',
                                  textEditingController: ctrl.fdOffNameTD,
                                  requiredField: true,
                                  borderRadius: 15.r,
                                  txtLength: 35,
                                  onChange: (_) {},
                                ),
                                20.verticalSpace,
                                // price text-field
                                Row(
                                  children: [
                                    BigText(
                                      text: 'Offer Price ',
                                      size: 14.sp,
                                      color: AppColors.mainColor_2,
                                    ),
                                  ],
                                ),
                                5.verticalSpace,
                                (ctrl.offerFood?.fdIsLoos ?? 'false') == 'false'
                                    ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        MidText(text: 'Original Price : ${ctrl.offerFood?.fdFullPrice}'),
                                        TextFieldWidget(
                                            isNumberOnly: true,
                                            keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                                            hintText: 'Enter Your Offer Price ....',
                                            textEditingController: ctrl.fdOffFullPriceTD,
                                            borderRadius: 15.r,
                                            requiredField: true,
                                            onChange: (_) {},
                                          ),
                                      ],
                                    )
                                    : Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              children: [
                                                SmallText(text: 'OG Price : ${ctrl.offerFood?.fdFullPrice}'),
                                                TextFieldWidget(
                                                  isNumberOnly: true,
                                                  keyboardType:
                                                      const TextInputType.numberWithOptions(decimal: true, signed: true),
                                                  hintText: ctrl.offerFood?.fullPrsName ?? 'Full',
                                                  textEditingController: ctrl.fdOffFullPriceTD,
                                                  borderRadius: 15.r,
                                                  requiredField: true,
                                                  onChange: (_) {},
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                SmallText(text: 'OG Price : ${ctrl.offerFood?.fdThreeBiTwoPrsPrice}'),
                                                TextFieldWidget(
                                                  isNumberOnly: true,
                                                  keyboardType:
                                                      const TextInputType.numberWithOptions(decimal: true, signed: true),
                                                  hintText: ctrl.offerFood?.thrByToPrsName ?? '3/4',
                                                  textEditingController: ctrl.fdOffThreeBiTwoPrsTD,
                                                  borderRadius: 15.r,
                                                  onChange: (_) {},
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                SmallText(text: 'OG Price : ${ctrl.offerFood?.fdHalfPrice}'),
                                                TextFieldWidget(
                                                  isNumberOnly: true,
                                                  keyboardType:
                                                      const TextInputType.numberWithOptions(decimal: true, signed: true),
                                                  hintText: ctrl.offerFood?.halfPrsName ?? 'Half',
                                                  textEditingController: ctrl.fdOffHalfPriceTD,
                                                  borderRadius: 15.r,
                                                  onChange: (_) {},
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                SmallText(text: 'OG Price : ${ctrl.offerFood?.fdQtrPrice}'),
                                                TextFieldWidget(
                                                  isNumberOnly: true,
                                                  keyboardType:
                                                      const TextInputType.numberWithOptions(decimal: true, signed: true),
                                                  hintText: ctrl.offerFood?.qtrPrsName ?? 'Quarter',
                                                  textEditingController: ctrl.fdOffQtrPriceTD,
                                                  borderRadius: 15.r,
                                                  onChange: (_) {},
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                20.verticalSpace,
                                //add food button
                                Center(
                                    child: ctrl.isLoading
                                        ? RoundBorderButton(
                                            text: 'Add Food',
                                            onTap: () {},
                                            isEnabled: false,
                                          )
                                        : RoundBorderButton(
                                            text: 'Add Food',
                                            textColor: Colors.white,
                                            width: 0.9.sw,
                                            borderRadius: 20.r,
                                            onTap: () async {
                                             ctrl.updateOffer();
                                            },
                                          )),
                                20.verticalSpace,
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
      }), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
