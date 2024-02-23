import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_menu/constants/colors/app_colors.dart';

class DesignSelector extends StatelessWidget {
  final String image1;
  final String image2;
  final String text1;
  final String text2;
  final bool isSelectedDesign1;
  final Function(bool) onSelect;

  const DesignSelector({
    Key? key,
    required this.image1,
    required this.image2,
    required this.text1,
    required this.text2,
    required this.isSelectedDesign1,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _DesignCard(
          image: image1,
          text: text1,
          isSelected: isSelectedDesign1,
          onTap: () => onSelect(true),
        ),
        _DesignCard(
          image: image2,
          text: text2,
          isSelected: !isSelectedDesign1,
          onTap: () => onSelect(false),
        ),
      ],
    );
  }
}

class _DesignCard extends StatelessWidget {
  final String image;
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _DesignCard({
    Key? key,
    required this.image,
    required this.text,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: isSelected ? AppColors.mainColor : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.asset(
                image,
                height: 80, // Reduced height
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.4, // Adjust width as per your requirement
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
