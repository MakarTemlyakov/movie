part of 'movie_detail_screen_bloc.dart';

@immutable
sealed class MovieDetailScreenState {}

final class MovieDetailScreenInitial extends MovieDetailScreenState {}

final class MovieDetailsState extends MovieDetailScreenState {
  final int movieId;
  final MovieDetail? movie;
  final List<MovieReview>? reviews;
  final List<MovieCast>? cast;
  final bool isAddedToWatchList;

  MovieDetailsState({
    required this.movieId,
    required this.movie,
    required this.reviews,
    required this.cast,
    this.isAddedToWatchList = false,
  });

  MovieDetailsState copyWith(
    int? movieId,
    MovieDetail? movie,
    List<MovieReview>? reviews,
    List<MovieCast>? cast,
    bool isAddedToWatchList,
  ) {
    return MovieDetailsState(
      movieId: movieId ?? -1,
      movie: movie ?? this.movie,
      reviews: reviews ?? this.reviews,
      cast: cast ?? this.cast,
      isAddedToWatchList: isAddedToWatchList,
    );
  }
}
