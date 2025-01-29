import 'package:flutter/material.dart';

class MovieTitle extends StatelessWidget {
  final String title;
  const MovieTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
    );
  }
}
