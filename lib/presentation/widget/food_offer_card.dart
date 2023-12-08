import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/colors/app_colors.dart';

class OfferFoodCard extends StatelessWidget {
  final String img;
  final String name;
  final double price;
  final double priceThreeByTwo;
  final double priceHalf;
  final double priceQuarter;
  final double offerPrice;
  final double offerPriceThreeByTwo;
  final double offerPriceHalf;
  final double offerPriceQuarter;
  final String fullPrsTagName;
  final String threeByTwoPrsName;
  final String halfPrsName;
  final String quarterPrsName;
  final String offerName;
  final String fdIsLoos;

  const OfferFoodCard({
    Key? key,
    required this.img,
    required this.name,
    required this.price,
    required this.offerPrice,
    required this.offerPriceThreeByTwo,
    required this.offerPriceHalf,
    required this.offerPriceQuarter,
    required this.offerName,
    required this.priceThreeByTwo,
    required this.priceHalf,
    required this.priceQuarter,
    required this.fdIsLoos, required this.fullPrsTagName, required this.threeByTwoPrsName, required this.halfPrsName, required this.quarterPrsName
  }) : super(key: key);

  Widget _buildPrice(String label, double originalPrice, double offerPrice,{bool isLoos = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '$label : ',
            style: TextStyle(
              fontSize: isLoos ? 22.sp :18.sp,
              color: AppColors.mainColor_2,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${originalPrice.toStringAsFixed(2)}  ',
            style: TextStyle(
              fontSize: isLoos ? 20.sp : 16.sp,
              color: Colors.grey,
              decoration: offerPrice < originalPrice ? TextDecoration.lineThrough : null,
            ),
          ),
          SizedBox(width: 8.w),
          if (offerPrice < originalPrice)
            Text(
              offerPrice.toStringAsFixed(2),
              style: TextStyle(
                fontSize: 20.sp,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.white,
      margin: EdgeInsets.all(10.w),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                Container(
                  height:fdIsLoos == 'false' ? 250.h : 200.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(15.r)),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(img),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8.h,
                  left: 8.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: 22.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  fdIsLoos == 'false' ? 20.verticalSpace :  10.verticalSpace,
                  Text(
                    offerName,
                    style: TextStyle(
                      fontSize: 25.sp,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  _buildPrice( fdIsLoos == 'false' ? 'Price' : fullPrsTagName, price, offerPrice,isLoos: true),
                  if (fdIsLoos == 'true') ...[
                    _buildPrice(threeByTwoPrsName, priceThreeByTwo, offerPriceThreeByTwo),
                    _buildPrice(halfPrsName, priceHalf, offerPriceHalf),
                    _buildPrice(quarterPrsName, priceQuarter, offerPriceQuarter),
                  ],
                  15.verticalSpace,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
