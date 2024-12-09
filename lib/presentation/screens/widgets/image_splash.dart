import 'package:flutter/material.dart';

class ImageSplash extends StatelessWidget {
  const ImageSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset('assets/images/splash.png'),
    );
  }
}
