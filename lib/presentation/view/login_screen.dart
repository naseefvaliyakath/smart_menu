import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:loading_icon_button/loading_icon_button.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:smart_menu/presentation/view/register_shop_page.dart';
import 'package:smart_menu/presentation/widget/common/buttons/app_rount_mini_btn.dart';
import 'package:smart_menu/presentation/widget/common/buttons/round_border_button.dart';
import '../../constants/colors/app_colors.dart';
import '../controller/login_controller.dart';
import '../widget/common/common_text/big_text.dart';
import '../widget/common/loading_page.dart';
import '../widget/common/text_field_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LoginController>(builder: (ctrl) {
        bool horizontal = 1.sh < 1.sw ? true : false;
        return SafeArea(
          child: Center(
            child: ctrl.showLoading.value
                ? Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    surfaceTintColor: Colors.white,
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SizedBox(
                        width: horizontal ? 0.3.sw : 0.8.sw,
                        child: Form(
                          key: ctrl.loginFormKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const BigText(text: 'MOBILE NUMBER'),
                              20.verticalSpace,
                              TextFieldWidget(
                                isNumberOnly: true,
                                requiredField: true,
                                usePhoneValidator: true,
                                keyboardType: TextInputType.number,
                                hintText: 'Enter Your Mobile Number ....',
                                textEditingController: ctrl.registerMobileNumberController,
                                borderRadius: 15.r,
                                onChange: (_) async {},
                              ),
                              20.verticalSpace,
                              LoadingButton(
                                height: 45,
                                width: 100,
                                primaryColor: AppColors.mainColor,
                                showBox: true,
                                onPressed: () async {
                                  FocusScope.of(context).unfocus();
                                  ctrl.login();
                                },
                                successIcon: Icons.check,
                                controller: ctrl.loginBtnController,
                                child: const Text(
                                  'Login',
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                              ),
                              5.verticalSpace,
                              TextButton(
                                onPressed: () {
                                  Get.off(() => const RegisterShopPage());
                                },
                                child: Text(
                                  'Create Account',
                                  style: TextStyle(fontSize: 20.sp, color: Colors.black54),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : const MyLoading(),
          ),
        );
      }),
    );
  }
}
