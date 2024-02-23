import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../constants/colors/app_colors.dart';

class MyShowCase extends StatelessWidget {
  final GlobalKey showcaseKey;
  final String description;
  final String? title;
  final Widget child;
  final Color tooltipBackgroundColor;
  final Color textColor;
  final double? targetPadding;

  const MyShowCase({
    super.key,
    required this.showcaseKey,
    required this.description,
    required this.child,
    this.tooltipBackgroundColor = AppColors.mainColor,
    this.textColor = Colors.white,
    this.targetPadding,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Showcase(
      key: showcaseKey,
      title: title,
      titleAlignment: TextAlign.center,
      descriptionAlignment: TextAlign.center,
      description: description,
      textColor: textColor,
      tooltipBackgroundColor: AppColors.mainColor,
      targetPadding: EdgeInsets.all(targetPadding ?? 0),
      targetBorderRadius: BorderRadius.circular(10),
      child: child,
      // You can add more customization here as needed
    );
  }
}
