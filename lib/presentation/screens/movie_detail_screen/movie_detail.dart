import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb/presentation/screens/movie_detail_screen/bloc/movie_detail_screen_bloc.dart';
import 'package:moviedb/presentation/screens/splash_screen.dart';
import 'package:moviedb/presentation/screens/watch_list_screen/bloc/watch_list_screen_bloc_bloc.dart';
import 'package:moviedb/presentation/widgets/movie_detail/movie_detail_tab_bar.dart';
import 'package:moviedb/presentation/widgets/movie_detail/reference_info.dart';
import 'package:moviedb/presentation/widgets/movie_title.dart';
import 'package:moviedb/presentation/widgets/rate_info.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({super.key});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieDetailScreenBloc, MovieDetailScreenState>(
      listener: (context, state) {
        BlocProvider.of<WatchListScreenBlocBloc>(context)
          ..add(OnLoadDataEvent());
      },
      builder: (context, state) {
        return BlocBuilder<MovieDetailScreenBloc, MovieDetailScreenState>(
          builder: (context, state) {
            if (state is MovieDetailsState && state.movie != null) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  centerTitle: true,
                  actions: [
                    Padding(
                      padding: EdgeInsets.only(right: 24),
                      child: IconButton(
                        onPressed: () {
                          BlocProvider.of<MovieDetailScreenBloc>(context)
                            ..add(OnAddMovieToWatchListEvent());
                        },
                        icon: Icon(
                          state.isAddedToWatchList
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                        ),
                        style: ButtonStyle(
                          iconColor: WidgetStateProperty.all(
                              Color.fromRGBO(255, 255, 255, 1)),
                        ),
                      ),
                    ),
                  ],
                  title: Text(
                    "Detail",
                    style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
                  ),
                  leading: Padding(
                    padding: EdgeInsets.only(left: 24),
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back_ios),
                      style: ButtonStyle(
                        iconColor: WidgetStateProperty.all(
                            Color.fromRGBO(255, 255, 255, 1)),
                      ),
                    ),
                  ),
                ),
                body: Column(
                  children: [
                    SizedBox(
                      height: 270,
                      child: Stack(
                        children: [
                          Image.network(
                            "https://image.tmdb.org/t/p/w500${state.movie!.backdropPath}",
                            fit: BoxFit.fill,
                            height: 210,
                            width: double.infinity,
                          ),
                          Positioned(
                            bottom: 70,
                            right: 11,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(37, 40, 54, 32),
                                  borderRadius: BorderRadius.circular(8)),
                              padding: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              child: RateInfo(rate: state.movie!.voteAverage),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 30,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16.0),
                                  child: Image.network(
                                    "https://image.tmdb.org/t/p/w500${state.movie!.posterPath}",
                                    width: 95,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                MovieTitle(
                                  title: state.movie!.title,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    ReferenceInfo(
                      releaseDate: state.movie!.releaseDate,
                      timeDelation: state.movie!.runtime,
                      genres: state.movie!.genres,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    MovieDetailTabBar(
                      reviews: state.reviews,
                      about: state.movie!.overview!,
                      cast: state.cast!,
                    ),
                  ],
                ),
              );
            }
            return SplashScreen();
          },
        );
      },
    );
  }
}

class MovieDetailScreenArguments {
  final int id;
  MovieDetailScreenArguments({required this.id});
}
