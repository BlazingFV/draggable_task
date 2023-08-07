import 'package:flutter/material.dart';
import 'package:loshical/hugged_child.dart';

class AnswerImage extends StatelessWidget {
  const AnswerImage({super.key, required this.assetPath});
  final String assetPath;
  @override
  Widget build(BuildContext context) {
    return HuggedChild(child: Image.asset(assetPath));
  }
}
