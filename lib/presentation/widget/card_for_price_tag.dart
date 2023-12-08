import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BeautifulStripCard extends StatelessWidget {
  final VoidCallback onTap; // Use VoidCallback for onTap
  final String text;

  const BeautifulStripCard({
    Key? key,
    required this.text,
    required this.onTap, // Receive onTap as a parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                ),
              ),
            ),
            Icon(
              Icons.edit,
              color: Colors.black54,
              size: 20.sp, // Icon size
            ),
            const SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}
