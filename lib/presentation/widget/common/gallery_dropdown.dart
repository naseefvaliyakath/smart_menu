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
  late Map<int, String> categoriesMap;
  int? selectedCategoryId;

  @override
  void initState() {
    super.initState();
    var categories = Get.find<HomeController>().foodGalleryCategory;
    categoriesMap = { for (var item in categories) (item.id ?? 0): item.name ?? 'Error' };
    selectedCategoryId = categories.isNotEmpty ? categories.first.id : null;
  }

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
        child: DropdownButton<int>(
          value: selectedCategoryId,
          hint: Text(
            categoriesMap[selectedCategoryId] ?? 'Select Category',
            style: TextStyle(
              fontSize: 18.sp, // adjust the font size here
              fontWeight: FontWeight.bold, // make the text bold
            ),
          ),
          isExpanded: true,
          items: categoriesMap.entries.map((entry) {
            return DropdownMenuItem<int>(
              value: entry.key,
              child: Text(
                entry.value,
                style: TextStyle(
                  fontSize: 18.sp, // adjust the font size here
                  fontWeight: FontWeight.bold, // make the text bold
                ),
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              selectedCategoryId = newValue;
              Get.find<HomeController>().filterFoodGalleryByCategory(selectedCategoryId ?? 0);
            });
          },
        ),
      ),
    );
  }
}
