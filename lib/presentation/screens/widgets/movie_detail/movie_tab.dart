import 'package:flutter/material.dart';

class MovieTab extends StatelessWidget {
  final String name;
  MovieTab({super.key, required String this.name});

  @override
  Widget build(BuildContext context) {
    return Tab(
      text: name,
    );
  }
}
