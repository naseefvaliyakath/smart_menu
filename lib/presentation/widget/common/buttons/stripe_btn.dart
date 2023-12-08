import 'package:flutter/material.dart';

class StripePaymentButton extends StatelessWidget {
  final Function onTap;
  const StripePaymentButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        onTap();
      },
      icon: Image.asset('assets/image/stripe.png', height: 28.0),
      label: const Text('Pay with Stripe'),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black, backgroundColor: Colors.white,
        elevation: 2,
      ),
    );
  }
}
