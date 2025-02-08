part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class MoviesLoaded extends HomeState {
  final List<Movie> trendMovies;
  final List<Movie> nowPlayingdMovies;
  final List<Movie> popularMovies;
  final List<Movie> topRatedMovies;
  final List<Movie> upComingMovies;

  MoviesLoaded({
    required this.trendMovies,
    required this.nowPlayingdMovies,
    required this.popularMovies,
    required this.topRatedMovies,
    required this.upComingMovies,
  });
}

class SearchMovies extends HomeState {
  final List<Movie> searchMovies;

  SearchMovies({required this.searchMovies});
}
