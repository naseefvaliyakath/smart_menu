import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_menu/constants/url.dart';
import 'package:smart_menu/presentation/controller/offer_page_controller.dart';
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
                            key: ctrl.foodFormKey,
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
                                  img: ctrl.food?.fdImg ?? IMG_LINK,
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
                                20.verticalSpace,
                                //? food name text-field
                                BigText(
                                  text: 'Food Name ',
                                  size: 14.sp,
                                  color: AppColors.mainColor_2,
                                ),
                                5.verticalSpace,
                                TextFieldWidget(
                                  hintText: 'Enter Your Food Name ....',
                                  textEditingController: ctrl.fdNameTD,
                                  requiredField: true,
                                  borderRadius: 15.r,
                                  txtLength: 35,
                                  onChange: (_) {},
                                ),
                                20.verticalSpace,
                                //? food name text-field
                                BigText(
                                  text: 'Food Description ',
                                  size: 14.sp,
                                  color: AppColors.mainColor_2,
                                ),
                                5.verticalSpace,
                                TextFieldWidget(
                                  hintText: 'Enter Your Food Description ....',
                                  textEditingController: ctrl.fdDescriptionTD,
                                  borderRadius: 15.r,
                                  txtLength: 35,
                                  onChange: (_) {},
                                ),

                                20.verticalSpace,
                                // price text-field
                                Row(
                                  children: [
                                    BigText(
                                      text: 'Food Price ',
                                      size: 14.sp,
                                      color: AppColors.mainColor_2,
                                    ),
                                  ],
                                ),
                                5.verticalSpace,
                                TextFieldWidget(
                                  isNumberOnly: true,
                                  keyBordType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                                  hintText: 'Enter Your Food Price ....',
                                  textEditingController: ctrl.fdPriceTD,
                                  borderRadius: 15.r,
                                  requiredField: true,
                                  onChange: (_) {},
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFieldWidget(
                                        isNumberOnly: true,
                                        keyBordType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                                        hintText: 'Full',
                                        textEditingController: ctrl.fdFullPriceTD,
                                        borderRadius: 15.r,
                                        requiredField: true,
                                        onChange: (_) {},
                                      ),
                                    ),
                                    Expanded(
                                      child: TextFieldWidget(
                                        isNumberOnly: true,
                                        keyBordType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                                        hintText: '3/4',
                                        textEditingController: ctrl.fdThreeBiTwoPrsTD,
                                        borderRadius: 15.r,
                                        onChange: (_) {},
                                      ),
                                    ),
                                    Expanded(
                                      child: TextFieldWidget(
                                        isNumberOnly: true,
                                        keyBordType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                                        hintText: 'Half',
                                        textEditingController: ctrl.fdHalfPriceTD,
                                        borderRadius: 15.r,
                                        onChange: (_) {},
                                      ),
                                    ),
                                    Expanded(
                                      child: TextFieldWidget(
                                        isNumberOnly: true,
                                        keyBordType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                                        hintText: 'Quarter',
                                        textEditingController: ctrl.fdQtrPriceTD,
                                        borderRadius: 15.r,
                                        onChange: (_) {},
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
                                            onTap: () async {},
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
