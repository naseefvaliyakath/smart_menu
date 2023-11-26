import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final String? label;
  final FocusNode? focusNode;
  final int maxLine;
  final double borderRadius;
  final double? width;
  final double? hintSize;
  final bool readonly;
  final Function(String) onChange;
  final bool autoFocus;
  final TextInputType keyboardType;
  final bool isNumberOnly;
  final int txtLength;
  final String? Function(String?)? validator;
  final bool requiredField;
  final VoidCallback? onTap;
  final String? Function(String?)? onSubmit;
  final IconData? suffixIcon;
  final VoidCallback? onIconTap;
  final bool useEmailValidator;
  final bool usePhoneValidator;

  const TextFieldWidget({
    Key? key,
    required this.textEditingController,
    required this.hintText,
    this.label,
    this.maxLine = 1,
    this.readonly = false,
    required this.borderRadius,
    this.width,
    this.hintSize,
    this.autoFocus = false,
    this.keyboardType = TextInputType.text,
    required this.onChange,
    this.isNumberOnly = false,
    this.txtLength = 50,
    this.requiredField = false,
    this.validator,
    this.onTap,
    this.suffixIcon,
    this.onIconTap,
    this.useEmailValidator = false,
    this.usePhoneValidator = false,
    this.onSubmit, this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.maxFinite,
      child: TextFormField(
        keyboardType: keyboardType,
        controller: textEditingController,
        maxLines: maxLine,
        onTap: onTap,
        readOnly: readonly,
        enabled: !readonly,
        autofocus: autoFocus,
        onChanged: onChange,
        focusNode: focusNode,
        validator: (value) {
          if (requiredField && (value == null || value.isEmpty)) {
            return 'This field is required';
          }
          if (useEmailValidator) {
            return validateEmail(value);
          }
          if (usePhoneValidator) {
            return validatePhone(value);
          }
        },
        onFieldSubmitted: onSubmit,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: label,
          suffixIcon: suffixIcon != null
              ? IconButton(
                  icon: Icon(suffixIcon),
                  onPressed: onIconTap,
                )
              : null,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: TextStyle(
            color: Colors.grey, // Replace with your color
            fontSize: hintSize ?? (1.sh < 1.sw ? 7.w : 14.w),
          ),
          hintStyle: TextStyle(
            color: Colors.grey, // Replace with your color
            fontSize: hintSize ?? (1.sh < 1.sw ? 7.w : 15.w),
          ),
          filled: true,
          fillColor: Colors.grey[200],
          // Replace with your color
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: Colors.white, width: 1.sp),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: Colors.white, width: 1.sp),
          ),
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(txtLength),
          if (isNumberOnly) FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*')),
        ],
      ),
    );
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number cannot be empty';
    }
    if (!GetUtils.isPhoneNumber(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }
}
