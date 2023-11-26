import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropdownFilterWidget<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedItem;
  final String hint;
  final ValueChanged<T?>? onChanged;
  final String Function(T item) itemToString;
  final bool isEnabled;

  const DropdownFilterWidget({
    Key? key,
    required this.items,
    this.selectedItem,
    required this.hint,
    this.onChanged,
    required this.itemToString,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: selectedItem,
      onChanged: isEnabled ? onChanged : null,
      decoration: InputDecoration(
        labelText: hint,
        labelStyle: TextStyle(fontSize: 16.sp),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
      items: items.map((T item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(itemToString(item)),
        );
      }).toList(),
    );
  }
}
