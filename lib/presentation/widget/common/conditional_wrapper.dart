import 'package:flutter/material.dart';

class ConditionalWrapper extends StatelessWidget {
  final Widget child;
  final bool condition;
  final Widget Function(Widget child) wrapper;

  const ConditionalWrapper({
    Key? key,
    required this.child,
    required this.condition,
    required this.wrapper,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return condition ? wrapper(child) : child;
  }
}
