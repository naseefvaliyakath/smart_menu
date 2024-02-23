import 'package:flutter/material.dart';

class RazorPayPaymentButton extends StatelessWidget {
  final Function onTap;
  final bool disabled; // Add a disabled flag

  const RazorPayPaymentButton({
    super.key,
    required this.onTap,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: disabled ? null : () => onTap(),
      icon: Image.asset('assets/image/razorpay-png.png', height: 28.0),
      label: const Text('Pay with Razorpay'),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black, backgroundColor: Colors.white, disabledForegroundColor: Colors.grey.withOpacity(0.38), disabledBackgroundColor: Colors.grey.withOpacity(0.12),
        elevation: 2,
      ),
    );
  }
}
