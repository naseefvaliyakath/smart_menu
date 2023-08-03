//? common alert for two button
import 'package:flutter/material.dart';

import 'my_dialog_body.dart';

void twoFunctionAlert({
  required BuildContext context,
  required Function onTap,
  required Function onCancelTap,
  required String title,
  required String subTitle,
  String okBtn = 'Yes',
  String cancelBtn = 'No',
}) {
  MyDialogBody.myConfirmDialogBody(
    context: context,
    title: title,
    desc: subTitle,
    btnCancelText: cancelBtn,
    btnOkText: okBtn,
    onTapOK: () async {
      onTap();
      Navigator.pop(context);
    },
    onTapCancel: () async {
      await onCancelTap();
      Navigator.pop(context);
    },
  );
}
