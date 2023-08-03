import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/colors/app_colors.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final String? label;
  final int maxLIne;
  final double borderRadius;
  final double? width;
  final double? hintSize;
  final bool readonly;
  final Function onChange;
  final bool? isDens;
  final bool autoFocus;
  final TextInputType keyBordType;
  final bool isNumberOnly;
  final int txtLength;
  final String? Function(String?)? validator;
  final bool requiredField;
  final VoidCallback? onTap;
  final IconData? suffixIcon;
  final VoidCallback? onIconTap;

  const TextFieldWidget({
    Key? key,
    required this.textEditingController,
    required this.hintText,
    this.label,
    this.maxLIne = 1,
    this.readonly = false,
    required this.borderRadius,
    this.isDens = false,
    this.width,
    this.hintSize,
    this.autoFocus = false,
    this.keyBordType = TextInputType.text,
    required this.onChange,
    this.isNumberOnly = false,
    this.txtLength = 50,
    this.requiredField = false,
    this.validator,
    this.onTap,
    this.suffixIcon,
    this.onIconTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool horizontal = 1.sh < 1.sw ? true : false;
    return SizedBox(
      width: width ?? double.maxFinite,
      child: TextFormField(
        keyboardType: keyBordType,
        controller: textEditingController,
        maxLines: maxLIne,
        onTap: onTap,
        readOnly: readonly,
        autofocus: autoFocus,
        validator: (value) {
          if (requiredField && (value == null || value.isEmpty)) {
            return 'This field is required';
          }
          if (value != null && value.isNotEmpty && isNumberOnly && double.tryParse(value) == null) {
            return 'Please enter a valid number';
          }
          if (validator != null) {
            return validator!(value);
          }
          return null;
        },
        onChanged: (value) {
          onChange(value);
        },
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
            color: AppColors.textGrey,
            fontSize: hintSize ?? (horizontal ? 7.w : 14.w),
          ),
          hintStyle: TextStyle(
            color: AppColors.textGrey,
            fontSize: hintSize ?? (horizontal ? 7.w : 15.w),
          ),
          filled: true,
          isDense: isDens,
          fillColor: AppColors.textHolder,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: Colors.white, width: 1.sp),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: Colors.white, width: 1.sp),
          ),
        ),
        inputFormatters: !isNumberOnly
            ? [LengthLimitingTextInputFormatter(txtLength)]
            : [FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*')), LengthLimitingTextInputFormatter(txtLength)],
      ),
    );
  }
}
