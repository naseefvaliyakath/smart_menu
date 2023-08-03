import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class GalleryFoodCard extends StatelessWidget {
  final String img;
  final String name;
  final Function onTap;

  const GalleryFoodCard({Key? key, required this.img, required this.name, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                offset: const Offset(4, 6),
                blurRadius: 4,
                color: Colors.black.withOpacity(0.3),
              ),
            ]),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: CachedNetworkImage(
                  imageUrl: img,
                  placeholder: (context, url) => Lottie.asset(
                    'assets/lottie/img_holder.json',
                    width: 50.sp,
                    height: 50.sp,
                    fit: BoxFit.fill,
                  ),
                  errorWidget: (context, url, error) => Lottie.asset(
                    'assets/lottie/error.json',
                    width: 10.sp,
                    height: 10.sp,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
            Positioned(
              left: 5.w,
              bottom: 1.sh / 45.54,
              child: Text(
                name,
                softWrap: false,
                style: TextStyle(
                  fontSize: 1.sh / 55.15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.fade,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
