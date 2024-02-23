import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditNameButton extends StatelessWidget {
  final Function onTap;

  const EditNameButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      child: IconButton(
        icon: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Edit Name'),
            5.horizontalSpace,
            const Icon(
              Icons.edit,
              color: Colors.black54,
              size: 18,
            ),
          ],
        ),
        onPressed: () {
          onTap();
        },
      ),
    );
  }
}
