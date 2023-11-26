import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashBoardCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final String imagePath;
  final Function onTap;

  const DashBoardCard({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.imagePath,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Card(
        elevation: 5,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: EdgeInsets.all(33.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 3,
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  fit: BoxFit.scaleDown,
                ),
              ),
              Flexible(
                flex: 1,
                child: FittedBox(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: FittedBox(
                  child: Text(
                    subTitle,
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
