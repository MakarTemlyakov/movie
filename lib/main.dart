import 'package:flutter/material.dart';
import 'package:moviedb/presentation/screens/home_screen.dart';
import 'package:moviedb/presentation/screens/movie_detail.dart';

void main() {
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(36, 42, 50, 1),
        useMaterial3: true,
      ),
      home: const MovieDetail(),
    );
  }
}
