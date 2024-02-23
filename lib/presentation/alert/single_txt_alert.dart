import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_menu/presentation/widget/common/buttons/app_rount_mini_btn.dart';
import '../../constants/colors/app_colors.dart';
import '../widget/common/common_text/big_text.dart';
import '../widget/common/text_field_widget.dart';

class SingleTxtAlertBody extends StatelessWidget {
  final String hintText;
  final TextEditingController tCtrl;
  final Function onTap;
  final bool usePhoneValidator;
  final bool useEmailValidator;
  final GlobalKey<FormState>? formKey;
  final int maxLetter;

  const SingleTxtAlertBody(
      {Key? key,
      required this.hintText,
      required this.tCtrl,
      required this.onTap,
      this.maxLetter = 20,
      this.formKey,
      this.usePhoneValidator = false,
      this.useEmailValidator = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0.3.sw,
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFieldWidget(
              hintText: hintText,
              txtLength: maxLetter,
              textEditingController: tCtrl,
              borderRadius: 15.r,
              requiredField: true,
              usePhoneValidator: usePhoneValidator,
              useEmailValidator: useEmailValidator,
              isNumberOnly: usePhoneValidator,
              onChange: (_) {},
            ),
            10.verticalSpace,
            SizedBox(
              height: 45.h,
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: AppRoundMiniBtn(text: 'Submit', color: Colors.green, onTap: () => onTap()),
                    ),
                    10.horizontalSpace,
                    Flexible(
                      fit: FlexFit.tight,
                      child:
                          AppRoundMiniBtn(text: 'Close', color: Colors.redAccent, onTap: () => Navigator.pop(context)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void singleTxtAlert({
  required BuildContext context,
  required String hintText,
  required String title,
  required TextEditingController tCtrl,
  required Function onTap,
  Function? onPopupDismissing,
  GlobalKey<FormState>? formKey,
  bool usePhoneValidator = false,
  bool useEmailValidator = false,
  int maxLetter = 20,
}) {
  try {
    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.r))),
          insetPadding: const EdgeInsets.all(0),
          titlePadding: EdgeInsets.all(10.sp),
          contentPadding: EdgeInsets.all(10.sp),
          actionsAlignment: MainAxisAlignment.center,
          title: Center(child: BigText(text: title)),
          content: SingleChildScrollView(
            child: SingleTxtAlertBody(
              maxLetter: maxLetter,
              hintText: hintText,
              tCtrl: tCtrl,
              onTap: onTap,
              formKey: formKey,
              usePhoneValidator: usePhoneValidator,
              useEmailValidator: useEmailValidator,
            ),
          ),
        );
      },
      animationType: DialogTransitionType.scale,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 900),
    ).then((value) {
      if (onPopupDismissing != null) {
        onPopupDismissing();
      }
    });
    ;
  } catch (e) {
    rethrow;
  }
}
