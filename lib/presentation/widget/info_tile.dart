import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoTile extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Widget? trailing;

  const InfoTile({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueGrey),
      title: Text(
        title,
        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        value,
        style: TextStyle(fontSize: 16.sp, color: Colors.grey.shade600),
      ),
      trailing: trailing,
    );
  }
}
