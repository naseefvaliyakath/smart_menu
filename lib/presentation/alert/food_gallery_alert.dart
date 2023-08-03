import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_menu/constants/url.dart';
import 'package:smart_menu/presentation/controller/add_food_controller.dart';
import 'package:smart_menu/presentation/controller/home_controller.dart';
import 'package:smart_menu/presentation/widget/common/common_text/big_text.dart';

import '../widget/common/gallery_dropdown.dart';
import '../widget/gallery_food_card.dart';

void showFoodGallery({required BuildContext context}) {
  showAnimatedDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return GetBuilder<HomeController>(builder: (ctrl) {
        return AlertDialog(
          title: const Center(child: BigText(text: 'SELECT FOOD')),
          contentPadding: EdgeInsets.all(10.sp),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.sp),
          ),
          content: SizedBox(
            width: 0.9.sw,
            height: 0.7.sh,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.sp),
                  child: const GalleryDropdown(),
                ),
                Flexible(
                  child: GridView.builder(
                    padding: EdgeInsets.all(10.sp),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: ctrl.foodGalleryFoods.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GalleryFoodCard(
                        img: ctrl.foodGalleryFoods[index].fdImg ?? IMG_LINK,
                        name: '${ctrl.foodGalleryFoods[index].name}',
                        onTap: () {
                          Get
                              .find<AddFoodController>()
                              .galleryImgLink = ctrl.foodGalleryFoods[index].fdImg;
                          Get.find<AddFoodController>().loadImage(ctrl.foodGalleryFoods[index].fdImg);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      });
    },
    animationType: DialogTransitionType.scale,
    curve: Curves.fastOutSlowIn,
    duration: const Duration(milliseconds: 900),
  );
}
