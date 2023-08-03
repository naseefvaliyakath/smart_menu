import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/colors/app_colors.dart';

class MidText extends StatelessWidget {
  final Color? color;
  final String text;
  final int maxLine;
  final double size;
  final TextOverflow overflow;

  const MidText({
    Key? key,
    this.color = AppColors.titleColor,
    required this.text,
    this.size = 0,
    this.overflow = TextOverflow.fade,  this.maxLine = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine,
      style: GoogleFonts.openSans(
          textStyle: TextStyle(
              color: color,
              overflow: TextOverflow.clip,
              fontSize: size == 0 ? 16.sp : size,
              fontWeight: FontWeight.bold)),
        softWrap: false,
    );
  }
}
