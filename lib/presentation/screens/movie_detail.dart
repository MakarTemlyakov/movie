import 'package:flutter/material.dart';
import 'package:moviedb/constants.dart';
import 'package:moviedb/domain/models/movie_cast.dart';
import 'package:moviedb/domain/models/movie_detail.dart';
import 'package:moviedb/domain/models/movie_review.dart';
import 'package:moviedb/internal/repositories/movie/movie_repository.dart';
import 'package:moviedb/presentation/screens/splash_screen.dart';
import 'package:moviedb/presentation/widgets/movie_detail/movie_detail_tab_bar.dart';
import 'package:moviedb/presentation/widgets/movie_detail/reference_info.dart';
import 'package:moviedb/presentation/widgets/movie_title.dart';
import 'package:moviedb/presentation/widgets/rate_info.dart';

class MovieDetailScreen extends StatefulWidget {
  final int id;

  const MovieDetailScreen({super.key, required this.id});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  MovieDetail? movie;
  List<MovieReview>? reviews;
  List<MovieCast>? cast;
  bool isAddedToWatchList = false;

  @override
  void initState() {
    super.initState();
    fetchData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isAddedToWatchList = AppLocal.movieWatchList.contains(widget.id);
      setState(() {});
    });
  }

  void fetchData() async {
    movie = await MovieRepository().getMovieDetail(widget.id);
    reviews = await MovieRepository().getReviewsByMovieId(movie!.id!);
    cast = await MovieRepository().getCastByMovieId(movie!.id!);
    setState(() {});
  }

  void addMovieToWatchList(num movieId, bool isAddedToWatchList) async {
    await MovieRepository().addMovieToWatchList(movieId, isAddedToWatchList);

    setState(() {
      this.isAddedToWatchList = AppLocal.movieWatchList.contains(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return movie != null
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 24),
                  child: IconButton(
                    onPressed: () {
                      addMovieToWatchList(movie!.id!, isAddedToWatchList);
                    },
                    icon: Icon(
                      isAddedToWatchList
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
                        "https://image.tmdb.org/t/p/w500${movie!.backdropPath}",
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
                          padding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          child: RateInfo(rate: movie!.voteAverage),
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
                                "https://image.tmdb.org/t/p/w500${movie!.posterPath}",
                                width: 95,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            MovieTitle(
                              title: movie!.title,
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
                  releaseDate: movie!.releaseDate,
                  timeDelation: movie!.runtime,
                  genres: movie!.genres,
                ),
                SizedBox(
                  height: 15,
                ),
                MovieDetailTabBar(
                  reviews: reviews,
                  about: movie!.overview!,
                  cast: cast!,
                ),
              ],
            ),
          )
        : SplashScreen();
  }
}

class MovieDetailScreenArguments {
  final int id;
  MovieDetailScreenArguments({required this.id});
}
