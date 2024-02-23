import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_icon_button/loading_icon_button.dart';
import 'package:otp_text_field_v2/otp_field_v2.dart';
import 'package:smart_menu/core/routes/app_pages.dart';
import 'package:smart_menu/presentation/widget/common/buttons/app_rount_mini_btn.dart';
import 'package:smart_menu/presentation/widget/common/common_text/mid_text.dart';
import '../../constants/colors/app_colors.dart';
import '../../constants/enums.dart';
import '../controller/login_controller.dart';
import '../widget/common/common_text/small_text.dart';
import '../widget/common/drop_down_filter_widget.dart';
import '../widget/common/text_field_widget.dart';
import '../widget/otp_txt_field.dart';

class RegisterShopPage extends StatelessWidget {
  const RegisterShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (ctrl) {
      return Obx(() {
        return PopScope(
          onPopInvoked: (pop) async {
            ctrl.btnController.reset();
            ctrl.clearFormField();
            ctrl.isFormSubmitted.value = false;
            Get.offNamed(AppPages.LOGIN_PAGE);
          },
          canPop: false,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Register Shop', style: TextStyle(color: Colors.black, fontSize: 24.sp)),
              backgroundColor: Colors.white,
              iconTheme: const IconThemeData(color: Colors.black),
              leading: IconButton(
                onPressed: () {
                  ctrl.btnController.reset();
                  ctrl.clearFormField();
                  ctrl.isFormSubmitted.value = false;
                  Get.offNamed(AppPages.LOGIN_PAGE);
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 10.sp),
                child: Form(
                  key: ctrl.registerFormKey,
                  child: Column(
                    children: [
                      15.verticalSpace,
                      TextFieldWidget(
                        hintText: 'Enter Shop Name ...',
                        label: 'Shop Name',
                        requiredField: true,
                        textEditingController: ctrl.shopNameController,
                        borderRadius: 8.r,
                        readonly: ctrl.isFormSubmitted.value,
                        onChange: (val) {},
                      ),
                      const SmallText(text: ' NB :You Cannot Change Shop name Later'),
                      15.verticalSpace,
                      TextFieldWidget(
                        hintText: 'Enter Phone  ...',
                        label: 'Phone 1',
                        textEditingController: ctrl.phone1Controller,
                        borderRadius: 8.r,
                        isNumberOnly: true,
                        usePhoneValidator: true,
                        readonly: ctrl.isFormSubmitted.value,
                        txtLength: 10,
                        requiredField: true,
                        onChange: (val) {},
                      ),
                      15.verticalSpace,
                      TextFieldWidget(
                        hintText: 'Enter Email ...',
                        label: 'Email',
                        textEditingController: ctrl.emailController,
                        useEmailValidator: true,
                        requiredField: true,
                        readonly: ctrl.isFormSubmitted.value,
                        borderRadius: 8.r,
                        onChange: (val) {},
                      ),
                      15.verticalSpace,
                      DropdownFilterWidget<States>(
                        items: States.values,
                        isEnabled: !ctrl.isFormSubmitted.value,
                        selectedItem: ctrl.selectedState.value,
                        hint: 'Select State',
                        onChanged: (States? value) {
                          if (value != null) {
                            ctrl.selectedState.value = value;
                          }
                        },
                        itemToString: (States item) => stateDescriptions[item] ?? '',
                      ),
                      15.verticalSpace,
                      // DropdownFilterWidget<District>(
                      //   items: District.values,
                      //   selectedItem: ctrl.selectedDistrict.value,
                      //   isEnabled: !ctrl.isFormSubmitted.value,
                      //   hint: 'Select District',
                      //   onChanged: (District? value) {
                      //     if (value != null) {
                      //       ctrl.selectedDistrict.value = value;
                      //     }
                      //   },
                      //   itemToString: (District item) => districtDescriptions[item] ?? '',
                      // ),
                      15.verticalSpace,
                      Visibility(
                        visible: ctrl.isFormSubmitted.value,
                        child: Column(
                          children: [
                            const MidText(text: 'ENTER OTP'),
                            5.verticalSpace,
                            OTPTextFieldCard(
                              otpController: ctrl.otpController,
                              onChange: (otp) {
                                ctrl.otp = otp;
                              },
                            ),
                            5.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      ctrl.initiateCreateShop(isResendOtp: true);
                                    },
                                    child: const Text('Resent OTP')),
                                TextButton(
                                    onPressed: () {
                                      ctrl.initiateCreateShop(isResendOtp: true,otpType: 'call');
                                    },
                                    child: const Text('Call OTP')),
                              ],
                            )
                          ],
                        ),
                      ),
                      15.verticalSpace,
                      LoadingButton(
                        height: 45,
                        primaryColor: AppColors.mainColor,
                        showBox: true,
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (ctrl.isFormSubmitted.value) {
                            ctrl.verifyOTPAndCreateShop();
                          } else {
                            ctrl.initiateCreateShop();
                          }
                        },
                        successIcon: Icons.check,
                        controller: ctrl.btnController,
                        child: Text(
                          ctrl.isFormSubmitted.value ? 'Submit OTP' : 'Register Shop',
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      });
    });
  }
}
