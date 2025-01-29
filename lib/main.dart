import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moviedb/constants.dart';
import 'package:moviedb/internal/repositories/movie/movie_repository.dart';
import 'package:moviedb/internal/shared_preferences_instance.dart';
import 'package:moviedb/presentation/screens/home_screen.dart';
import 'package:moviedb/presentation/screens/movie_detail.dart';
import 'package:moviedb/presentation/screens/saerch_screen.dart';
import 'package:moviedb/presentation/screens/watch_list_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesInstance.init();
  String jsonString = await rootBundle.loadString('secrets.json');
  final jsonResponse = json.decode(jsonString);
  AppLocal.secretModel.fromJson(jsonResponse);
  AppLocal.movieWatchList.addAll(
    (await MovieRepository().getWatchListMovies())?.map((movie) => movie.id) ??
        [],
  );
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
      initialRoute: '/',
      routes: {
        "/": (context) => const HomeScreen(),
        "/watch_list": (context) => const WatchListScreen(),
        "/search": (context) => const SearchScreen(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/movie_detail':
            {
              final args = settings.arguments as MovieDetailScreenArguments;
              return MaterialPageRoute(builder: (context) {
                return MovieDetailScreen(id: args.id);
              });
            }
        }
      },
    );
  }
}
