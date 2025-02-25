import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moviedb/constants.dart';
import 'package:moviedb/internal/repositories/movie/movie_repository.dart';
import 'package:moviedb/presentation/screens/home_screen/home_screen.dart';
import 'package:moviedb/presentation/screens/movie_detail_screen/bloc/movie_detail_screen_bloc.dart';
import 'package:moviedb/presentation/screens/movie_detail_screen/movie_detail.dart';
import 'package:moviedb/presentation/screens/search_screen/saerch_screen.dart';
import 'package:moviedb/presentation/screens/watch_list_screen/watch_list_screen.dart';
import 'package:moviedb/presentation/widgets/bottom_nav_bar.dart';

final router = GoRouter(
  initialLocation: "/",
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return Scaffold(
          body: navigationShell,
          bottomNavigationBar: BottomNavBar(
            navigationShell: navigationShell,
          ),
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
                path: AppRoutes.home,
                builder: (context, state) => HomeScreen(),
                routes: [
                  GoRoute(
                    path: AppRoutes.movieDetails,
                    builder: (context, state) {
                      final movieRepo = new MovieRepository();
                      final args = state.extra as MovieDetailScreenArguments;
                      return BlocProvider(
                        create: (context) => MovieDetailScreenBloc(movieRepo)
                          ..add(
                            OnLoadMovieDetailDataEvent(movieId: args.id),
                          ),
                        child: MovieDetailScreen(),
                      );
                    },
                  ),
                ]),
          ],
        ),
        StatefulShellBranch(routes: [
          GoRoute(
            path: AppRoutes.search,
            builder: (context, state) => SearchScreen(),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: AppRoutes.watchList,
            builder: (context, state) => WatchListScreen(),
          ),
        ]),
      ],
    ),
  ],
);
