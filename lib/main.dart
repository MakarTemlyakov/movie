import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb/constants.dart';
import 'package:moviedb/internal/repositories/movie/movie_repository.dart';
import 'package:moviedb/internal/shared_preferences_instance.dart';
import 'package:moviedb/presentation/screens/home_screen/bloc/home_bloc.dart';
import 'package:moviedb/presentation/screens/home_screen/home_screen.dart';
import 'package:moviedb/presentation/screens/movie_detail_screen/bloc/movie_detail_screen_bloc.dart';

import 'package:moviedb/presentation/screens/movie_detail_screen/movie_detail.dart';
import 'package:moviedb/presentation/screens/search_screen/bloc/search_screen_bloc_bloc.dart';
import 'package:moviedb/presentation/screens/search_screen/saerch_screen.dart';
import 'package:moviedb/presentation/screens/watch_list_screen/bloc/watch_list_screen_bloc_bloc.dart';
import 'package:moviedb/presentation/screens/watch_list_screen/watch_list_screen.dart';
import 'package:moviedb/presentation/widgets/search_bar/bloc/bloc/search_bloc.dart';
import 'package:moviedb/presentation/widgets/search_bar/search_bar_widget.dart';

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
    final movieRepo = new MovieRepository();
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => HomeBloc(movieRepo)
                ..add(
                  OnLoadMoviesEvent(),
                ),
              child: HomeScreen()),
          BlocProvider(
            create: (context) => SearchBloc(),
            child: SearchBarWidget(),
          ),
          BlocProvider(
            create: (context) => SearchScreenBlocBloc(movieRepo),
            child: SearchScreen(),
          ),
          BlocProvider(
            create: (context) => WatchListScreenBlocBloc(movieRepo)
              ..add(
                OnLoadDataEvent(),
              ),
            child: WatchListScreen(),
          ),
          BlocProvider(
            create: (context) => WatchListScreenBlocBloc(movieRepo)
              ..add(
                OnLoadDataEvent(),
              ),
            child: WatchListScreen(),
          ),
        ],
        child: MaterialApp(
          title: 'Movie',
          theme: ThemeData(
            scaffoldBackgroundColor: const Color.fromRGBO(36, 42, 50, 1),
            useMaterial3: true,
          ),
          initialRoute: '/',
          routes: {
            AppRoutes.home: (context) => HomeScreen(),
            AppRoutes.watchList: (context) => const WatchListScreen(),
            AppRoutes.search: (context) => const SearchScreen(),
          },
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/movie_detail':
                {
                  final args = settings.arguments as MovieDetailScreenArguments;
                  return MaterialPageRoute(builder: (context) {
                    return BlocProvider(
                      create: (context) => MovieDetailScreenBloc(movieRepo)
                        ..add(
                          OnLoadMovieDetailDataEvent(movieId: args.id),
                        ),
                      child: MovieDetailScreen(),
                    );
                  });
                }
            }
            return null;
          },
        ));
  }
}
