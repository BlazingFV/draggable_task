import 'package:flutter/material.dart';
import 'package:loshical/assets.dart';
import 'package:photo_view/photo_view.dart';

class HowToPlayScreen extends StatelessWidget {
  const HowToPlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How to play'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(32),
              child: Text('Double click on the instructions to zoom'),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              child: PhotoView(
                enablePanAlways: true,
                imageProvider: const AssetImage(
                  AssetManager.howto,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
