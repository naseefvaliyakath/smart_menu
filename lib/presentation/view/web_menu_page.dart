import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:smart_menu/constants/colors/app_colors.dart';
import 'package:smart_menu/presentation/widget/common/common_text/big_text.dart';
import 'package:smart_menu/presentation/widget/common/common_text/mid_text.dart';
import 'package:smart_menu/presentation/widget/common/show_case_widget.dart';
import '../../constants/app_constant_names.dart';
import '../controller/login_controller.dart';
import '../controller/show_case_controller.dart';
import '../controller/web_menu_controller.dart';
import '../widget/color_card.dart';
import '../widget/common/loading_page.dart';
import '../widget/design_select_widget.dart';
import '../widget/profile_menu.dart';
import '../widget/profile_menu_with_toggle.dart';

class WebMenuPage extends StatelessWidget {
  const WebMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WebMenuController>(builder: (ctrl) {
      return PopScope(
          onPopInvoked: (pop) async {},
          canPop: true,
          child: ShowCaseWidget(onFinish: () {
            //? after finish tour setting 'showcaseAddFoodPage' as false
            Get.find<ShowcaseController>().setShowcase(KEY_SHOWCASE_WEB_MENU_PAGE);
          }, builder: Builder(builder: (context) {
            if (!Get.find<ShowcaseController>().showcaseWebMenuPage) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ShowCaseWidget.of(context).startShowCase([
                  ctrl.showcaseWebMenuColorSelect,
                  ctrl.showcaseWebMenuToggle,
                  ctrl.showcaseWebMenuDesign,
                  ctrl.showcaseWebMenuSave
                ]);
              });
            }
            return Scaffold(
                appBar: AppBar(
                  title: Text(
                    'Setup Menu Book',
                    style: TextStyle(fontSize: 24.sp, color: Colors.black),
                  ),
                  backgroundColor: Colors.white,
                  iconTheme: const IconThemeData(color: Colors.black),
                  actions: [
                    MyShowCase(
                      showcaseKey: ctrl.showcaseWebMenuSave,
                      description: 'Finally Save Changes',
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextButton(
                          onPressed: () {
                            ctrl.updateWebMenuConfig();
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.mainColor,
                            backgroundColor: Colors.transparent,
                            side: const BorderSide(color: AppColors.mainColor),
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          ),
                          child: const Text('Save'),
                        ),
                      ),
                    ),
                  ],
                ),
                body: ctrl.isLoading == true
                    ? const MyLoading()
                    : SafeArea(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: Column(
                            children: [
                              Center(
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 0),
                                ),
                              ),
                              MidText(
                                text: 'Customise Website Color'.toUpperCase(),
                                color: Colors.black54,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Flexible(
                                      child: MyShowCase(
                                    showcaseKey: ctrl.showcaseWebMenuColorSelect,
                                    description: 'Pick Color For Your Menu Website',
                                    targetPadding: 5,
                                    child: ColorCard(
                                      onColorSelection: ctrl.mainColor,
                                      text: 'Main Color',
                                      onColorSect: (color) {
                                        ctrl.updateSelectedColor('mainColor', color);
                                      },
                                    ),
                                  )),
                                  Flexible(
                                      child: ColorCard(
                                    onColorSelection: ctrl.secondColor,
                                    text: 'Second Color',
                                    onColorSect: (color) {
                                      ctrl.updateSelectedColor('secondColor', color);
                                    },
                                  )),
                                  Flexible(
                                      child: ColorCard(
                                    onColorSelection: ctrl.titleColor,
                                    text: 'Title Color',
                                    onColorSect: (color) {
                                      ctrl.updateSelectedColor('titleColor', color);
                                    },
                                  )),
                                ],
                              ),
                              const Divider(),
                              MidText(
                                text: 'Customise Foods'.toUpperCase(),
                                color: Colors.black54,
                              ),
                              MyShowCase(
                                showcaseKey: ctrl.showcaseWebMenuToggle,
                                description: 'Customise Your Menu Website',
                                child: ProfileMenuWithToggle(
                                  text: 'Show Available Food',
                                  subtitle: 'Show Available Food Option In Menu Book',
                                  icon: Icons.verified_outlined,
                                  toggleSts: ctrl.showAvailableFood,
                                  press: () async {},
                                  onToggle: (toggleSts) {
                                    ctrl.updateToggleButtons('showAvailableFood', toggleSts);
                                  },
                                ),
                              ),
                              ProfileMenuWithToggle(
                                text: 'Show Offer Food',
                                subtitle: 'Show Offer Food Option In Menu Book',
                                icon: Icons.local_offer,
                                toggleSts: ctrl.showOfferFood,
                                press: () async {},
                                onToggle: (toggleSts) {
                                  ctrl.updateToggleButtons('showOfferFood', toggleSts);
                                },
                              ),
                              ProfileMenuWithToggle(
                                text: 'Show Today Food',
                                subtitle: 'Show Today Food Option In Menu Book',
                                icon: Icons.today,
                                toggleSts: ctrl.showTodayFood,
                                press: () async {},
                                onToggle: (toggleSts) {
                                  ctrl.updateToggleButtons('showTodayFood', toggleSts);
                                },
                              ),
                              ProfileMenuWithToggle(
                                text: 'Show Quick Food',
                                subtitle: 'Show Quick Food Option In Menu Book',
                                icon: Icons.timer,
                                toggleSts: ctrl.showQuickFood,
                                press: () async {},
                                onToggle: (toggleSts) {
                                  ctrl.updateToggleButtons('showQuickFood', toggleSts);
                                },
                              ),
                              ProfileMenuWithToggle(
                                text: 'Show Food Price',
                                subtitle: 'Show Food Price In Menu Book',
                                icon: Icons.price_change_outlined,
                                toggleSts: ctrl.showFoodPrice,
                                press: () async {},
                                onToggle: (toggleSts) {
                                  ctrl.updateToggleButtons('showFoodPrice', toggleSts);
                                },
                              ),
                              ProfileMenuWithToggle(
                                text: 'Show Food Description',
                                subtitle: 'Show Food Description In Menu Book',
                                icon: Icons.description_outlined,
                                toggleSts: ctrl.showFoodDescription,
                                press: () async {},
                                onToggle: (toggleSts) {
                                  ctrl.updateToggleButtons('showFoodDescription', toggleSts);
                                },
                              ),
                              ProfileMenu(
                                text: "Menu Models",
                                icon: Icons.menu_book,
                                press: () => {},
                              ),
                              MyShowCase(
                                showcaseKey: ctrl.showcaseWebMenuDesign,
                                description: 'Select Your Menu Items Design',
                                child: DesignSelector(
                                  image1: 'assets/image/design1.png',
                                  image2: 'assets/image/design2.png',
                                  text1: 'Design 1',
                                  text2: 'Design 2',
                                  isSelectedDesign1: ctrl.isSelectedDesign1,
                                  onSelect: (isSelected) {
                                    ctrl.updateToggleButtons('isSelectedDesign1', isSelected);
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ));
          })));
    });
  }
}
