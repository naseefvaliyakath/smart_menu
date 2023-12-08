import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../constants/app_constant_names.dart';
import '../../constants/colors/app_colors.dart';
import '../alert/food_gallery_alert.dart';
import '../alert/single_txt_alert.dart';
import '../alert/two_function_alert.dart';
import '../controller/add_food_controller.dart';
import '../widget/card_for_price_tag.dart';
import '../widget/common/add_category_card.dart';
import '../widget/common/add_catogory_card_text_field.dart';
import '../widget/common/buttons/round_border_button.dart';
import '../widget/common/catogory_card.dart';
import '../widget/common/chose_image.dart';
import '../widget/common/common_text/big_text.dart';
import '../widget/common/common_text/heading_rich_text.dart';
import '../widget/common/loading_page.dart';
import '../widget/common/my_toggle_switch.dart';
import '../widget/common/notification_icon.dart';
import '../widget/common/shimming_effect.dart';
import '../widget/common/show_picked_img_card.dart';
import '../widget/common/text_field_widget.dart';
import '../widget/common/two_button-bottom_sheet.dart';

class AddFoodPage extends StatefulWidget {
  const AddFoodPage({Key? key}) : super(key: key);

  @override
  State<AddFoodPage> createState() => _AddFoodPageState();
}

class _AddFoodPageState extends State<AddFoodPage> {
  var fdCategory = COMMON_CATEGORY;
  CrossFadeState state = CrossFadeState.showFirst;
  CrossFadeState stateCategory = CrossFadeState.showFirst;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AddFoodController>(builder: (ctrl) {
        //? if no category clicked then make default first category
        fdCategory = ctrl.myCategory.isNotEmpty ? ctrl.myCategory.first.name ?? COMMON_CATEGORY : COMMON_CATEGORY;
        state = ctrl.priceToggle == false ? CrossFadeState.showFirst : CrossFadeState.showSecond;
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
                                            const HeadingRichText(name: 'Add Your Food'),
                                          ],
                                        ),
                                      ),
                                      //? notification icon
                                      NotificationIcon(onTap: () {}),
                                    ],
                                  ),
                                ),
                                15.verticalSpace,
                                //? select category text
                                BigText(
                                  text: 'Select Category :',
                                  size: 17.sp,
                                ),
                                10.verticalSpace,
                                //category scrolling
                                SizedBox(
                                  height: 60.h,
                                  child: ctrl.isLoadingCategory == true
                                      ? const ShimmingEffect()
                                      : ListView.builder(
                                          physics: const BouncingScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          itemCount: ctrl.myCategory.length + 1,
                                          itemBuilder: (BuildContext ctx, index) {
                                            //category's
                                            if (index < ctrl.myCategory.length) {
                                              return CategoryCard(
                                                onTap: () {
                                                  ctrl.setCategoryTappedIndex(index, ctrl.myCategory[index].id ?? -1);
                                                },
                                                color: ctrl.tappedIndex == index ? AppColors.mainColor_2 : Colors.white,
                                                text: ctrl.myCategory[index].name ?? 'error'.toUpperCase(),
                                                indexForColour: index,
                                                onLongTap: () async {
                                                  twoFunctionAlert(
                                                    title: 'Delete this item ?',
                                                    subTitle: 'Do you want to delete this food ?',
                                                    okBtn: 'Delete',
                                                    cancelBtn: 'Cancel',
                                                    context: context,
                                                    onCancelTap: () {},
                                                    onTap: () {
                                                      ctrl.deleteCategory(
                                                        catId: ctrl.myCategory[index].id ?? -1,
                                                      );
                                                    },
                                                  );
                                                },
                                              );
                                            }

                                            //? add new category card
                                            else {
                                              return AnimatedCrossFade(
                                                firstChild: AddCategoryCard(
                                                  onTap: () {
                                                    ctrl.setAddCategoryToggle(true);
                                                    stateCategory = ctrl.addCategoryToggle == false
                                                        ? CrossFadeState.showFirst
                                                        : CrossFadeState.showSecond;
                                                  },
                                                ),
                                                secondChild: ctrl.addCategoryLoading
                                                    ? const MyLoading()
                                                    : AddCategoryCardTextField(
                                                        onTapAdd: () async {
                                                          FocusManager.instance.primaryFocus?.unfocus();
                                                          await ctrl.insertCategory();
                                                          stateCategory = ctrl.addCategoryToggle == false
                                                              ? CrossFadeState.showFirst
                                                              : CrossFadeState.showSecond;
                                                        },
                                                        onTapBack: () {
                                                          ctrl.setAddCategoryToggle(false);
                                                          stateCategory = ctrl.addCategoryToggle == false
                                                              ? CrossFadeState.showFirst
                                                              : CrossFadeState.showSecond;
                                                        },
                                                        nameController: ctrl.categoryNameTD,
                                                        height: 60.h,
                                                      ),
                                                duration: const Duration(seconds: 1),
                                                crossFadeState: stateCategory,
                                                firstCurve: Curves.fastLinearToSlowEaseIn,
                                                secondCurve: Curves.linear,
                                              );
                                            }
                                          },
                                        ),
                                ),
                                20.verticalSpace,
                                //? upload image
                                ctrl.imageFile != null
                                    //? to select image from gallery or camera
                                    ? ShowPickedImgCard(
                                        file: ctrl.imageFile,
                                        cancelEvent: () {
                                          setState(() {
                                            //? making imageFile and galleryImgLink null
                                            ctrl.imageFile = null;
                                            ctrl.galleryImgLink = null;
                                            ctrl.isCacheImageFile = false;
                                          });
                                        },
                                        choseFileEvent: () {
                                          FlexibleBtnBottomSheet.bottomSheet(
                                              context: context,
                                              b1Name: 'From Gallery',
                                              b2Name: 'From Camara',
                                              b3Name: 'From Collection',
                                              b1Function: _getFromGallery,
                                              b2Function: _getFromCamara,
                                              b3Function: () {
                                                Navigator.pop(context);
                                                showFoodGallery(context: context);
                                              });
                                        },
                                      )
                                    : InkWell(
                                        onTap: () {
                                          FlexibleBtnBottomSheet.bottomSheet(
                                              context: context,
                                              b1Name: 'From Gallery',
                                              b2Name: 'From Camara',
                                              b3Name: 'From Collection',
                                              b1Function: _getFromGallery,
                                              b2Function: _getFromCamara,
                                              b3Function: () {
                                                Navigator.pop(context);
                                                showFoodGallery(context: context);
                                              });
                                        },
                                        child: const ChooseImage(),
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
                                  focusNode: ctrl.nameFocusNode,
                                  borderRadius: 15.r,
                                  txtLength: 35,
                                  onSubmit: (_) {
                                    FocusScope.of(context).requestFocus(ctrl.descriptionFocusNode);
                                  },
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
                                  focusNode: ctrl.descriptionFocusNode,
                                  borderRadius: 15.r,
                                  txtLength: 35,
                                  onSubmit: (_) {
                                    FocusScope.of(context).requestFocus(ctrl.priceFocusNode);
                                  },
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
                                    MyToggleSwitch(
                                      value: ctrl.priceToggle,
                                      onToggle: (val) {
                                        ctrl.setPriceToggle(val);
                                        ctrl.clearLoosPrice();
                                        state = ctrl.priceToggle == false
                                            ? CrossFadeState.showFirst
                                            : CrossFadeState.showSecond;
                                      },
                                    ),
                                  ],
                                ),
                                5.verticalSpace,
                                AnimatedCrossFade(
                                  firstChild: TextFieldWidget(
                                    isNumberOnly: true,
                                    keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                                    hintText: 'Enter Your Food Price ....',
                                    txtLength: 8,
                                    textEditingController: ctrl.fdPriceTD,
                                    borderRadius: 15.r,
                                    focusNode: ctrl.priceFocusNode,
                                    requiredField: !ctrl.priceToggle,
                                    onChange: (_) {},
                                  ),
                                  secondChild: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            BeautifulStripCard(
                                              text: ctrl.fullPriceName,
                                              onTap: () {
                                                singleTxtAlert(
                                                    context: context,
                                                    hintText: 'Enter Name',
                                                    title: 'Edit Name',
                                                    maxLetter: 8,
                                                    tCtrl: ctrl.fullPrsNameTD,
                                                    onTap: () {
                                                      ctrl.updatePriceTagName();
                                                      Navigator.pop(context);
                                                    },
                                                    onPopupDismissing: () {
                                                      ctrl.clearPriceTagNameCtrlOnly();
                                                    });
                                              },
                                            ),
                                            TextFieldWidget(
                                              isNumberOnly: true,
                                              keyboardType:
                                                  const TextInputType.numberWithOptions(decimal: true, signed: true),
                                              hintText: ctrl.fullPriceName,
                                              txtLength: 8,
                                              textEditingController: ctrl.fdFullPriceTD,
                                              focusNode: ctrl.fullPriceFocusNode,
                                              borderRadius: 15.r,
                                              requiredField: ctrl.priceToggle,
                                              onSubmit: (_) {
                                                FocusScope.of(context).requestFocus(ctrl.threeBiTwoPrsFocusNode);
                                              },
                                              onChange: (_) {},
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            BeautifulStripCard(
                                              text: ctrl.threeBiTwoPriceName,
                                              onTap: () {
                                                singleTxtAlert(
                                                    context: context,
                                                    hintText: 'Enter Name',
                                                    title: 'Edit Name',
                                                    tCtrl: ctrl.thrByToPrsNameTD,
                                                    maxLetter: 8,
                                                    onTap: () {
                                                      ctrl.updatePriceTagName();
                                                      Navigator.pop(context);
                                                    },
                                                    onPopupDismissing: () {
                                                      ctrl.clearPriceTagNameCtrlOnly();
                                                    });
                                              },
                                            ),
                                            TextFieldWidget(
                                              isNumberOnly: true,
                                              keyboardType:
                                                  const TextInputType.numberWithOptions(decimal: true, signed: true),
                                              hintText: ctrl.threeBiTwoPriceName,
                                              txtLength: 8,
                                              textEditingController: ctrl.fdThreeBiTwoPrsTD,
                                              focusNode: ctrl.threeBiTwoPrsFocusNode,
                                              onSubmit: (_) {
                                                FocusScope.of(context).requestFocus(ctrl.halfPriceFocusNode);
                                              },
                                              borderRadius: 15.r,
                                              onChange: (_) {},
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            BeautifulStripCard(
                                              text: ctrl.halfPriceName,
                                              onTap: () {
                                                singleTxtAlert(
                                                    context: context,
                                                    hintText: 'Enter Name',
                                                    title: 'Edit Name',
                                                    tCtrl: ctrl.halfPrsNameTD,
                                                    maxLetter: 8,
                                                    onTap: () {
                                                      ctrl.updatePriceTagName();
                                                      Navigator.pop(context);
                                                    },
                                                    onPopupDismissing: () {
                                                      ctrl.clearPriceTagNameCtrlOnly();
                                                    });
                                              },
                                            ),
                                            TextFieldWidget(
                                              isNumberOnly: true,
                                              keyboardType:
                                                  const TextInputType.numberWithOptions(decimal: true, signed: true),
                                              hintText: ctrl.halfPriceName,
                                              txtLength: 8,
                                              textEditingController: ctrl.fdHalfPriceTD,
                                              borderRadius: 15.r,
                                              focusNode: ctrl.halfPriceFocusNode,
                                              onSubmit: (_) {
                                                FocusScope.of(context).requestFocus(ctrl.qtrPriceFocusNode);
                                              },
                                              onChange: (_) {},
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            BeautifulStripCard(
                                              text: ctrl.qtrPriceName,
                                              onTap: () {
                                                singleTxtAlert(
                                                    context: context,
                                                    hintText: 'Enter Name',
                                                    title: 'Edit Name',
                                                    tCtrl: ctrl.qtrPrsNameTD,
                                                    maxLetter: 8,
                                                    onTap: () {
                                                      ctrl.updatePriceTagName();
                                                      Navigator.pop(context);
                                                    },
                                                    onPopupDismissing: () {
                                                      ctrl.clearPriceTagNameCtrlOnly();
                                                    });
                                              },
                                            ),
                                            TextFieldWidget(
                                              isNumberOnly: true,
                                              keyboardType:
                                                  const TextInputType.numberWithOptions(decimal: true, signed: true),
                                              hintText: ctrl.qtrPriceName,
                                              txtLength: 8,
                                              textEditingController: ctrl.fdQtrPriceTD,
                                              focusNode: ctrl.qtrPriceFocusNode,
                                              borderRadius: 15.r,
                                              onChange: (_) {},
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  duration: const Duration(seconds: 1),
                                  crossFadeState: state,
                                  firstCurve: Curves.fastLinearToSlowEaseIn,
                                  secondCurve: Curves.linear,
                                ),
                                20.verticalSpace,
                                //add food button
                                Center(
                                    child: ctrl.isLoading
                                        ? RoundBorderButton(
                                            text: ctrl.isUpdate ? 'Update Food' : 'Add Food',
                                            onTap: () {},
                                            isEnabled: false,
                                          )
                                        : RoundBorderButton(
                                            text: ctrl.isUpdate ? 'Update Food' : 'Add Food',
                                            textColor: Colors.white,
                                            width: 0.9.sw,
                                            borderRadius: 20.r,
                                            onTap: () async {
                                              //? galleryImgLink is not null mean image is not to update

                                              if (!ctrl.isUpdate) {
                                                ctrl.galleryImgLink == null
                                                    ? ctrl.file = ctrl.imageFile
                                                    : ctrl.file = null;
                                              } else {
                                                ctrl.isCacheImageFile ? ctrl.file = null : ctrl.file = ctrl.imageFile;
                                              }
                                              bool result = await ctrl.submitFood();
                                              result ? ctrl.imageFile = null : ctrl.imageFile = ctrl.imageFile;
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

  void _getFromGallery() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery, maxWidth: 1080, maxHeight: 1080, imageQuality: 10);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _getFromCamara() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera, maxWidth: 1080, maxHeight: 1080, imageQuality: 10);
    if (pickedFile != null) {
      _cropImage(pickedFile.path);
    }
    Navigator.pop(context);
  }

  _cropImage(filepath) async {
    AddFoodController ctrl = Get.find<AddFoodController>();
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: filepath,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black54,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );

    if (croppedFile != null) {
      File originalFile = File(croppedFile.path);
      int originalFileSize = await originalFile.length(); // File size in bytes
      if (originalFileSize > 500 * 1024) {
        // If the original file size is greater than 500KB
        final Uint8List? compressedImage = await FlutterImageCompress.compressWithFile(
          croppedFile.path,
          minWidth: 2300,
          minHeight: 1500,
          quality: 88,
        );

        if (compressedImage != null) {
          setState(() {
            ctrl.imageFile = File(croppedFile.path);
            ctrl.imageFile!.writeAsBytesSync(compressedImage);
          });
        }
      } else {
        setState(() {
          ctrl.imageFile = originalFile;
        });
      }
      //? if any img selected then making galleryImgLink is null
      ctrl.galleryImgLink = null;
      ctrl.isCacheImageFile = false;
    }
  }
}
