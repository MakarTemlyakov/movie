import 'package:flutter/material.dart';

class MovieDescription extends StatelessWidget {
  final String desription;
  const MovieDescription({super.key, required this.desription});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 29, vertical: 24),
      child: Text(
        desription,
        style: TextStyle(fontSize: 12, color: Colors.white),
      ),
    );
  }
}
