import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlanExpiredMessage extends StatelessWidget {
  final String? expiryFate;
  final String? planName;
  final bool visible;
  const PlanExpiredMessage({super.key, required this.expiryFate, required this.visible, this.planName});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(color: Colors.black), // Default text style
          children: <TextSpan>[
            TextSpan(text: 'You are already enrolled in '),
            TextSpan(
              text: '$planName',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            TextSpan(text: ' plan. \n Your current plan will expire on '),
            TextSpan(
              text: '${expiryFate?.split('T')[0]}',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            ),
            TextSpan(text: '. \n You may renew or choose a new plan after the expiration.'),
          ],
        ),
      ),
    );
  }
}
