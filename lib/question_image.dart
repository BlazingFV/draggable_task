import 'package:flutter/material.dart';
import 'package:loshical/hugged_child.dart';

class QuestionImage extends StatelessWidget {
  const QuestionImage({super.key, required this.assetPath});
  final String assetPath;
  @override
  Widget build(BuildContext context) {
    return HuggedChild(
        child: Image.asset(
      assetPath,
    ));
  }
}
