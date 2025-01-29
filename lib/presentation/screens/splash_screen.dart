import 'package:flutter/material.dart';
import 'package:moviedb/presentation/widgets/image_splash.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).scaffoldBackgroundColor;
    return Container(
      color: color,
      child: const ImageSplash(),
    );
  }
}
