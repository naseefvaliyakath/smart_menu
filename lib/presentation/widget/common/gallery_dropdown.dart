import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_menu/presentation/controller/home_controller.dart';

class GalleryDropdown extends StatefulWidget {
  const GalleryDropdown({Key? key}) : super(key: key);

  @override
  GalleryDropdownState createState() => GalleryDropdownState();
}

class GalleryDropdownState extends State<GalleryDropdown> {
  List<String?> categories = Get.find<HomeController>().foodGalleryCategory.map((item) => item.name).toList();
  String selectedCategory = Get.find<HomeController>().foodGalleryCategory.isNotEmpty ? (Get.find<HomeController>().foodGalleryCategory.first.name ?? '') : '';



  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.6.sw, // adjust the width here
      padding: EdgeInsets.symmetric(horizontal: 12.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.sp),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedCategory,
          hint: Text(
            selectedCategory,
            style: TextStyle(
              fontSize: 18.sp, // adjust the font size here
              fontWeight: FontWeight.bold, // make the text bold
            ),
          ),
          isExpanded: true,
          items: categories.map((String? value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value ?? '',
                style: TextStyle(
                  fontSize: 18.sp, // adjust the font size here
                  fontWeight: FontWeight.bold, // make the text bold
                ),
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              selectedCategory = newValue ?? '';
              Get.find<HomeController>().filterFoodGalleryByCategory(selectedCategory);
            });
          },
        ),
      ),
    );
  }
}
