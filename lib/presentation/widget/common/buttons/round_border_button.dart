import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundBorderButton extends StatelessWidget {
  final Color textColor;
  final Color backgroundColor;
  final String text;
  final double borderRadius;
  final double? width;
  final double? height;
  final Function onTap;
  final bool isEnabled;

  const RoundBorderButton({
    Key? key,
    this.textColor = Colors.black,
    this.backgroundColor = const Color(0xfff25f27),
    required this.text,
    this.borderRadius = 50,
    this.width,
    required this.onTap,
    this.height,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isEnabled ? 1 : 0.5,  // Use Opacity widget to control button appearance
      child: Container(
        height: height ?? 60.h,
        width: width ?? 0.8.sw,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: backgroundColor,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(borderRadius),
            splashColor: isEnabled ? Colors.black.withOpacity(0.5) : Colors.transparent, // Prevent splash when disabled
            hoverColor: isEnabled ? Colors.black.withOpacity(0.5) : Colors.transparent, // Prevent hover color change when disabled
            focusColor: isEnabled ? Colors.black.withOpacity(0.5) : Colors.transparent, // Prevent focus color change when disabled
            onTap: isEnabled ? () => onTap() : null, // Disable tap event when button is not enabled
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: 20.sp,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
