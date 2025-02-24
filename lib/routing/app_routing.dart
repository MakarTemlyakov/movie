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

final router = GoRouter(initialLocation: "/", routes: [
  StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      final appBar = _buildAppBar(context, navigationShell.currentIndex);
      return Scaffold(
        appBar: appBar,
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
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppRoutes.search,
            builder: (context, state) => SearchScreen(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppRoutes.watchList,
            builder: (context, state) => WatchListScreen(),
          ),
        ],
      ),
    ],
  ),
]);

AppBar _buildAppBar(BuildContext context, int currentIndex) {
  Color bgTheme = Theme.of(context).scaffoldBackgroundColor;
  switch (currentIndex) {
    case 0:
      return AppBar(
        backgroundColor: bgTheme,
        title: Padding(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: const Text(
            "What do you want to watch?",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Color.fromRGBO(255, 255, 255, 1),
            ),
          ),
        ),
      );
    case 1:
      return AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Search",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(
              right: 15,
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.info_outline),
              style: ButtonStyle(
                iconColor:
                    WidgetStateProperty.all(Color.fromRGBO(255, 255, 255, 1)),
              ),
            ),
          ),
        ],
        leading: Padding(
          padding: EdgeInsets.only(left: 24),
          child: IconButton(
            onPressed: () => router.go(AppRoutes.home),
            icon: Icon(Icons.arrow_back_ios),
            style: ButtonStyle(
              iconColor:
                  WidgetStateProperty.all(Color.fromRGBO(255, 255, 255, 1)),
            ),
          ),
        ),
      );
    case 2:
      return AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Watch list",
          style: TextStyle(
            color: Color.fromRGBO(
              255,
              255,
              255,
              1,
            ),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: Padding(
          padding: EdgeInsets.only(left: 24),
          child: IconButton(
            onPressed: () => router.go(AppRoutes.home),
            icon: Icon(Icons.arrow_back_ios),
            style: ButtonStyle(
              iconColor:
                  WidgetStateProperty.all(Color.fromRGBO(255, 255, 255, 1)),
            ),
          ),
        ),
      );
    default:
      return AppBar(
        title: Text("App"),
      );
  }
}
