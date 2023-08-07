import 'package:flutter/material.dart';

class HuggedChild extends StatelessWidget {
  const HuggedChild({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 70),
      child: child,
    );
  }
}
