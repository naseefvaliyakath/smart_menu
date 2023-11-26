import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otp_text_field_v2/otp_field_v2.dart';

class OTPTextFieldCard extends StatelessWidget {
  final OtpFieldControllerV2 otpController;
  final Function onChange;

  const OTPTextFieldCard({
    Key? key,
    required this.otpController, required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OTPTextFieldV2(
      controller: otpController,
      length: 5,
      inputFormatter: [FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*'))],
      width: MediaQuery.of(context).size.width,
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldWidth: 45,
      fieldStyle: FieldStyle.box,
      outlineBorderRadius: 15,
      style: const TextStyle(fontSize: 17),
      onChanged: (pin) {
        onChange(pin);
      },
      onCompleted: (pin) {
        print("Completed: " + pin);
      },
    );
  }
}
