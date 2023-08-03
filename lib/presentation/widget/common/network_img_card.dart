import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../constants/colors/app_colors.dart';

class ShowNetworkImgCard extends StatelessWidget {
  final String? imageUrl;

  const ShowNetworkImgCard({Key? key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(8.sp),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: AppColors.mainColor_2,
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: imageUrl != null
              ? CachedNetworkImage(
            imageUrl: imageUrl!,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Icon(Icons.error,size: 24.sp,),
          )
              : Center(
              child: Text(
                'No Image Available',
                style: TextStyle(color: Colors.white,fontSize: 24.sp),
              )),
        ),
      ),
    );
  }
}
