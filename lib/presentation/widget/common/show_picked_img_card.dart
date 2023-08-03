import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/colors/app_colors.dart';

class ShowPickedImgCard extends StatelessWidget {
  final File? file;
  final Function cancelEvent;
  final Function choseFileEvent;

  const ShowPickedImgCard({Key? key, required this.file, required this.cancelEvent, required this.choseFileEvent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(children: [
        GestureDetector(
          onTap: () {
            choseFileEvent();
          },
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(8.sp),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: AppColors.mainColor_2,
                    image: file != null ? DecorationImage(
                      image: FileImage(file!),
                      fit: BoxFit.cover,
                    ) : null, // Replace with default image, if desired
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 5.0,
                        offset: Offset(0, 5),
                      ),
                      BoxShadow(
                        color: Color(0xFFfafafa),
                        offset: Offset(-5, 0),
                      ),
                      BoxShadow(
                        color: Color(0xFFfafafa),
                        offset: Offset(5, 0),
                      ),
                    ]),
                width: 170.w,
                height: 220.h,
                child: file == null ? Center(child: Text('No Image Selected', style: TextStyle(color: Colors.white))) : null, // You can replace this widget with what you want to display when the file is null.
              ),

            ],
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: SizedBox(
            width: 40.w,
            height: 40.h,
            child: IconButton(
              icon: Icon(Icons.cancel_rounded, color: AppColors.mainColor, size: 35.sp),
              onPressed: () {
                cancelEvent();
              },
            ),
          ),
        ),
      ]),
    );
  }
}
